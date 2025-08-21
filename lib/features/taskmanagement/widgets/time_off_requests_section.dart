import 'package:flutter/material.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TimeOffRequestsSection extends StatelessWidget {
  final VoidCallback? onApprovePressed;

  const TimeOffRequestsSection({super.key, this.onApprovePressed});

  @override
  Widget build(BuildContext context) {
    // Sample time-off requests data
    final List<Map<String, dynamic>> requests = [
      {
        'name': 'Alex Wilson',
        'date': 'Mar 28.2025',
        'reason': "Doctor's appointment",
        'status': 'Pending',
        'statusColor': const Color(0xFFFFBA5C),
      },
      {
        'name': 'Jessica Lee',
        'date': 'Mar 30,2025',
        'reason': 'Sick leave',
        'status': 'Approved',
        'statusColor': const Color(0xFF1EBD66),
      },
      {
        'name': 'Kristin Watson',
        'date': 'Jun 02, 2025',
        'reason': 'Personal day',
        'status': 'Declined',
        'statusColor': const Color(0xFFDC1E28),
      },
    ];

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
              ],
            ),
          ),

          SizedBox(height: Sizer.hp(16)),

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
              children: requests.map((request) {
                return _buildRequestItem(request);
              }).toList(),
            ),
          ),

          SizedBox(height: Sizer.hp(16)),

          // End of requests text
          Center(
            child: Text(
              'End Of Requests',
              style: AppTextStyle.f12W400().copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual request item
  Widget _buildRequestItem(Map<String, dynamic> request) {
    final bool isPending = request['status'] == 'Pending';

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
              Text(
                request['name'],
                style: AppTextStyle.f16W600().copyWith(color: AppColors.text),
              ),
              Text(
                request['status'],
                style: AppTextStyle.f14W400().copyWith(
                  color: request['statusColor'],
                ),
              ),
            ],
          ),

          SizedBox(height: Sizer.hp(8)),

          // Date
          Text(
            request['date'],
            style: AppTextStyle.f12W400().copyWith(
              color: AppColors.textSecondaryGrey,
            ),
          ),

          SizedBox(height: Sizer.hp(16)),

          // Reason
          Text(
            request['reason'],
            style: AppTextStyle.f14W400().copyWith(color: AppColors.text),
          ),

          // Show approve/decline buttons only for pending requests
          if (isPending) ...[
            SizedBox(height: Sizer.hp(20)),
            Row(
              children: [
                // Approve button
                GestureDetector(
                  onTap: onApprovePressed,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizer.wp(20),
                      vertical: Sizer.hp(8),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1EBD66),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Approve',
                      style: AppTextStyle.f16W500().copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: Sizer.wp(16)),

                // Decline button
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizer.wp(20),
                    vertical: Sizer.hp(8),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDC1E28)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Decline',
                    style: AppTextStyle.f16W500().copyWith(
                      color: const Color(0xFFDC1E28),
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
}
