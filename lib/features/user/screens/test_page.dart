import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';


// AppColors class for consistent color management


class RemoteWorkPolicy extends StatelessWidget {
  const RemoteWorkPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 768),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(),
                const SizedBox(height: 24),
                
                // Content Section
                _buildContent(),
                const SizedBox(height: 24),
                
                // Attachments Section
                _buildAttachments(),
                const SizedBox(height: 24),
                
                // Like Section
                _buildLikeSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Remote Work Policy Implementation',
          style: AppTextStyle.regular(),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: 'Posted by ',
                style: AppTextStyle.regular(),
                children: [
                  TextSpan(
                    text: 'HR Department',
                    style: AppTextStyle.regular().copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  size: 16,
                  color: AppColors.text,
                ),
                const SizedBox(width: 4),
                Text('142 reads', style: AppTextStyle.semibold()),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'We are excited to announce our new flexible remote work policy that will take effect starting February 1st, 2024. This policy aims to provide better work-life balance...',
          style: AppTextStyle.semibold(),
        ),
        const SizedBox(height: 16),
        Text(
          'We are excited to announce our new flexible remote work policy that will take effect starting February 1st, 2024. This policy aims to provide better work-life balance while maintaining our high standards of productivity and collaboration. Key highlights of the new policy include:',
          style: AppTextStyle.semibold(),
        ),
        const SizedBox(height: 16),
        _buildBulletPoints(),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            text: 'This policy has been developed based on extensive feedback from our employee survey conducted last quarter, where 87% of respondents expressed interest in more flexible work arrangements. We believe this change will help us attract top talent while supporting our current team members in achieving better work-life integration. For questions about this policy, please reach out to HR at ',
            style: AppTextStyle.semibold(),
            children: [
              TextSpan(
                text: 'hr@company.com',
                style: AppTextStyle.semibold(),
              ),
              TextSpan(
                text: ' or schedule a one-on-one meeting with your manager.',
                style: AppTextStyle.semibold(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoints() {
    final List<String> bulletPoints = [
      'Employees can work remotely up to 3 days per week',
      'Core collaboration hours: 10 AM - 3 PM in your local timezone',
      'Weekly team meetings are mandatory',
      'Home office stipend of \$500 annually for equipment',
      'Regular check-ins with managers to ensure productivity',
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bulletPoints.map((point) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: AppTextStyle.semibold()),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: point.split(':')[0],
                      style: AppTextStyle.semibold().copyWith(fontWeight: FontWeight.w600),
                      children: point.contains(':') ? [
                        TextSpan(
                          text: ':${point.split(':')[1]}',
                          style: AppTextStyle.semibold(),
                        ),
                      ] : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: AppColors.border,
          margin: const EdgeInsets.only(bottom: 16),
        ),
        Text(
          'Attachments',
          style: AppTextStyle.semibold(),
        ),
        const SizedBox(height: 12),
        _buildAttachmentItem('Remote_Work_Policy_2024.pdf'),
        const SizedBox(height: 8),
        _buildAttachmentItem('Remote_Work_Policy_2024.pdf'),
      ],
    );
  }

  Widget _buildAttachmentItem(String filename) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                '📄',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(filename, style: AppTextStyle.semibold()),
          ),
          InkWell(
            onTap: () {
              // Handle download action
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download,
                  size: 16,
                  color: AppColors.success,
                ),
                const SizedBox(width: 4),
                Text(
                  'Download',
                  style: AppTextStyle.semibold(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikeSection() {
    return Column(
      children: [
        Container(
          height: 1,
          color: AppColors.border,
          margin: const EdgeInsets.only(bottom: 16),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                // Handle like action
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 8),
                  Text('89 Likes', style: AppTextStyle.semibold()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Usage example in main.dart