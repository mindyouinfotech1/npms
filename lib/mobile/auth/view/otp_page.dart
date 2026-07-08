// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
// import '../controller/auth_controller.dart';

// class OtpPage extends StatefulWidget {
//   final String mobile;

//   const OtpPage({
//     super.key,
//     required this.mobile,
//   });

//   @override
//   // State<OtpPage> createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
  


// late AuthController authController;

//   Timer? timer;

//   int seconds = 30;

//   @override
// void initState() {
//   super.initState();

//   authController = Get.find<AuthController>();

//   startTimer();
// }

//   void startTimer() {
//     timer?.cancel();

//     setState(() {
//       seconds = 30;
//     });

//     timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (!mounted) return;

//         if (seconds > 0) {
//           setState(() {
//             seconds--;
//           });
//         } else {
//           timer.cancel();
//         }
//       },
//     );
//   }

  
//   @override
//   void dispose() {
//     timer?.cancel();
//     // otpController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 55,
//       height: 60,
//       textStyle: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: Colors.grey.shade500,
//         ),
//       ),
//     );

//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),

//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [

//             /// Logo
//             Center(
//               child: Image.asset(
//                 "assets/logo.jpeg",
//                 height: 60,
//               ),
//             ),

//             const SizedBox(height: 40),

//             const Text(
//               "Verify OTP",
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 10),

//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     "OTP sent to +91 ${widget.mobile}",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ),

//                 TextButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: const Text("Edit"),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 35),

//             /// OTP Input
//             Center(
//               child: Pinput(
//                controller: authController.otpController,
//                 length: 4,
//                 defaultPinTheme: defaultPinTheme,
//                 focusedPinTheme: defaultPinTheme.copyWith(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                         BorderRadius.circular(14),
//                     border: Border.all(
//                       color: Colors.amber,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 35),

//             SizedBox(
//               width: double.infinity,
//               height: 56,
//               child: ElevatedButton(
//                   onPressed: () {
//                   authController.verifyOtp();
//                 },
//                 child: const Text(
//                   "Verify & Continue",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 25),

//             Container(
//               padding: const EdgeInsets.all(16),

//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius:
//                     BorderRadius.circular(16),
//               ),

//               child: Center(
//                 child: seconds > 0
//                     ? Text(
//                         "Resend OTP in ${seconds}s",
//                         style: const TextStyle(
//                           fontWeight:
//                               FontWeight.w600,
//                         ),
//                       )
//                     : TextButton(
//                         onPressed: () async {

//                         await authController.sendOtp();

//                         startTimer();

//                       },
//                         child: const Text(
//                           "Resend OTP",
//                         ),
//                       ),
//               ),
//             ),

//             const SizedBox(height: 25),

//             Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.center,
//               children: const [

//                 Icon(
//                   Icons.lock_outline,
//                   size: 18,
//                   color: Colors.green,
//                 ),

//                 SizedBox(width: 8),

//                 Text(
//                   "Your mobile number is secure",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }