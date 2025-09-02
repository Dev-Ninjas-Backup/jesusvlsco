import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizer.dart';
import '../../user/controller/user_user_info_controller.dart';
import '../../user/controller/user_users_controller.dart';

class UserUserInfoScreen extends StatelessWidget {
  final Object? userArg;

  const UserUserInfoScreen({super.key, this.userArg});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(UserUserInfoController());
    // initialize controller with passed user if any (from GoRouter extra)
    if (userArg is UserModel) {
      ctrl.init(userArg as UserModel);
    } else {
      // fallback: try Get.arguments for backward compatibility
      ctrl.init(Get.arguments is UserModel ? Get.arguments as UserModel : null);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: Obx(() {
        final user = ctrl.user.value;
        if (user == null) {
          return const Center(child: Text('No user selected'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(color: Color(0x3FA9B7DD), blurRadius: 12),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    _AssetAvatar(assetPath: user.avatarUrl, size: 100),
                    const SizedBox(height: 12),
                    Text(
                      user.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF484848),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(44),
                                backgroundColor: const Color(0xFF4E53B1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                elevation: 0,
                              ),
                              onPressed: ctrl.chat,
                              icon: const Icon(
                                Icons.mark_email_read,
                                color: Colors.white,
                                size: 20,
                              ),
                              label: const Text(
                                'Chat',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(44),
                                side: const BorderSide(
                                  color: Color(0xFF4E53B1),
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ),
                              onPressed: ctrl.email,
                              icon: const Icon(
                                Icons.email,
                                color: Color(0xFF4E53B1),
                                size: 20,
                              ),
                              label: const Text(
                                'Email',
                                style: TextStyle(color: Color(0xFF4E53B1)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFFC5C5C5)),
                    const SizedBox(height: 12),
                    _InfoRow(
                      label: 'Email:',
                      value: 'nevaeh.simmons@example.com',
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(label: 'Phone:', value: '(303) 555-0105'),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 14),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF6F6F6F), fontSize: 16),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

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
    } catch (_) {}
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
