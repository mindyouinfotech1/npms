// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;


// import 'package:shared_preferences/shared_preferences.dart';

// import '../../mobile/auth/view/login_page.dart';
// import '../controllers/global_loader_controller.dart';


// class ApiService {
//   static const String webBaseUrl =
//       'https://rent.ikrajindustries.com/';
//   static const String baseUrl =
//       'https://rent.ikrajindustries.com/api/v1/';

//   static String token = '';
//   static bool _hasShownSessionExpired = false; // track if message shown

//   // ---------- AUTH ----------
//   static const String sendOTPLogin = 'user-send-otp';

  

//   // ---------- HEADERS ----------
//   static Future<Map<String, String>> getHeaders({String? token}) async {
//     final prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('bearerToken');

//     return {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'X-API-Key': 'RENTLOCO_APP_2026',
//     };
//   }

//   // ---------- GET ----------
//   static Future<http.Response> get(String endpoint, {String? token}) async {
//     final loader = Get.find<GlobalLoaderController>();

//     try {
//       Future.microtask(() => loader.show()); //

//       final url = Uri.parse(baseUrl + endpoint);
//       final response = await http.get(
//         url,
//         headers: await getHeaders(token: token),
//       );

//       await checkForTokenExpiry(response);
//       return response;
//     } finally {
//       Future.microtask(() => loader.hide()); //
//     }
//   }

//   // ---------- POST ----------
//   static Future<http.Response> post(
//     String endpoint,
//     Map<String, dynamic> body, {
//     String? token,
//   }) async {
//     final loader = Get.find<GlobalLoaderController>();

//     try {
//       loader.show(); //  START LOADER

//       final url = Uri.parse(baseUrl + endpoint);
//       final response = await http.post(
//         url,
//         headers: await getHeaders(token: token),
//         body: jsonEncode(body),
//       );

//       await checkForTokenExpiry(response);
//       return response;
//     } finally {
//       loader.hide(); //  STOP LOADER
//     }
//   }

//   // ---------- MULTIPART ----------
//   // static Future<http.Response> multipartPost({
//   //   required String endpoint,
//   //   required List<http.MultipartFile> files,
//   //   required Map<String, String> fields,
//   // }) async {
//   //   final loader = Get.find<GlobalLoaderController>();

//   //   try {
//   //     loader.show(); // ✅ START LOADER

//   //     final url = Uri.parse(baseUrl + endpoint);

//   //     var request = http.MultipartRequest('POST', url);
//   //     request.fields.addAll(fields);
//   //     request.files.addAll(files);

//   //     final headers = await getHeaders();
//   //     headers.remove('Content-Type');
//   //     request.headers.addAll(headers);

//   //     final streamedResponse = await request.send();
//   //     final response = await http.Response.fromStream(streamedResponse);

//   //     await checkForTokenExpiry(response);

//   //     return response;
//   //   } finally {
//   //     loader.hide(); // ✅ STOP LOADER
//   //   }
//   // }

//   static Future<http.Response> multipartPost({
//     required String endpoint,
//     required List<http.MultipartFile> files,
//     required Map<String, String> fields,
//   }) async {
//     final loader = Get.find<GlobalLoaderController>();

//     try {
//       loader.show();

//       final url = Uri.parse(baseUrl + endpoint);

//       var request = http.MultipartRequest('POST', url);

//       request.fields.addAll(fields);
//       request.files.addAll(files);

//       final headers = await getHeaders();
//       headers.remove('Content-Type');
//       request.headers.addAll(headers);

//       //  PRINT DEBUG INFO
//       print("========== MULTIPART DEBUG ==========");
//       print("URL => $url");
//       print("HEADERS => ${request.headers}");
//       print("FIELDS => ${request.fields}");
//       print("FILES COUNT => ${request.files.length}");
//       for (var f in request.files) {
//         print("FILE => ${f.field} | ${f.filename}");
//       }
//       print("=====================================");

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       print("STATUS CODE => ${response.statusCode}");
//       print("RAW BODY => ${response.body}");

//       await checkForTokenExpiry(response);

//       return response;
//     } finally {
//       loader.hide();
//     }
//   }

//   // ---------- TOKEN EXPIRY CHECK ----------
//   static Future<void> checkForTokenExpiry(http.Response response) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final storedToken = prefs.getString('bearerToken');

//       // Don't show message if no token exists (fresh install)
//       if (storedToken == null || storedToken.isEmpty) return;

//       final data = jsonDecode(response.body);
//       final message = (data['message'] ?? '').toString().toLowerCase();

//       if ((response.statusCode == 401 ||
//               message.contains('token expired') ||
//               message.contains('token is invalid') ||
//               message.contains('unauthorized')) &&
//           !_hasShownSessionExpired) {
//         _hasShownSessionExpired = true; // mark as shown

//         // Clear session
//         await prefs.clear();

//         // Redirect to login
//         Future.microtask(() {
//           if (Get.currentRoute != '/login') {
//             Get.offAll(() => OfficerLoginPage());
//           }

//           // Show snackbar only once
//           Get.snackbar(
//             'Session Expired',
//             'Your session has expired. Please login again.',
//             snackPosition: SnackPosition.TOP,
//             backgroundColor: Colors.redAccent,
//             colorText: Colors.white,
//             duration: const Duration(seconds: 3),
//           );
//         });
//       }
//     } catch (e) {
//       debugPrint(' Token check failed: $e');
//     }
//   }
// }
