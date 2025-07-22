import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class HorizontalStepper extends StatelessWidget {
  final int currentStep;
  final List<Widget> steps; // List of widgets for each step
  final VoidCallback onNextStep; // Callback for next step
  final VoidCallback onCancel; // Callback for cancel

  const HorizontalStepper({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.onNextStep,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Sizer.hp(16), bottom: Sizer.hp(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                currentStep > 0
                    ? cutombutton(
                        width: Sizer.wp(150),
                        textcolor: AppColors.primary,
                        text: "Badge library",
                        bgcolor: Colors.transparent,
                        brcolor: AppColors.primary,
                        onPressed: onCancel,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          // Row for step circles and separators
          Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                // Step circle
                int stepIndex = index ~/ 2;
                bool isActive = stepIndex <= currentStep;
                return Container(
                  width: Sizer.wp(16),
                  height: Sizer.hp(16),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              } else {
                // Separator between circles
                int stepIndex = index ~/ 2;
                bool isActive = stepIndex < currentStep;
                return Expanded(
                  child: Container(
                    height: Sizer.hp(4),
                    color: isActive ? AppColors.color4 : AppColors.color4,
                  ),
                );
              }
            }),
          ),
          const SizedBox(height: 8),
          // Row for step titles
          // Row for step titles
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recipients", // Fixed title for Step 1
                  textAlign: TextAlign.start,
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(14),
                    fontWeight: FontWeight.w400,
                    color: currentStep >= 0
                        ? AppColors.textPrimary
                        : AppColors.border2, // Highlight the current step
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Create recognition", // Fixed title for Step 2
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(14),
                    fontWeight: FontWeight.w400,
                    color: currentStep >= 1
                        ? AppColors.textPrimary
                        : AppColors.border2, // Highlight the current step
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Summery", // Fixed title for Step 3
                  textAlign: TextAlign.end,
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(14),
                    fontWeight: FontWeight.w400,
                    color: currentStep >= 2
                        ? AppColors.textPrimary
                        : AppColors.border2, // Highlight the current step
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // If the currentStep is within valid range, show the corresponding step
          currentStep >= 0 && currentStep < steps.length
              ? Column(
                  children: [
                    steps[currentStep], // Display the widget corresponding to the current step
                  ],
                )
              : SizedBox(), // Empty widget if the step is invalid (less than 0)

          const SizedBox(height: 20),
          // Row with Cancel and Next Step buttons
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: cutombutton(
                  textcolor: AppColors.primary,
                  text: "Cancel",
                  bgcolor: Colors.transparent,
                  brcolor: AppColors.primary,
                  onPressed: onCancel,
                ),
              ),
              SizedBox(width: Sizer.wp(16)),
              // Next Step button
              Flexible(
                child: cutombutton(
                  textcolor: AppColors.textWhite,
                  text: "Next Step",
                  bgcolor: AppColors.primary,
                  brcolor: AppColors.primary,
                  onPressed: onNextStep,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget cutombutton({
  Color? bgcolor,
  Color? brcolor,
  String? text,
  Color? textcolor,
  VoidCallback? onPressed,
  double? width,
}) {
  return SizedBox(
    width: width,
    height: Sizer.hp(40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: brcolor!, width: 1),
          borderRadius: BorderRadius.circular(Sizer.wp(8)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text!,
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(16),
          color: textcolor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
