import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/response_data.dart';

class NetworkCaller {
  final int timeoutDuration = 10;

  // GET method
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log('GET Request: $url');
    log('GET Token: $token');
    try {
      final http.Response response = await http
          .get(
            Uri.parse(url),
            headers: {
              if (token != null)
                'Authorization': token.startsWith('Bearer ')
                    ? token
                    : 'Bearer $token',
              'Content-type': 'application/json',
            },
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST method
  Future<ResponseData> postRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log('POST Request: $url');
    try {
      final encoded = body != null ? jsonEncode(body) : null;
      log('Request Body: $encoded');

      final http.Response response = await http
          .post(
            Uri.parse(url),
            headers: {
              if (token != null)
                'Authorization': token.startsWith('Bearer ')
                    ? token
                    : 'Bearer $token',
              'Content-type': 'application/json',
            },
            body: encoded,
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // PATCH method
  Future<ResponseData> patchRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    log('PATCH Request: $url');
    try {
      final encoded = body != null ? jsonEncode(body) : null;
      log('Request Body: $encoded');

      final http.Response response = await http
          .patch(
            Uri.parse(url),
            headers: {
              if (token != null)
                'Authorization': token.startsWith('Bearer ')
                    ? token
                    : 'Bearer $token',
              'Content-type': 'application/json',
            },
            body: encoded,
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // DELETE method
  Future<ResponseData> deleteRequest(String url, {String? token}) async {
    log('DELETE Request: $url');
    log('DELETE Token: $token');
    try {
      final http.Response response = await http
          .delete(
            Uri.parse(url),
            headers: {
              if (token != null)
                'Authorization': token.startsWith('Bearer ')
                    ? token
                    : 'Bearer $token',
              'Content-type': 'application/json',
            },
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Multipart POST (for file uploads + form fields)
  Future<ResponseData> postMultipart(
    String url, {
    Map<String, String>? fields,
    String? token,
    String? filePath,
    String fileField = 'profileUrl',
  }) async {
    log('POST Multipart Request: $url');
    log('Fields: ${jsonEncode(fields)}');
    try {
      final uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri);

      // Attach token header if provided
      if (token != null) {
        request.headers['Authorization'] = token.startsWith('Bearer ')
            ? token
            : 'Bearer $token';
      }

      // Add fields
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Attach file if exists
      if (filePath != null && filePath.isNotEmpty) {
        final file = File(filePath);
        if (await file.exists()) {
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          final multipartFile = http.MultipartFile(
            fileField,
            stream,
            length,
            filename: file.uri.pathSegments.last,
          );
          request.files.add(multipartFile);
        }
      }

      final streamedResponse = await request.send().timeout(
        Duration(seconds: timeoutDuration),
      );

      final responseBody = await streamedResponse.stream.bytesToString();
      final http.Response response = http.Response(
        responseBody,
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Handle response
  ResponseData _handleResponse(http.Response response) {
    log('Response Status: ${response.statusCode}');
    log('Response Body: ${response.body}');

    final decodedResponse = jsonDecode(response.body);

    // Treat any 2xx status as success unless the server explicitly returns success: false
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decodedResponse is Map && decodedResponse['success'] == false) {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['message'] ?? 'Unknown error occurred',
        );
      }

      return ResponseData(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: '',
      );
    } else if (response.statusCode == 400) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: _extractErrorMessages(decodedResponse['errorSources']),
      );
    } else if (response.statusCode == 500) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
        errorMessage:
            decodedResponse['message'] ?? 'An unexpected error occurred!',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: decodedResponse['message'] ?? 'An unknown error occurred',
      );
    }
  }

  // Extract error messages for status 400
  String _extractErrorMessages(dynamic errorSources) {
    if (errorSources is List) {
      return errorSources
          .map((error) => error['message'] ?? 'Unknown error')
          .join(', ');
    }
    return 'Validation error';
  }

  // Handle errors
  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error occurred. Please check your connection.',
      );
    } else if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred.',
      );
    }
  }
}
