// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:get/get.dart';
// import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
// import 'package:jesusvlsco/core/utils/constants/colors.dart';
// import 'package:jesusvlsco/core/utils/constants/sizer.dart';
// import 'package:jesusvlsco/features/auth/controller/phone_controller.dart';

// // Text constants class

// class EmailotpverifyMethod extends StatefulWidget {
//   const EmailotpverifyMethod({Key? key}) : super(key: key);

//   @override
//   State<EmailotpverifyMethod> createState() => _EmailotpverifyMethodState();
// }

// class _EmailotpverifyMethodState extends State<EmailotpverifyMethod> {
//   CountryCode _selectedCountryCode = CountryCode.fromCountryCode('BD');
//   final Numbercontroller _numbercontroller = Get.put(Numbercontroller());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(gradient: AppColors.loginGradient),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Main content
//               Expanded(
//                 child: Padding(
//                   padding: Sizer.defaultPadding,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Login Card
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(32),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 20,
//                               offset: const Offset(0, 10),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             // Welcome title
//                             const Text(
//                               AppText.verifyEmail,
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF6B5B95),
//                               ),
//                             ),
//                             const SizedBox(height: 8),

//                             // Subtitle
//                             const Text(
//                               AppText.enterEmail,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: AppColors.color3,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             // Verify button
//                             GestureDetector(
//                               onTap: () {
//                                 // Add your onTap logic here
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.backgroundLight,
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                     color: AppColors.color1,
//                                     width: 0.5,
//                                   ),
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   "Email",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.backgroundDark,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 22),
//                             // Verify button
//                             SizedBox(
//                               width: double.infinity,
//                               height: 50,
//                               child: CupertinoButton(
//                                 onPressed: () {
//                                   Get.toNamed(AppRoute.getemailotpverify());
//                                 },

//                                 color: AppColors.color1,
//                                 child: const Text(
//                                   "Verify",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.backgroundLight,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
