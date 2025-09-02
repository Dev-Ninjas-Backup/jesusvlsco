import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/features/dashboard/admin_dashboard/widgets/user_drawer.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../../core/utils/constants/sizer.dart';
import '../controllers/user_recognition_controller.dart';

class UserRecognitionScreen extends StatelessWidget {
  const UserRecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(UserRecognitionController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // My recognition header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'My recognition',
                          style: TextStyle(
                            color: Color(0xFF4E53B1),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View all',
                            style: TextStyle(color: Color(0xFF4E53B1)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Categories horizontal list
                  SizedBox(
                    height: 96,
                    child: Obx(
                      () => ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final cat = ctrl.categories[index];
                          return Column(
                            children: [
                              Container(
                                width: 66,
                                height: 66,
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? const Color(0xFFFFF6DC)
                                      : const Color(0xFFFFE8DC),
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.emoji_events,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 81,
                                child: Text(
                                  cat,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF484848),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemCount: ctrl.categories.length,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Recognition feed header and filter
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recognition feed',
                          style: TextStyle(
                            color: Color(0xFF4E53B1),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFC8CAE7),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: PopupMenuButton<String>(
                              onSelected: (v) => ctrl.selectedFilter.value = v,
                              itemBuilder: (_) => ctrl.filters
                                  .map(
                                    (f) => PopupMenuItem<String>(
                                      value: f,
                                      child: Text(f),
                                    ),
                                  )
                                  .toList(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(ctrl.selectedFilter.value),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Feed list (filtered by the dropdown)
                  Obx(() {
                    final selected = ctrl.selectedFilter.value;
                    final List<RecognitionModel> list;
                    if (selected == 'All Recognitions') {
                      list = ctrl.recognitions;
                    } else if (selected == 'My Recognitions') {
                      // 'My' recognitions: where current user is involved. For demo the user is 'You'.
                      list = ctrl.recognitions
                          .where(
                            (r) => r.fromName == 'You' || r.toName == 'You',
                          )
                          .toList();
                    } else if (selected == 'Shared with Me') {
                      // Placeholder filter: no-op until backend provides share info.
                      list = ctrl.recognitions
                          .where(
                            (r) =>
                                r.visibility.toLowerCase().contains('people'),
                          )
                          .toList();
                    } else {
                      list = ctrl.recognitions;
                    }

                    if (list.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Center(
                          child: Text(
                            'No recognitions',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: list
                          .map(
                            (r) => _RecognitionCard(
                              recognition: r,
                              controller: ctrl,
                            ),
                          )
                          .toList(),
                    );
                  }),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(26, 8, 26, 26),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFC5C5C5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: ctrl.inputController,
                            decoration: const InputDecoration(
                              hintText: 'Write Something ...',
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
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attach_file,
                            color: Color(0xFF949494),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // For demo, post to first recognition
                    if (ctrl.recognitions.isNotEmpty) {
                      ctrl.postFromInput(ctrl.recognitions.first.id, 'You');
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B56D9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
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

class _RecognitionCard extends StatelessWidget {
  final RecognitionModel recognition;
  final UserRecognitionController controller;

  const _RecognitionCard({required this.recognition, required this.controller});

  String _formatDate(DateTime dt) {
    // Simple formatting like the design: dd/MM/yyyy at HH:mm
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} at ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6DC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  '${recognition.fromName} Recognized\n${recognition.toName}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF4E53B1),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFFDD835),
                      child: Text(
                        recognition.fromName
                            .splitMapJoin(
                              RegExp(r'\b\w'),
                              onMatch: (m) => m.group(0) ?? ' ',
                            )
                            .toUpperCase()
                            .substring(0, 2)
                            .trim(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xB7FFFBEF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.orange.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: const Color(0xFFFFA000),
                      child: Text(
                        recognition.toName
                            .splitMapJoin(
                              RegExp(r'\b\w'),
                              onMatch: (m) => m.group(0) ?? ' ',
                            )
                            .toUpperCase()
                            .substring(0, 2)
                            .trim(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  recognition.category,
                  style: const TextStyle(
                    color: Color(0xFF484848),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(recognition.createdAt),
                style: const TextStyle(color: Color(0xFFB5B5B5), fontSize: 12),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    IconPath.visibility,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Color(0xFFB5B5B5),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    recognition.visibility,
                    style: const TextStyle(
                      color: Color(0xFFB5B5B5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // reactions + comments summary row (left: reactions count, right: comments count)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF6DC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(child: Text('😊')),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${recognition.likes}',
                    style: const TextStyle(
                      color: Color(0xFF949494),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Text(
                '${recognition.comments.length} comment${recognition.comments.length == 1 ? '' : 's'}',
                style: const TextStyle(color: Color(0xFFB5B5B5), fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Color(0xFF484848), width: 1),
                  ),
                  onPressed: () => controller.toggleLike(recognition.id),
                  child: Obx(() {
                    final r = controller.recognitions.firstWhere(
                      (e) => e.id == recognition.id,
                    );
                    return Text(
                      'Like ${r.likes > 0 ? '(${r.likes})' : ''}',
                      style: const TextStyle(
                        color: Color(0xFF484848),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    side: const BorderSide(color: Color(0xFF484848), width: 1),
                  ),
                  onPressed: () {
                    // For now focus the input; posting appends to first recognition via bottom send.
                  },
                  child: const Text(
                    'Comment',
                    style: TextStyle(
                      color: Color(0xFF484848),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Comments list
          if (recognition.comments.isNotEmpty) ...[
            const SizedBox(height: 12),
            Column(
              children: recognition.comments.map((c) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEEF7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: null,
                            child: Text(
                              c.authorName
                                  .split(' ')
                                  .map((s) => s.isNotEmpty ? s[0] : '')
                                  .take(2)
                                  .join(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.authorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(c.message),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
          ],
        ],
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
      'Recognition',
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
        onPressed: () {
          Get.to(UserDrawer());
        },
      ),
    ],
  );
}
