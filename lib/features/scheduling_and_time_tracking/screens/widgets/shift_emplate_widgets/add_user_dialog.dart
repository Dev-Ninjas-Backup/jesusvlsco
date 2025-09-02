import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizer.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/common/styles/global_text_style.dart';

/// User model for the add user dialog
class UserModel {
  final String id;
  final String name;
  final String role;
  final String avatar;
  bool isSelected;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.avatar,
    this.isSelected = false,
  });
}

/// Add User Dialog Widget
/// Allows users to select multiple users from a scrollable list
class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final RxList<UserModel> users = <UserModel>[
    UserModel(
      id: '1',
      name: 'Jane Cooper',
      role: 'Project Manager',
      avatar: 'https://i.pravatar.cc/150?img=1',
      isSelected: true,
    ),
    UserModel(
      id: '2',
      name: 'Robert Fox',
      role: 'Construction Site Manager',
      avatar: 'https://i.pravatar.cc/150?img=2',
    ),
    UserModel(
      id: '3',
      name: 'Esther Howard',
      role: 'Assistant Project Manager',
      avatar: 'https://i.pravatar.cc/150?img=3',
      isSelected: true,
    ),
    UserModel(
      id: '4',
      name: 'Desirae Botosh',
      role: 'Superintendent',
      avatar: 'https://i.pravatar.cc/150?img=4',
    ),
    UserModel(
      id: '5',
      name: 'Marley Stanton',
      role: 'Coordinator',
      avatar: 'https://i.pravatar.cc/150?img=5',
      isSelected: true,
    ),
    UserModel(
      id: '6',
      name: 'Jane Cooper',
      role: 'Project Manager',
      avatar: 'https://i.pravatar.cc/150?img=6',
      isSelected: true,
    ),
    UserModel(
      id: '7',
      name: 'Brandon Vaccaro',
      role: 'Operations Manager',
      avatar: 'https://i.pravatar.cc/150?img=7',
    ),
    UserModel(
      id: '8',
      name: 'Erin Press',
      role: 'Estimating Manager',
      avatar: 'https://i.pravatar.cc/150?img=8',
    ),
  ].obs;

  void _toggleUser(String userId) {
    final userIndex = users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      users[userIndex].isSelected = !users[userIndex].isSelected;
      users.refresh();
    }
  }

  List<UserModel> get selectedUsers =>
      users.where((user) => user.isSelected).toList();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: Sizer.wp(360),
        height: Sizer.hp(600),
        padding: EdgeInsets.all(Sizer.wp(24)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(169, 183, 221, 0.25),
              offset: const Offset(0, 0),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // User List - Scrollable
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Sizer.hp(24)),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return _buildUserItem(user);
                  },
                ),
              ),
            ),

            SizedBox(height: Sizer.hp(24)),

            // Add Button
            GestureDetector(
              onTap: () {
                final selected = selectedUsers;
                Get.back(result: selected);
              },
              child: Container(
                width: double.infinity,
                height: Sizer.hp(44),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Add',
                    style: AppTextStyle.f16W600().copyWith(
                      color: Colors.white,
                      height: 1.75,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserItem(UserModel user) {
    return GestureDetector(
      onTap: () => _toggleUser(user.id),
      child: Row(
        children: [
          // Checkbox
          Container(
            width: Sizer.wp(16),
            height: Sizer.wp(16),
            decoration: BoxDecoration(
              color: user.isSelected
                  ? const Color(0xFF1EBD66)
                  : Colors.transparent,
              border: Border.all(
                color: user.isSelected
                    ? const Color(0xFF1EBD66)
                    : const Color(0xFFC5C5C5),
                width: 1,
              ),
            ),
            child: user.isSelected
                ? Icon(Icons.check, size: Sizer.wp(10), color: Colors.white)
                : null,
          ),

          SizedBox(width: Sizer.wp(16)),

          // User Avatar
          Container(
            width: Sizer.wp(40),
            height: Sizer.wp(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
              image: user.avatar.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(user.avatar),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: user.avatar.isEmpty
                ? Icon(
                    Icons.person,
                    size: Sizer.wp(20),
                    color: AppColors.primary,
                  )
                : null,
          ),

          SizedBox(width: Sizer.wp(16)),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyle.f16W600().copyWith(
                    color: AppColors.primary,
                    height: 1.75,
                  ),
                ),
                Text(
                  user.role,
                  style: AppTextStyle.f14W500().copyWith(
                    color: const Color(0xFF949494),
                    height: 1.75,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
