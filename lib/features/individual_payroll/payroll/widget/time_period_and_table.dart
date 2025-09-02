import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/individual_payroll/payroll/controller/payroll_controller.dart';

class TimePeriodSection extends StatelessWidget {
  final IndividualPayrollController controller;
  const TimePeriodSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Text(
                "Time Period:",
                style: AppTextStyle.f14W400().copyWith(
                  color: const Color(0xFF484848),
                ),
              ),
              SizedBox(width: Sizer.wp(8)),
              Expanded(
                child: InkWell(
                  onTap: controller.selectTimePeriod,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(8),
                      vertical: Sizer.hp(8),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFC8CAE7)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return Text(
                              controller.selectedTimePeriod.value,
                              style: AppTextStyle.f14W400().copyWith(
                                color: const Color(0xFF484848),
                              ),
                            );
                          }),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF484848),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: Sizer.wp(12)),
        Expanded(
          child: InkWell(
            onTap: controller.exportPayroll,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Sizer.wp(8),
                vertical: Sizer.hp(10),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF4E53B1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.file_download,
                    color: Color(0xFF4E53B1),
                    size: 16,
                  ),
                  SizedBox(width: Sizer.wp(4)),
                  Text(
                    "Export",
                    style: AppTextStyle.f14W400().copyWith(
                      color: const Color(0xFF4E53B1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ScheduleTable extends StatelessWidget {
  final IndividualPayrollController controller;
  const ScheduleTable({super.key, required this.controller});

  Widget _buildTableHeader(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: Sizer.hp(8)),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC8CAE7))),
      ),
      child: Text(
        text,
        style: AppTextStyle.f16W600().copyWith(color: const Color(0xFF484848)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text, double width, [Color? textColor]) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: AppTextStyle.f14W400().copyWith(
          color: textColor ?? const Color(0xFF484848),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProjectSelectCell(
    String text,
    double width,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Sizer.wp(8),
            vertical: Sizer.hp(8),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC5C5C5)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppTextStyle.f16W500().copyWith(
                  color: const Color(0xFFB5B5B5),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFFC5C5C5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotesCell(double width, VoidCallback onTap) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Text(
          "View Notes",
          style: AppTextStyle.f16W500().copyWith(
            color: const Color(0xFF4E53B1),
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final ValueNotifier<double> scrollPosition = ValueNotifier(0.0);

    scrollController.addListener(() {
      if (scrollController.hasClients) {
        scrollPosition.value = scrollController.offset;
      }
    });

    return Container(
      height: Sizer.hp(520),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            height: Sizer.hp(55),
            decoration: const BoxDecoration(
              color: Color(0xFF4E53B1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Obx(() {
                return Text(
                  controller.weeklyPeriod.value,
                  style: AppTextStyle.f18W600().copyWith(color: Colors.white),
                );
              }),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: Padding(
                  padding: EdgeInsets.all(Sizer.wp(16)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildTableHeader("Date", 80),
                          _buildTableHeader("Project", 120),
                          _buildTableHeader("Start", 80),
                          _buildTableHeader("End", 80),
                          _buildTableHeader("Total Hours", 90),
                          _buildTableHeader("Daily Total", 82),
                          _buildTableHeader("Weekly Total", 100),
                          _buildTableHeader("Regular", 60),
                          _buildTableHeader("OvertimeX1.5", 106),
                          _buildTableHeader("Notes", 124),
                        ],
                      ),
                      SizedBox(height: Sizer.hp(16)),
                      Expanded(
                        child: Obx(() {
                          return ListView.builder(
                            itemCount: controller.weeklySchedule.length,
                            itemBuilder: (context, index) {
                              final item = controller.weeklySchedule[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: Sizer.hp(16)),
                                child: Row(
                                  children: [
                                    _buildTableCell(
                                      item.date,
                                      80,
                                      const Color(0xFF4E53B1),
                                    ),
                                    _buildProjectSelectCell(
                                      item.projectName,
                                      120,
                                      () => controller.selectProject(item.date),
                                    ),
                                    _buildTableCell(item.startTime, 80),
                                    _buildTableCell(item.endTime, 80),
                                    _buildTableCell(item.totalHours, 90),
                                    _buildTableCell(item.dailyTotal, 82),
                                    _buildTableCell("08:03", 100),
                                    _buildTableCell("--", 60),
                                    _buildTableCell("--", 106),
                                    _buildNotesCell(
                                      124,
                                      () => controller.viewNotes(item.date),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: Sizer.hp(32),
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(26)),
            child: Center(
              child: SizedBox(
                width: 340,
                height: 24,
                child: ValueListenableBuilder<double>(
                  valueListenable: scrollPosition,
                  builder: (context, position, child) {
                    double maxScrollExtent = 0.0;
                    try {
                      if (scrollController.hasClients) {
                        maxScrollExtent =
                            scrollController.position.maxScrollExtent;
                      }
                    } catch (_) {
                      maxScrollExtent = 0.0;
                    }

                    final scrollRatio = maxScrollExtent > 0
                        ? (position.clamp(0.0, maxScrollExtent) /
                              maxScrollExtent)
                        : 0.0;
                    final thumbWidth = 40.0;
                    final trackWidth = 340.0;
                    final availableTrack = trackWidth - thumbWidth;
                    final sliderPosition = scrollRatio * availableTrack;

                    return GestureDetector(
                      onPanUpdate: (details) {
                        if (!scrollController.hasClients ||
                            maxScrollExtent <= 0) {
                          return;
                        }

                        final localDx = details.localPosition.dx;
                        final dragX = localDx - (thumbWidth / 2);
                        final dragRatio =
                            (dragX.clamp(0.0, availableTrack) / availableTrack);
                        final newScrollPosition = dragRatio * maxScrollExtent;

                        scrollController.jumpTo(
                          newScrollPosition.clamp(0.0, maxScrollExtent),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 12,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC8CAE7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          Positioned(
                            left: sliderPosition.clamp(0.0, availableTrack),
                            child: Container(
                              width: thumbWidth,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4E53B1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
