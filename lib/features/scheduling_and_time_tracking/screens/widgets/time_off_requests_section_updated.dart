import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/scheduling_and_time_tracking/controllers/access_schedule_controller.dart';
import 'package:jesusvlsco/model/time_off_request_model.dart';

class TimeOffRequestsSection extends StatelessWidget {
  final VoidCallback? onApprovePressed;

  const TimeOffRequestsSection({super.key, this.onApprovePressed});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccessScheduleController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Container(
            padding: EdgeInsets.symmetric(vertical: Sizer.hp(8)),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE4E5F3), width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Time-Off Requests',
                    style: AppTextStyle.f18W600().copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                // Refresh button
                GestureDetector(
                  onTap: () => controller.loadTimeOffRequests(refresh: true),
                  child: Container(
                    padding: EdgeInsets.all(Sizer.wp(8)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.refresh,
                      size: Sizer.wp(18),
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Sizer.hp(16)),

          // Requests content based on API data
          Obx(() {
            if (controller.isLoadingTimeOffRequests.value &&
                controller.timeOffRequests.isEmpty) {
              return _buildLoadingState();
            }

            if (controller.timeOffRequests.isEmpty) {
              return _buildEmptyState();
            }

            return _buildRequestsList(controller);
          }),
        ],
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return Container(
      height: Sizer.hp(200),
      padding: EdgeInsets.all(Sizer.wp(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(169, 183, 221, 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }

  /// Build empty state when no requests found
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(40)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(169, 183, 221, 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_busy,
            size: Sizer.wp(48),
            color: AppColors.textfield,
          ),
          SizedBox(height: Sizer.hp(16)),
          Text(
            'No Time-Off Requests',
            style: AppTextStyle.f16W500().copyWith(color: AppColors.textfield),
          ),
          SizedBox(height: Sizer.hp(8)),
          Text(
            'No pending time-off requests found',
            style: AppTextStyle.f14W400().copyWith(
              color: AppColors.textSecondaryGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build requests list with API data
  Widget _buildRequestsList(AccessScheduleController controller) {
    return Column(
      children: [
        // Requests container
        Container(
          padding: EdgeInsets.all(Sizer.wp(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(169, 183, 221, 0.08),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              // Requests list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.timeOffRequests.length,
                itemBuilder: (context, index) {
                  final request = controller.timeOffRequests[index];
                  return _buildRequestItem(request, controller);
                },
              ),

              // Load more button if more pages available
              Obx(() {
                if (controller.hasMoreTimeOffRequests) {
                  return Column(
                    children: [
                      SizedBox(height: Sizer.hp(16)),
                      GestureDetector(
                        onTap: controller.isLoadingTimeOffRequests.value
                            ? null
                            : controller.loadMoreTimeOffRequests,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: Sizer.hp(12)),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: controller.isLoadingTimeOffRequests.value
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Load More (${controller.timeOffCurrentPage.value}/${controller.timeOffTotalPages.value})',
                                  style: AppTextStyle.f14W500().copyWith(
                                    color: AppColors.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),

        SizedBox(height: Sizer.hp(16)),

        // Statistics
        _buildStatistics(controller),

        SizedBox(height: Sizer.hp(16)),

        // End of requests text
        Center(
          child: Text(
            'Total ${controller.timeOffTotalItems.value} Requests',
            style: AppTextStyle.f12W400().copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  /// Build individual request item with API data
  Widget _buildRequestItem(
    TimeOffRequestData request,
    AccessScheduleController controller,
  ) {
    // Format dates
    final startDate = DateFormat('MMM dd, yyyy').format(request.startDate);
    final endDate = DateFormat('MMM dd, yyyy').format(request.endDate);
    final dateRange = request.startDate == request.endDate
        ? startDate
        : '$startDate - $endDate';

    // Get status color
    Color statusColor;
    switch (request.status) {
      case TimeOffRequestStatus.PENDING:
        statusColor = const Color(0xFFFFBA5C);
        break;
      case TimeOffRequestStatus.APPROVED:
        statusColor = const Color(0xFF1EBD66);
        break;
      case TimeOffRequestStatus.REJECTED:
        statusColor = const Color(0xFFDC1E28);
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: Sizer.hp(16)),
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC8CAE7)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.user.fullName,
                      style: AppTextStyle.f16W600().copyWith(
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: Sizer.hp(4)),
                    Text(
                      request.user.profile?.jobTitle.replaceAll('_', ' ') ??
                          request.user.role,
                      style: AppTextStyle.f12W400().copyWith(
                        color: AppColors.textSecondaryGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(12),
                  vertical: Sizer.hp(4),
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  request.status.displayName,
                  style: AppTextStyle.f12W400().copyWith(color: statusColor),
                ),
              ),
            ],
          ),

          SizedBox(height: Sizer.hp(12)),

          // Date range and type
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: Sizer.wp(14),
                color: AppColors.textSecondaryGrey,
              ),
              SizedBox(width: Sizer.wp(6)),
              Text(
                dateRange,
                style: AppTextStyle.f12W400().copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
              SizedBox(width: Sizer.wp(16)),
              Icon(
                Icons.access_time,
                size: Sizer.wp(14),
                color: AppColors.textSecondaryGrey,
              ),
              SizedBox(width: Sizer.wp(6)),
              Text(
                '${request.totalDaysOff} day${request.totalDaysOff > 1 ? 's' : ''}',
                style: AppTextStyle.f12W400().copyWith(
                  color: AppColors.textSecondaryGrey,
                ),
              ),
            ],
          ),

          SizedBox(height: Sizer.hp(12)),

          // Type and reason
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(10),
              vertical: Sizer.hp(6),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              request.type.displayName,
              style: AppTextStyle.f12W400().copyWith(color: AppColors.primary),
            ),
          ),

          SizedBox(height: Sizer.hp(8)),

          Text(
            request.reason,
            style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
          ),

          // Show admin note if available
          if (request.adminNote != null && request.adminNote!.isNotEmpty) ...[
            SizedBox(height: Sizer.hp(8)),
            Container(
              padding: EdgeInsets.all(Sizer.wp(10)),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin Note:',
                    style: AppTextStyle.f12W400().copyWith(
                      color: AppColors.textSecondaryGrey,
                    ),
                  ),
                  SizedBox(height: Sizer.hp(4)),
                  Text(
                    request.adminNote!,
                    style: AppTextStyle.f12W400().copyWith(
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Show approve/decline buttons only for pending requests
          if (request.status == TimeOffRequestStatus.PENDING) ...[
            SizedBox(height: Sizer.hp(20)),
            Row(
              children: [
                // Approve button
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.approveTimeOffRequest(
                      requestId: request.id,
                      adminNote: 'Approved by admin',
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: Sizer.hp(10)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1EBD66),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Approve',
                        style: AppTextStyle.f14W500().copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: Sizer.wp(12)),

                // Decline button
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.rejectTimeOffRequest(
                      requestId: request.id,
                      adminNote: 'Declined by admin',
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: Sizer.hp(10)),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFDC1E28)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Decline',
                        style: AppTextStyle.f14W500().copyWith(
                          color: const Color(0xFFDC1E28),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Build statistics section
  Widget _buildStatistics(AccessScheduleController controller) {
    return Container(
      padding: EdgeInsets.all(Sizer.wp(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E5F3)),
      ),
      child: Row(
        children: [
          _buildStatItem(
            'Pending',
            controller.pendingTimeOffRequestsCount.toString(),
            const Color(0xFFFFBA5C),
          ),
          SizedBox(width: Sizer.wp(24)),
          _buildStatItem(
            'Approved',
            controller.approvedTimeOffRequestsCount.toString(),
            const Color(0xFF1EBD66),
          ),
          SizedBox(width: Sizer.wp(24)),
          _buildStatItem(
            'Rejected',
            controller.rejectedTimeOffRequestsCount.toString(),
            const Color(0xFFDC1E28),
          ),
        ],
      ),
    );
  }

  /// Build individual statistic item
  Widget _buildStatItem(String label, String count, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(count, style: AppTextStyle.f18W600().copyWith(color: color)),
          SizedBox(height: Sizer.hp(4)),
          Text(
            label,
            style: AppTextStyle.f12W400().copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),
        ],
      ),
    );
  }
}
