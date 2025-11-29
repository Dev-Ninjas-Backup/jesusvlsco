// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
// import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
// import 'package:jesusvlsco/core/utils/constants/colors.dart';

// class ChatSetting extends StatelessWidget {
//   const ChatSetting({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Custom_appbar(title: 'Chat Settings'),

//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Message notification',
//             style: AppTextStyle.baseTextStyle().copyWith(
//               color: AppColors.primary,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           for (int i = 0; i < 4; i++)
//             _chatSettings(
//               title: 'Enable Message Notifications',
//               subTitle: 'Receive notifications when new messages arrive',
//               isActive: i == 0
//                   ? true
//                   : i == 1
//                   ? false
//                   : i == 2
//                   ? true
//                   : false,
//             ),
//         ],
//       ).paddingAll(16),
//     );
//   }

//   Widget _chatSettings({
//     required String title,
//     required String subTitle,
//     required bool isActive,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xFfE4E5F3))),
//       ),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: AppTextStyle.baseTextStyle().copyWith(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//               ),

//               Text(
//                 subTitle,
//                 style: AppTextStyle.baseTextStyle().copyWith(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textSecondaryGrey,
//                 ),
//               ),
//             ],
//           ),

//           Expanded(
//             child: Switch(
//               value: isActive,
//               onChanged: (bool newValue) {},
//               activeThumbColor: Colors.white,
//               activeTrackColor: AppColors.primary,
//               inactiveThumbColor: Colors.grey,
//               inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
