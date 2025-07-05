// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
// import 'package:jesusvlsco/core/utils/constants/colors.dart';
// import 'package:jesusvlsco/core/utils/constants/sizer.dart';
// import 'package:jesusvlsco/core/utils/device/device_utility.dart';
// import 'package:jesusvlsco/features/auth/screen/verification_complete.dart';
// import 'package:jesusvlsco/routes/app_routes.dart';

// class Phoneotpverify extends StatefulWidget {
//   const Phoneotpverify({Key? key}) : super(key: key);

//   @override
//   State<Phoneotpverify> createState() => _PhoneotpverifyState();
// }

// class _PhoneotpverifyState extends State<Phoneotpverify> {
//   final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
 
//   @override
//   void initState() {
//     super.initState();
//     // Auto-focus on first field
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _focusNodes[0].requestFocus();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//        double screenHeight = AppDeviceUtility.getScreenHeight();
//     double screenWidth = AppDeviceUtility.getScreenWidth(context);
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: AppColors.loginGradient,
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
            
//                // Main content inside a responsive container
//                   Padding(
//                     padding:  Sizer.defaultPadding,
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding inside the container
//                       decoration: BoxDecoration(
//                         color: AppColors.backgroundLight,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           // Title
//                           Text(
//                             AppText.enterDigitCode,
//                             style: TextStyle(
//                               fontSize: screenWidth * 0.05, // Responsive font size
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.color3,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                            "${AppText.sentTo}+91 1234567890" ,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 14, // Responsive font size
//                               color: AppColors.color3,
//                             ),
//                           ),
//                           const SizedBox(height: 40),
                    
//                           // OTP Input Fields
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(4, (index) => _buildOTPField(index)),
//                           ),
//                           const SizedBox(height: 22),
//                     Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(AppText.didntGet,style: TextStyle(fontSize: 14,color: AppColors.textSecondary),),
//                       Text(AppText.moreOptions,style: TextStyle(fontSize: 16,color: AppColors.color1,fontWeight: FontWeight.bold),),
//                     ],
//                   ),
//                    const SizedBox(height: 22),
//                           // Verify Button
//                           SizedBox(
//                             width: double.infinity,
//                             height: 50,    
//                             child: ElevatedButton(
//                               onPressed: (){
                              
//                             Get.to(VerificationComplete());
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.color1,
//                                 foregroundColor: Colors.white,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide.none,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: Text(
                                
//                                 AppText.verify,
//                                 style: TextStyle(
//                                   fontSize: screenWidth * 0.04, // Responsive font size for button text
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.textWhite,
//                                 ),
//                               ),
//                             ),
//                           ),
//                                  const SizedBox(height: 32),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOTPField(int index) {
//     return Container(
//       width: 50,
//       height: 50,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.color3, width: 1),
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         controller: _controllers[index],
//         focusNode: _focusNodes[index],
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           color: Colors.black87,
//         ),
//         decoration: const InputDecoration(

//   border: InputBorder.none,
//   focusedBorder: InputBorder.none,
//   disabledBorder: InputBorder.none,
//   enabledBorder: InputBorder.none,
//           counterText: '',
//           contentPadding: EdgeInsets.zero,
//         ),
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         onChanged: (value) => _handleOTPInput(index, value),
//         onTap: () => _controllers[index].selection = TextSelection.fromPosition(
//           TextPosition(offset: _controllers[index].text.length),
//         ),
//       ),
//     );
//   }

//   void _handleOTPInput(int index, String value) {
//     if (value.isNotEmpty) {
//       // Move to next field
//       if (index < 3) {
//         _focusNodes[index + 1].requestFocus();
//       } else {
//         // Last field, remove focus
//         _focusNodes[index].unfocus();
//       }
//     } else {
//       // Move to previous field on backspace
//       if (index > 0) {
//         _focusNodes[index - 1].requestFocus();
//       }
//     }
//   }

//   void _handleVerification() {
//     // Just a placeholder for the verification logic
//     // Here you would handle your verification logic or navigate
//     print("OTP Verified");
//   }
// }
