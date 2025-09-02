import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

/// ProjectCardShimmer displays a loading shimmer effect
/// that matches the design of ProjectCardWidget
class ProjectCardShimmer extends StatefulWidget {
  const ProjectCardShimmer({super.key});

  @override
  State<ProjectCardShimmer> createState() => _ProjectCardShimmerState();
}

class _ProjectCardShimmerState extends State<ProjectCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizer.hp(16)),
      padding: EdgeInsets.all(Sizer.wp(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizer.wp(8)),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerHeader(),
              SizedBox(height: Sizer.hp(16)),
              _buildShimmerInfo(),
              SizedBox(height: Sizer.hp(16)),
              _buildShimmerActions(),
            ],
          );
        },
      ),
    );
  }

  /// Build shimmer header section
  Widget _buildShimmerHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerBox(width: Sizer.wp(120), height: Sizer.hp(20)),
        SizedBox(height: Sizer.hp(8)),
        _buildShimmerBox(width: Sizer.wp(160), height: Sizer.hp(18)),
        SizedBox(height: Sizer.hp(4)),
        _buildShimmerBox(width: Sizer.wp(100), height: Sizer.hp(14)),
      ],
    );
  }

  /// Build shimmer info section
  Widget _buildShimmerInfo() {
    return Column(
      children: [
        _buildShimmerInfoRow(),
        SizedBox(height: Sizer.hp(12)),
        _buildShimmerInfoRow(),
      ],
    );
  }

  /// Build shimmer info row
  Widget _buildShimmerInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShimmerBox(width: Sizer.wp(60), height: Sizer.hp(16)),
        Row(
          children: [
            _buildShimmerCircle(radius: Sizer.wp(20)),
            SizedBox(width: Sizer.wp(8)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildShimmerBox(width: Sizer.wp(80), height: Sizer.hp(14)),
                SizedBox(height: Sizer.hp(4)),
                _buildShimmerBox(width: Sizer.wp(60), height: Sizer.hp(12)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Build shimmer actions section
  Widget _buildShimmerActions() {
    return Row(
      children: [
        _buildShimmerCircle(radius: Sizer.wp(22)),
        SizedBox(width: Sizer.wp(24)),
        Expanded(
          child: _buildShimmerBox(
            width: double.infinity,
            height: Sizer.wp(44),
            borderRadius: Sizer.wp(50),
          ),
        ),
      ],
    );
  }

  /// Build shimmer box with animation
  Widget _buildShimmerBox({
    required double width,
    required double height,
    double? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? Sizer.wp(4)),
        gradient: LinearGradient(
          colors: [
            AppColors.border.withValues(alpha: 0.3),
            AppColors.border.withValues(alpha: 0.1),
            AppColors.border.withValues(alpha: 0.3),
          ],
          stops: [
            _animation.value - 0.3,
            _animation.value,
            _animation.value + 0.3,
          ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  /// Build shimmer circle with animation
  Widget _buildShimmerCircle({required double radius}) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.border.withValues(alpha: 0.3),
            AppColors.border.withValues(alpha: 0.1),
            AppColors.border.withValues(alpha: 0.3),
          ],
          stops: [
            _animation.value - 0.3,
            _animation.value,
            _animation.value + 0.3,
          ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
