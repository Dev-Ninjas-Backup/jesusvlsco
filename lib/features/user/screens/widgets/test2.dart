import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';


// AppColors class for consistent color management
class AppColors {
  static const Color primary = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF6B7280);
  static const Color text = Color(0xFF374151);
  static const Color textLight = Color(0xFF6B7280);
  static const Color background = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color blue = Color(0xFF3B82F6);
  static const Color red = Color(0xFFDC2626);
  static const Color success = Color(0xFF10B981);
}

// AppTextStyle class for consistent typography with singleton pattern
// class AppTextStyle {
//   // singleton
//   AppTextStyle._();
  
//   static TextStyle baseTextStyle({
//     TextStyle? fontFamily,
//     double fontSize = 14.0,
//     FontWeight fontWeight = FontWeight.w400,
//   }) {
//     final textStyle = fontFamily ?? GoogleFonts.inter();
//     return textStyle.copyWith(
//       color: AppColors.primary,
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       height: 1.43,
//     );
//   }

//   static TextStyle textlarge({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(32),
//     fontWeight: FontWeight.w600,
//   );

//   static TextStyle textbold({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(17),
//     fontWeight: FontWeight.w400,
//   );
  
//   static TextStyle semibold({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(18),
//     fontWeight: FontWeight.w600,
//   );
  
//   static TextStyle regular({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(16),
//     fontWeight: FontWeight.w400,
//   );
  
//   static TextStyle semiregular({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(14),
//     fontWeight: FontWeight.w400,
//   );

//   // Custom styles for dropdowns and alerts
//   static TextStyle dropdownText({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(14),
//     fontWeight: FontWeight.w400,
//   ).copyWith(color: AppColors.text);
  
//   static TextStyle alertTitle({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(16),
//     fontWeight: FontWeight.w600,
//   ).copyWith(color: AppColors.text);
  
//   static TextStyle alertBody({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(14),
//     fontWeight: FontWeight.w400,
//   ).copyWith(color: AppColors.textLight);
  
//   static TextStyle buttonText({TextStyle? fontFamily}) => baseTextStyle(
//     fontFamily: fontFamily,
//     fontSize: Sizer.wp(14),
//     fontWeight: FontWeight.w500,
//   ).copyWith(color: AppColors.white);
// }

class DropdownAlertPage extends StatefulWidget {
  const DropdownAlertPage({Key? key}) : super(key: key);

  @override
  State<DropdownAlertPage> createState() => _DropdownAlertPageState();
}

class _DropdownAlertPageState extends State<DropdownAlertPage> {
  // Team selection state
  Map<String, bool> teamSelection = {
    'All Team': true,
    'Team A': false,
    'Team B': false,
    'Team C': false,
    'Team D': false,
  };

  // Category selection state
  Map<String, bool> categorySelection = {
    'Category wise': false,
    'Team wise': false,
  };

  // Policy selection state
  Map<String, bool> policySelection = {
    'All category': false,
    'Safety & compliance update': false,
    'Labour & workforce updates': false,
    'New leave policy update': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Dropdown & Alert Demo', style: AppTextStyle.semibold()),
        backgroundColor: AppColors.white,
        elevation: 1,
        foregroundColor: AppColors.text,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Selection Dropdown
            _buildDropdownSection(
              'Team Selection',
              teamSelection,
              (key, value) {
                setState(() {
                  if (key == 'All Team') {
                    // If "All Team" is selected, deselect others
                    teamSelection = teamSelection.map((k, v) => MapEntry(k, k == 'All Team' ? value : false));
                  } else {
                    // If any other team is selected, deselect "All Team"
                    teamSelection['All Team'] = false;
                    teamSelection[key] = value;
                  }
                });
              },
            ),
            SizedBox(height: 4),
            
            // Alert Dialog Button
            _buildAlertButton(),
            SizedBox(height: 4),
            
            // Category Selection Dropdown
            _buildDropdownSection(
              'Category Selection',
              categorySelection,
              (key, value) {
                setState(() {
                  categorySelection[key] = value;
                });
              },
            ),
            SizedBox(height: 4),
            
            // Policy Selection Dropdown
            _buildDropdownSection(
              'Policy Selection',
              policySelection,
              (key, value) {
                setState(() {
                  policySelection[key] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSection(
    String title,
    Map<String, bool> selections,
    Function(String, bool) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.semibold()),
        SizedBox(height: 2),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: selections.entries.map((entry) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.border,
                      width: entry.key != selections.keys.last ? 1 : 0,
                    ),
                  ),
                ),
                child: CheckboxListTile(
                  value: entry.value,
                  onChanged: (value) => onChanged(entry.key, value ?? false),
                  title: Text(
                    entry.key,
                    style: AppTextStyle.semiregular(),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.blue,
                  checkColor: AppColors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0.5),
                  dense: true,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAlertButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Alert Demo', style: AppTextStyle.semibold()),
        SizedBox(height: 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _showDeleteAlert,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Show Delete Alert', style: AppTextStyle.semibold()),
          ),
        ),
      ],
    );
  }

  void _showDeleteAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 80,
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close Icon
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColors.red,
                    size: 6,
                  ),
                ),
                SizedBox(height: 3),
                
                // Alert Title
                Text(
                  'Are you sure?',
                  style: AppTextStyle.semibold().copyWith(color: AppColors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2),
                
                // Alert Body
                Text(
                  'Do you really want to delete these records? This process cannot be undone.',
                  style: AppTextStyle.semibold(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Add delete logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          padding: EdgeInsets.symmetric(vertical: 2.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Delete', style: AppTextStyle.semibold()),
                      ),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.text,
                          padding: EdgeInsets.symmetric(vertical: 2.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(color: AppColors.border),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTextStyle.semibold().copyWith(color: AppColors.text),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Usage example in main.dart
