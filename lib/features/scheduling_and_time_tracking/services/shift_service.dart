// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:jesusvlsco/core/services/storage_service.dart';

// class ShiftService {
//   static const String _baseUrl = "https://lgcglobalcontractingltd.com/js";

//   /// Create Shift
//   static Future<Map<String, dynamic>> createShift(Map<String, dynamic> body) async {
//     final token = StorageService.token ?? "";

//     final response = await http.post(
//       Uri.parse("$_baseUrl/shift"),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $token",
//       },
//       body: jsonEncode(body),
//     );

//     if (response.statusCode == 201) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to create shift: ${response.body}");
//     }
//   }
// }
