import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jesusvlsco/core/models/response_data.dart';
import 'package:jesusvlsco/core/services/network_caller.dart';
import 'package:jesusvlsco/core/services/storage_service.dart';
import 'package:jesusvlsco/core/utils/constants/api_constants.dart';
import 'package:logger/logger.dart';

import '../models/assign_shift_model.dart';

/// ProjectApiService handles all project-related API calls
/// This service manages communication with the project endpoints
class ProjectApiService {
  final NetworkCaller _networkCaller = NetworkCaller();
  final Logger _logger = Logger();

  /// Fetch all admin projects with pagination
  /// [page] - Page number (default: 1)
  /// [limit] - Number of projects per page (default: 10)
  /// Returns ResponseData containing project list or error
  Future<ResponseData> getAllAdminProjects({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with query parameters
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.allAdminProjects}?page=$page&limit=$limit';

      _logger.i('Fetching admin projects: Page $page, Limit $limit');

      // Make GET request to fetch projects
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully fetched ${response.responseData['data']['projects'].length} projects',
        );
      } else {
        _logger.e('Failed to fetch projects: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in getAllAdminProjects: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to fetch projects. Please try again.',
      );
    }
  }

  /// Delete project by ID using DELETE method
  /// [projectId] - ID of the project to delete
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> deleteProjectById({required String projectId}) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {id} placeholder with actual project ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.deleteProjectById.replaceAll('{id}', projectId)}';

      _logger.i('Deleting project with ID: $projectId');

      // Make DELETE request
      final ResponseData response = await _networkCaller.deleteRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully deleted project: $projectId');
      } else {
        _logger.e('Failed to delete project: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in deleteProjectById: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to delete project. Please try again.',
      );
    }
  }

  /// Update project title using PATCH method
  /// [projectId] - ID of the project to update
  /// [newTitle] - New title for the project
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> updateProjectTitle({
    required String projectId,
    required String newTitle,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {projectId} placeholder with actual project ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.updateProjectTitle.replaceAll('{projectId}', projectId)}';

      _logger.i('Updating project title: $projectId -> $newTitle');

      // Make PATCH request with new title
      final ResponseData response = await _networkCaller.patchRequest(
        url,
        body: {'title': newTitle},
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully updated project title: $projectId');
      } else {
        _logger.e('Failed to update project title: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in updateProjectTitle: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to update project title. Please try again.',
      );
    }
  }

  /// Search projects with pagination
  /// [keyword] - Search keyword
  /// [page] - Page number (default: 1)
  /// [limit] - Number of projects per page (default: 10)
  /// Returns ResponseData containing search results or error
  Future<ResponseData> searchProjects({
    required String keyword,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with search keyword and pagination
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.searchProject.replaceAll('{keyword}', keyword)}&page=$page&limit=$limit';

      _logger.i('Searching projects: "$keyword" - Page $page, Limit $limit');

      // Make GET request to search projects
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully found ${response.responseData['data']['projects'].length} projects for "$keyword"',
        );
      } else {
        _logger.e('Failed to search projects: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in searchProjects: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to search projects. Please try again.',
      );
    }
  }

  /// Create a new project
  /// [teamId] - ID of the selected team
  /// [managerId] - ID of the selected manager
  /// [title] - Project title/name
  /// [projectLocation] - Project location
  /// Returns ResponseData containing created project data or error
  Future<ResponseData> createProject({
    required String teamId,
    required String managerId,
    required String title,
    required String projectLocation,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL
      final String url = '${ApiConstants.baseurl}${ApiConstants.createProject}';

      // Prepare request body
      final Map<String, String> requestBody = {
        'teamId': teamId,
        'managerId': managerId,
        'title': title,
        'projectLocation': projectLocation,
      };

      _logger.i('Creating project: $title at $projectLocation');

      // Make POST request to create project
      final ResponseData response = await _networkCaller.postRequest(
        url,
        body: requestBody,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully created project: $title');
      } else {
        _logger.e('Failed to create project: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in createProject: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to create project. Please try again.',
      );
    }
  }

  /// Get all teams with pagination
  /// [page] - Page number (default: 1)
  /// [limit] - Number of teams per page (default: 10)
  /// Returns ResponseData containing teams list or error
  Future<ResponseData> getAllTeams({int page = 1, int limit = 10}) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with query parameters
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.getAllTeams}?page=$page&limit=$limit';

      _logger.i('Fetching teams: Page $page, Limit $limit');

      // Make GET request to fetch teams
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully fetched ${response.responseData['data']['teams'].length} teams',
        );
      } else {
        _logger.e('Failed to fetch teams: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in getAllTeams: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to fetch teams. Please try again.',
      );
    }
  }

  /// Get all managers with pagination
  /// [page] - Page number (default: 1)
  /// [limit] - Number of managers per page (default: 10)
  /// Returns ResponseData containing managers list or error
  Future<ResponseData> getAllManagers({int page = 1, int limit = 10}) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with query parameters
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.getAllManager}?page=$page&limit=$limit';

      _logger.i('Fetching managers: Page $page, Limit $limit');

      // Make GET request to fetch managers
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully fetched ${response.responseData['data'].length} managers',
        );
      } else {
        _logger.e('Failed to fetch managers: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in getAllManagers: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to fetch managers. Please try again.',
      );
    }
  }

  /// Get project by ID with full details including assigned employees
  /// [projectId] - ID of the project to fetch
  /// Returns ResponseData containing project details or error
  Future<ResponseData> getProjectById({required String projectId}) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {id} placeholder with actual project ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.getProjectById.replaceAll('{id}', projectId)}';

      _logger.i('Fetching project details for ID: $projectId');

      // Make GET request to fetch project details
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully fetched project details for: $projectId');
      } else {
        _logger.e('Failed to fetch project details: ${response.errorMessage}');
      }

      return response;
    } catch (error) {
      _logger.e('Error in getProjectById: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to fetch project details. Please try again.',
      );
    }
  }

  /// Get all time-off requests with pagination
  /// [page] - Page number (default: 1)
  /// [limit] - Number of requests per page (default: 15)
  /// Returns ResponseData containing time-off requests list or error
  Future<ResponseData> getAllTimeOffRequests({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Construct URL with query parameters
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.allTimeOffRequests}?page=$page&limit=$limit';

      _logger.i('Fetching time-off requests: Page $page, Limit $limit');

      // Make GET request to fetch time-off requests
      final ResponseData response = await _networkCaller.getRequest(
        url,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i(
          'Successfully fetched ${response.responseData['data']?.length ?? 0} time-off requests',
        );
      } else {
        _logger.e(
          'Failed to fetch time-off requests: ${response.errorMessage}',
        );
      }

      return response;
    } catch (error) {
      _logger.e('Error in getAllTimeOffRequests: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to fetch time-off requests. Please try again.',
      );
    }
  }

  /// Update time-off request status (approve or reject)
  /// [requestId] - ID of the time-off request to update
  /// [status] - New status (APPROVED or REJECTED)
  /// [adminNote] - Optional admin note explaining the decision
  /// Returns ResponseData indicating success or failure
  Future<ResponseData> updateTimeOffRequestStatus({
    required String requestId,
    required String status,
    String? adminNote,
  }) async {
    try {
      // Get auth token from storage
      final String? token = await StorageService.getAuthToken();

      // Replace {id} placeholder with actual request ID
      final String url =
          '${ApiConstants.baseurl}${ApiConstants.updateRequestApprovedOrRejected.replaceAll('{id}', requestId)}';

      // Prepare request body
      final Map<String, dynamic> requestBody = {
        'status': status,
        'adminNote': adminNote ?? '',
      };

      _logger.i('Updating time-off request status: $requestId -> $status');

      // Make PATCH request to update request status
      final ResponseData response = await _networkCaller.patchRequest(
        url,
        body: requestBody,
        token: token != null ? 'Bearer $token' : null,
      );

      if (response.isSuccess) {
        _logger.i('Successfully updated time-off request status: $requestId');
      } else {
        _logger.e(
          'Failed to update time-off request status: ${response.errorMessage}',
        );
      }

      return response;
    } catch (error) {
      _logger.e('Error in updateTimeOffRequestStatus: $error');
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: 'Failed to update request status. Please try again.',
      );
    }
  }

  static Future<AssignShiftModel> getAssignShift(String projectId) async {
    try {
      final token = await StorageService.getAuthToken();
      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print('Error: No auth token found');
        }
        return AssignShiftModel(
          success: false,
          message: 'Authentication token is missing',
          data: [],
        );
      }

      final url = Uri.parse(
        '${ApiConstants.baseurl}/shift/assigned-users/$projectId',
      );
      if (kDebugMode) {
        print('Fetching assigned users and shifts for project ID: $projectId');
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          final jsonData = json.decode(response.body);
          if (kDebugMode) {
            print('Response JSON: ${jsonEncode(jsonData)}');
          }
          return AssignShiftModel.fromJson(jsonData);
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing JSON response: $e');
          }
          return AssignShiftModel(
            success: false,
            message: 'Failed to parse response data: $e',
            data: [],
          );
        }
      } else {
        if (kDebugMode) {
          print('HTTP error: Status code ${response.statusCode}');
        }
        return AssignShiftModel(
          success: false,
          message: 'Failed to fetch shifts: HTTP ${response.statusCode}',
          data: [],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shifts: $e');
      }
      return AssignShiftModel(
        success: false,
        message: 'Error fetching shifts: $e',
        data: [],
      );
    }
  }
}
