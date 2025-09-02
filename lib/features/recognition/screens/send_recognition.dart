import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/recognition/controllers/recognition_controller.dart';
import 'package:jesusvlsco/features/recognition/widgets/horizontal_stepper.dart';

class SendRecognition extends StatefulWidget {
  const SendRecognition({super.key});

  @override
  State<SendRecognition> createState() => _SendRecognitionState();
}

class _SendRecognitionState extends State<SendRecognition> {
  final RecognitionController controller = Get.put(RecognitionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              // Obx listens to changes in controller.currentStep and rebuilds the widget accordingly
              return SizedBox(
                width: double.infinity,
                child: HorizontalStepper(
                  onCancel: () {
                    controller.cancel();
                  },
                  onNextStep: () {
                    controller.nextStep();
                  },
                  currentStep: controller
                      .currentStep
                      .value, // Access the value using `.value` for reactive variable
                  steps: [
                    controller.steps[0],
                    controller.steps[1],
                    controller.steps[2],
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.1,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: AppColors.backgroundDark,
          size: Sizer.wp(24),
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        'Send Recognition',
        style: TextStyle(
          fontSize: Sizer.wp(20),
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            CupertinoIcons.bars,
            color: AppColors.backgroundDark,
            size: Sizer.wp(24),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
