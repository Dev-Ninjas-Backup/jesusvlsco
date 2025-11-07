import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizer.dart';

/// A reusable horizontal scroll slider widget that synchronizes with a ScrollController.
/// This widget automatically updates its position when the scroll view is scrolled
/// and allows users to drag the slider to scroll the content.
class HorizontalScrollSlider extends StatelessWidget {
  /// The ScrollController that this slider will be synchronized with
  final ScrollController scrollController;

  /// Current scroll position (reactive variable from GetX controller)
  final RxDouble scrollPosition;

  /// Maximum scroll extent (reactive variable from GetX controller)
  final RxDouble maxScrollExtent;

  /// Callback function when user drags the slider
  final Function(double value) onSliderDrag;

  /// Height of the slider handler (default: 24)
  final double? handlerHeight;

  /// Width of the slider handler (default: 40)
  final double? handlerWidth;

  /// Touch size for better user interaction (default: 20)
  final double? touchSize;

  /// Height of the track bar (default: 12)
  final double? trackBarHeight;

  /// Color of the track bar (default: AppColors.color4)
  final Color? trackColor;

  /// Color of the slider handler/thumb (default: AppColors.primary)
  final Color? handlerColor;

  /// Padding around the slider (default: horizontal 16, vertical 8)
  final EdgeInsets? padding;

  /// Border radius of the handler (default: 15)
  final double? handlerBorderRadius;

  /// Whether to show shadow on the handler (default: true)
  final bool showShadow;

  const HorizontalScrollSlider({
    super.key,
    required this.scrollController,
    required this.scrollPosition,
    required this.maxScrollExtent,
    required this.onSliderDrag,
    this.handlerHeight,
    this.handlerWidth,
    this.touchSize,
    this.trackBarHeight,
    this.trackColor,
    this.handlerColor,
    this.padding,
    this.handlerBorderRadius,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => FlutterSlider(
                handlerHeight: handlerHeight ?? Sizer.hp(24),
                handlerWidth: handlerWidth ?? Sizer.wp(40),
                touchSize: touchSize ?? 20,
                values: [scrollPosition.value],
                max: maxScrollExtent.value > 0 ? maxScrollExtent.value : 100,
                min: 0,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  onSliderDrag(lowerValue);
                },
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: trackBarHeight ?? 12,
                  inactiveTrackBarHeight: trackBarHeight ?? 12,
                  activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: trackColor ?? AppColors.color4,
                  ),
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: trackColor ?? AppColors.color4,
                  ),
                ),
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(
                    color: handlerColor ?? AppColors.primary,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(
                      handlerBorderRadius ?? 15,
                    ),
                    boxShadow: showShadow
                        ? const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: const SizedBox.shrink(),
                ),
                tooltip: FlutterSliderTooltip(disabled: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
