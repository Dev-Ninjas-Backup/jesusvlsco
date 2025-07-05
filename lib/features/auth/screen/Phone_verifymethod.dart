// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:get/get.dart';
// import 'package:jesusvlsco/core/utils/constants/app_texts.dart';
// import 'package:jesusvlsco/core/utils/constants/colors.dart';
// import 'package:jesusvlsco/core/utils/constants/sizer.dart';
// import 'package:jesusvlsco/features/auth/controller/phone_controller.dart';
// import 'package:jesusvlsco/routes/app_routes.dart';

// // Text constants class

// class Phoneverifymethod extends StatefulWidget {
//   const Phoneverifymethod({Key? key}) : super(key: key);

//   @override
//   State<Phoneverifymethod> createState() => _PhoneverifymethodState();
// }

// class _PhoneverifymethodState extends State<Phoneverifymethod> {
  
//   CountryCode _selectedCountryCode = CountryCode.fromCountryCode('BD');
// final Numbercontroller _numbercontroller = Get.put(Numbercontroller());
//   @override   
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient:AppColors.loginGradient
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
             
//               // Main content
//               Expanded(
//                 child: Padding(
//                   padding:  Sizer.defaultPadding,
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
//                              AppText.welcome,
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF6B5B95),
//                               ),
//                             ),
//                             const SizedBox(height: 8),
                            
//                             // Subtitle
//                             const Text(
//                              AppText.loginToProfile,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: AppColors.color3,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(height: 32),
                            
//                             // Phone input field
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: AppColors.color1),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Row(
//                                 children: [
//                                   // Country code picker
//                                   CountryCodePicker(
//                                     onChanged: (CountryCode countryCode) {
//                                       setState(() {
//                                         _selectedCountryCode = countryCode;
//                                       });
//                                     },
//                                     initialSelection: 'BD',
//                                     favorite: const ['+880', 'BD'],
//                                     showCountryOnly: false,
//                                     showOnlyCountryWhenClosed: true,
//                                     alignLeft: false,
//                                     showDropDownButton: true,
//                                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                                     textStyle: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                     dialogTextStyle: const TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                     searchStyle: const TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                     ),
//                                     searchDecoration: const InputDecoration(
//                                       hintText: 'Search country',
//                                       border: OutlineInputBorder(),
//                                     ),
//                                     dialogSize: Size(
//                                       MediaQuery.of(context).size.width * 0.8,
//                                       MediaQuery.of(context).size.height * 0.6,
//                                     ),
//                                     builder: (CountryCode? countryCode) {
//                                       return Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 12,
//                                           vertical: 16,
//                                         ),
                                       
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               countryCode?.code ?? 'BD',
//                                               style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 4),
//                                             Icon(
//                                               Icons.arrow_drop_down,
//                                               color: AppColors.color3,
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
                                  
//                                   // Phone number input
//                                   Expanded(
//                                     child: TextField(
                                     
//                                       controller: _numbercontroller.phoneController,
//                                       keyboardType: TextInputType.phone,
//                                       inputFormatters: [
//                                         FilteringTextInputFormatter.digitsOnly,
//                                         LengthLimitingTextInputFormatter(15),
//                                       ],
//                                       decoration: InputDecoration(
//                                       enabledBorder: InputBorder.none,
//                                         hintText: _selectedCountryCode.dialCode ?? '+880',
//                                         hintStyle: TextStyle(
//                                           color:  AppColors.color3,
//                                           fontSize: 16,
//                                         ),
                                        
//                                         contentPadding: const EdgeInsets.symmetric(
//                                           horizontal: 12,
//                                           vertical: 16,
//                                         ),
//                                       ),
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 16),
                            
//                             // Info text
//                             const Text(
//                             AppText.verifyNumberMessage,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: AppColors.color3
//                               ),
//                             ),
//                             const SizedBox(height: 24),
                            
//                             // Verify button
//                             SizedBox(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                    // Handle phone number login
//                                   _numbercontroller.validatePhoneNumber();
                        
//                                  },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:  AppColors.color1,
//                                   elevation: 0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                  AppText.verify,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.textWhite
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