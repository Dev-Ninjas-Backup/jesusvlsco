import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jesusvlsco/core/utils/constants/icon_path.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizer.dart';
import '../controller/user_users_controller.dart';
import 'user_user_info_screen.dart';

class UserUsersScreen extends StatelessWidget {
  const UserUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(UserUsersController());
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Search box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE8E6FF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0xFF949494)),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    IconPath.searchIcon,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFBDBBDB),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Users',
              style: TextStyle(
                color: Color(0xFF4E53B1),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            // Users list
            Expanded(
              child: Obx(() {
                final list = ctrl.filteredUsers;
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFFC8CAE7),
                    height: 1,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final user = list[index];
                    return InkWell(
                      onTap: () {
                        // navigate to user info screen via GoRouter when context has it,
                        // otherwise use the global AppRouter as a fallback.
                        try {
                          Get.to(() => UserUserInfoScreen(userArg: user));
                          // GoRouter.of(context).push('/users/info', extra: user);
                        } catch (_) {
                          // AppRouter.router.push('/users/info', extra: user);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _AssetAvatar(
                                  assetPath: user.avatarUrl,
                                  size: 40,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    color: Color(0xFF484848),
                                    fontSize: 16,
                                    height: 1.75,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // Call button
                                GestureDetector(
                                  onTap: () => ctrl.callUser(user),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4E53B1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Message button (outlined)
                                GestureDetector(
                                  onTap: () => ctrl.messageUser(user),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF4E53B1),
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.message,
                                      color: Color(0xFF4E53B1),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that displays an avatar from an asset path.
/// If the SVG contains an embedded data:image/png;base64,... image, it extracts
/// and renders that PNG for better compatibility; otherwise falls back to
/// SvgPicture.asset.
class _AssetAvatar extends StatefulWidget {
  final String assetPath;
  final double size;

  const _AssetAvatar({required this.assetPath, required this.size});

  @override
  State<_AssetAvatar> createState() => _AssetAvatarState();
}

class _AssetAvatarState extends State<_AssetAvatar> {
  Uint8List? _decodedPng;

  @override
  void initState() {
    super.initState();
    _tryLoadEmbeddedPng();
  }

  Future<void> _tryLoadEmbeddedPng() async {
    try {
      final raw = await rootBundle.loadString(widget.assetPath);
      final marker = 'data:image/png;base64,';
      final idx = raw.indexOf(marker);
      if (idx != -1) {
        final start = idx + marker.length;
        final end = raw.indexOf('"', start);
        final base64Str = (end == -1)
            ? raw.substring(start)
            : raw.substring(start, end);
        final decoded = base64Decode(base64Str);
        if (mounted) setState(() => _decodedPng = decoded);
      }
    } catch (_) {
      // ignore and fallback to svg
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    if (_decodedPng != null) {
      return ClipOval(
        child: Image.memory(
          _decodedPng!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: SvgPicture.asset(widget.assetPath, fit: BoxFit.cover),
      ),
    );
  }
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
      'Directory',
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
