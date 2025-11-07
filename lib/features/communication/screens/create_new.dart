import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/styles/global_text_style.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';
import 'package:jesusvlsco/features/communication/screens/new_team.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/user/controller/user_list_controller.dart';
import 'package:jesusvlsco/features/communication/controllers/private_chat_controller.dart';
import 'package:jesusvlsco/features/communication/screens/admin_chat_screen.dart';

class CreateNew extends StatelessWidget {
  const CreateNew({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final UserListController userController = Get.put(UserListController());
    final PrivateChatController chatController = Get.put(
      PrivateChatController(),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: Custom_appbar(title: "Create New"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizer.wp(16)),
            child: _buildSearchTextField(userController),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/groups_2.svg',
                  height: Sizer.hp(20),
                  width: Sizer.wp(20),
                ),
                SizedBox(width: Sizer.wp(8)),
                TextButton(
                  onPressed: () {
                    Get.to(NewTeam());
                  },
                  child: Text(
                    'New Team',
                    style: AppTextStyle.regular().copyWith(
                      fontSize: Sizer.wp(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Sizer.hp(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
            child: Row(
              children: [
                Text(
                  'Suggested',
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.wp(16),
              vertical: Sizer.hp(3),
            ),
            child: Divider(color: AppColors.border3, height: 1),
          ),
          // Expanded to make the list take remaining space and scrollable
          Expanded(
            child: buildSuggestedUserList(userController, chatController),
          ),
        ],
      ),
    );
  }
}

Widget buildSuggestedUserList(
  UserListController userController,
  PrivateChatController chatController,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Sizer.wp(16)),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border.all(color: AppColors.border3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.border3,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Obx(() {
        // Handle loading state for initial load
        if (userController.isLoading.value &&
            userController.employeeProfiles.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Handle empty state
        if (userController.employeeProfiles.isEmpty &&
            !userController.isLoading.value) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(Sizer.wp(20)),
              child: Text(
                userController.isSearching.value
                    ? 'No employees found for "${userController.searchQuery.value}"'
                    : 'No employees found',
                style: AppTextStyle.regular().copyWith(
                  fontSize: Sizer.wp(14),
                  color: AppColors.text,
                ),
              ),
            ),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // Load more when reaching 80% of scroll
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent * 0.8) {
              userController.loadMoreEmployees();
            }
            return false;
          },
          child: ListView.separated(
            padding: EdgeInsets.all(Sizer.wp(8)),
            itemCount:
                userController.employeeProfiles.length +
                (userController.hasMore.value
                    ? 1
                    : 0), // +1 for loading indicator
            separatorBuilder: (context, index) => Divider(
              color: AppColors.border3,
              height: 1,
              indent: Sizer.wp(56), // Indent to align with text
            ),
            itemBuilder: (context, index) {
              // Show loading indicator at the end
              if (index == userController.employeeProfiles.length) {
                return Padding(
                  padding: EdgeInsets.all(Sizer.wp(16)),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              final employee = userController.employeeProfiles[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Sizer.wp(12),
                  vertical: Sizer.hp(4),
                ),
                leading: CircleAvatar(
                  radius: Sizer.wp(20),
                  backgroundColor: AppColors.primary.withValues(alpha: .1),
                  child: Icon(
                    Icons.person,
                    size: Sizer.wp(20),
                    color: AppColors.primary,
                  ),
                ),
                title: Text(
                  '${employee.profile.firstName} ${employee.profile.lastName}',
                  style: AppTextStyle.regular().copyWith(
                    fontSize: Sizer.wp(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (employee.profile.jobTitle.isNotEmpty)
                      Text(
                        employee.profile.jobTitle,
                        style: AppTextStyle.regular().copyWith(
                          fontSize: Sizer.wp(14),
                          color: AppColors.text,
                        ),
                      ),
                    if (employee.profile.department.isNotEmpty)
                      Text(
                        employee.profile.department,
                        style: AppTextStyle.regular().copyWith(
                          fontSize: Sizer.wp(12),
                          color: AppColors.text.withValues(alpha: .7),
                        ),
                      ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () async {
                    // Initialize chat with this employee
                    await _startChatWithEmployee(employee, chatController);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(Sizer.wp(8)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(Sizer.wp(8)),
                    ),
                    child: Icon(
                      Icons.message_outlined,
                      size: Sizer.wp(20),
                      color: AppColors.primary,
                    ),
                  ),
                  tooltip: 'Start Chat',
                ),
              );
            },
          ),
        );
      }),
    ),
  );
}

/// Start a new chat with the selected employee
Future<void> _startChatWithEmployee(
  EmployeeProfile employee,
  PrivateChatController chatController,
) async {
  try {
    // Navigate to chat screen first
    Get.to(() => Admin_chatscreen());

    // Start new conversation with a default welcome message
    await chatController.startNewConversation(
      recipientId: employee.id,
      firstMessage: "Hello ${employee.profile.firstName}! 👋",
    );
  } catch (error) {
    if (kDebugMode) {
      print('Error starting chat with employee: $error');
    }
    // Show error message to user
    Get.snackbar(
      'Error',
      'Failed to start chat with ${employee.profile.firstName}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

Widget _buildSearchTextField(UserListController userController) {
  return Container(
    height: Sizer.hp(48),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(Sizer.wp(10)),
    ),
    child: TextField(
      textAlign: TextAlign.start,
      onChanged: (value) {
        // Debounce search to avoid too many API calls
        Future.delayed(const Duration(milliseconds: 500), () {
          if (value == userController.searchQuery.value) {
            userController.searchEmployees(value);
          }
        });
        userController.searchQuery.value = value;
      },
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        hintText: 'To : type a name or group',
        hintStyle: AppTextStyle.regular().copyWith(
          fontSize: Sizer.wp(14),
          color: AppColors.text,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizer.wp(16),
          vertical: Sizer.hp(12),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.text,
          size: Sizer.wp(20),
        ),
        suffixIcon: Obx(
          () => userController.searchQuery.value.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    userController.clearSearch();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.text,
                    size: Sizer.wp(20),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    ),
  );
}
