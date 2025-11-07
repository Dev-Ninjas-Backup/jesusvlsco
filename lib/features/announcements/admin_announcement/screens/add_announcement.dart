import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/announcements/admin_announcement/widgets/text_editor.dart';

class AddAnnouncement extends StatefulWidget {
  const AddAnnouncement({super.key});

  @override
  State<AddAnnouncement> createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  String? selectedCategory;
  String? selectedAudience;
  bool isActive = true;
  bool emailNotifications = false;
  bool readReceiptTracking = false;

  final QuillController _controller = QuillController.basic();

  final List<String> categories = [
    'Select category',
    'News',
    'Updates',
    'Announcements',
    'Reports',
  ];

  final List<String> audiences = [
    'Select audience',
    'Public',
    'Internal',
    'Partners',
    'Customers',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.textWhite,
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
          'Create Announcement',
          style: AppTextStyle.regular().copyWith(
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
            onPressed: () {
              // Handle menu action if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizer.wp(16)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Create New Announcement",
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(18),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizer.hp(8)),
              Row(
                children: [
                  Text(
                    "Fill out the form below to create a new  company\nannouncement",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(12),
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizer.hp(24)),
              Row(
                children: [
                  Text(
                    "Announcement Title",
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.red, size: Sizer.wp(10)),
                ],
              ),

              SizedBox(height: Sizer.hp(8)),
              Row(
                children: [
                  SizedBox(
                    height: Sizer.hp(45),
                    width: Sizer.wp(360),
                    child: TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Enter announcement title here",
                        hintStyle: AppTextStyle.regular().copyWith(
                          fontSize: Sizer.wp(14),
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizer.wp(8)),
                          borderSide: BorderSide(
                            color: AppColors.border,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizer.wp(8)),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Sizer.hp(24)),

              //description
              Row(
                children: [
                  Text(
                    "Description",
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizer.hp(8)),

              TextEditor(controller: _controller),

              SizedBox(height: Sizer.hp(24)),
              Row(
                children: [
                  Text(
                    "Category",
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.red, size: Sizer.wp(10)),
                ],
              ),
              SizedBox(height: Sizer.hp(8)),
              SizedBox(
                height: Sizer.hp(45),
                width: Sizer.wp(360),
                child: _buildDropdown(
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ),
              SizedBox(height: Sizer.hp(24)),
              Row(
                children: [
                  Text(
                    "Audience",
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      color: AppColors.backgroundDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.red, size: Sizer.wp(10)),
                ],
              ),
              SizedBox(height: Sizer.hp(8)),
              SizedBox(
                height: Sizer.hp(45),
                width: Sizer.wp(360),
                child: _buildDropdown(
                  items: audiences,
                  value: selectedAudience,
                  onChanged: (value) {
                    setState(() {
                      selectedAudience = value;
                    });
                  },
                ),
              ),
              SizedBox(height: Sizer.hp(24)),
              Row(
                children: [
                  _buildRadioOption(
                    'Publish now',
                    isActive,
                    () => setState(() => isActive = true),
                  ),
                  const SizedBox(width: 24),
                  _buildRadioOption(
                    'Select date & time',
                    !isActive,
                    () => setState(() => isActive = false),
                  ),
                ],
              ),
              SizedBox(height: Sizer.hp(24)),
              _buildFieldLabel('Attachment'),
              SizedBox(height: Sizer.hp(24)),
              _buildAttachmentArea(),
              SizedBox(height: Sizer.hp(24)),
              _buildFieldLabel('Notification Settings'),
              SizedBox(height: Sizer.hp(16)),
              _buildCheckboxOption(
                'Send email notifications to recipients',
                emailNotifications,
                (value) => setState(() => emailNotifications = value ?? false),
              ),
              SizedBox(height: Sizer.hp(16)),
              _buildCheckboxOption(
                'Enable read receipt tracking',
                readReceiptTracking,
                (value) => setState(() => readReceiptTracking = value ?? false),
              ),
              SizedBox(height: Sizer.hp(24)),
              Row(
                children: [
                  _buildActionButton(
                    'Preview',
                    Icons.visibility_outlined,
                    Colors.white,
                    const Color(0xFF6366F1),
                    true,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    'Publish',
                    Icons.upload_file,
                    const Color(0xFF6366F1),
                    Colors.white,
                    false,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    'Cancel',
                    null,
                    Colors.white,
                    const Color(0xFF6B7280),
                    true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        style: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(14),
          color: AppColors.backgroundDark,
          fontWeight: FontWeight.w400,
        ),
        initialValue: value,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        hint: Text(
          items.first,
          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        items: items.skip(1).map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: AppTextStyle.regular().copyWith(
                fontSize: Sizer.wp(14),
                color: AppColors.backgroundDark,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _buildRadioOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF6366F1)
                    : const Color(0xFFD1D5DB),
                width: 2,
              ),
            ),
            child: isSelected
                ? Container(
                    margin: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF6366F1),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentArea() {
    return Container(
      width: Sizer.wp(360),
      height: Sizer.hp(166),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: Sizer.wp(40),
            color: AppColors.text,
          ),
          const SizedBox(height: 8),
          Text(
            'Click to upload files or drag and drop',
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(12),
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'PDF, DOC, DOCX, JPG, PNG up to 10MB',
            style: TextStyle(fontSize: Sizer.wp(14), color: AppColors.text),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6366F1),
            checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData? icon,
    Color backgroundColor,
    Color textColor,
    bool isOutlined,
  ) {
    return Expanded(
      child: Container(
        height: Sizer.hp(40),
        width: Sizer.wp(112),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: isOutlined ? Border.all(color: textColor) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () {
            // Handle button press
            if (kDebugMode) {
              print('$label pressed');
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: textColor),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, {bool isRequired = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyle.regular().copyWith(
              fontSize: Sizer.wp(16),
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundDark,
            ),
            children: [
              TextSpan(text: label),
              if (isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(color: Color(0xFFEF4444)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
