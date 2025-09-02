import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import '../controller/time_off_requests_controller.dart';

class TimeOffRequestsScreen extends StatelessWidget {
  const TimeOffRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimeOffRequestsController());
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Off Policies',
              style: AppTextStyle.f18W600().copyWith(
                color: const Color(0xFF484848),
              ),
            ),
            SizedBox(height: Sizer.hp(12)),
            Row(
              children: List.generate(4, (i) {
                final p = controller.policies[i];
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: Sizer.wp(2)),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEEF7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          p.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.f12W400().copyWith(
                            color: const Color(0xFF4E53B1),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${p.days} Days',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.f16W600().copyWith(
                            color: const Color(0xFF4E53B1),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: Sizer.hp(24)),
            Text(
              'Requests History',
              style: AppTextStyle.f18W600().copyWith(
                color: const Color(0xFF484848),
              ),
            ),
            SizedBox(height: Sizer.hp(12)),
            _buildRequestsTableWithSlider(context),
            SizedBox(height: Sizer.hp(24)),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsTableWithSlider(BuildContext context) {
    final controller = Get.find<TimeOffRequestsController>();
    final ScrollController scrollController = ScrollController();
    final ValueNotifier<double> scrollPosition = ValueNotifier(0.0);

    scrollController.addListener(() {
      if (scrollController.hasClients) {
        scrollPosition.value = scrollController.offset;
      }
    });

    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 32,
                ),
                child: SizedBox(
                  width: 1000,
                  child: Column(
                    children: [
                      _buildTableHeader(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: controller.requests
                                .map(_buildTableRow)
                                .toList(),
                          ),
                        ),
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

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: const Color(0xFFC8CAE7)),
        ),
      ),
      child: Row(
        children: [
          _headerCell('Date of time off', 140),
          _headerCell('Policy', 150),
          _headerCell('Requested on', 120),
          _headerCell('Total requested', 136),
          _headerCell('Status', 230),
          _headerCell('Notes', 90),
        ],
      ),
    );
  }

  Widget _headerCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.f16W600().copyWith(
            color: const Color(0xFF4E53B1),
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(TimeOffRequest req) {
    Color statusColor;
    Color statusBg;
    switch (req.statusType) {
      case 0:
        statusColor = const Color(0xFF06843F);
        statusBg = const Color(0xFFD9F0E3);
        break;
      case 1:
        statusColor = const Color(0xFFDC1E28);
        statusBg = const Color(0xFFFFE6E7);
        break;
      case 2:
        statusColor = const Color(0xFFFFBA5C);
        statusBg = const Color(0xFFFFEFD8);
        break;
      case 3:
        statusColor = const Color(0xFF06843F);
        statusBg = const Color(0xFFD9F0E3);
        break;
      default:
        statusColor = const Color(0xFF484848);
        statusBg = Colors.transparent;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: const Color(0xFFC8CAE7)),
        ),
      ),
      child: Row(
        children: [
          _cell(req.date, 140),
          _cell(req.policy, 150),
          _cell(req.requestedOn, 120),
          _cell(req.totalRequested, 136),
          Container(
            width: 230,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                req.status,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.f14W400().copyWith(color: statusColor),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                req.notes,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.f16W500().copyWith(
                  color: const Color(0xFF4E53B1),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cell(String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyle.f14W400().copyWith(
            color: const Color(0xFF484848),
          ),
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
        'Time Off Requests',
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
