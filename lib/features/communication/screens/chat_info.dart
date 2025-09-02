// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jesusvlsco/core/common/widgets/custom_appbar.dart';
import 'package:jesusvlsco/features/communication/controllers/chat_controller.dart';
import 'package:jesusvlsco/features/communication/widgets/fullscreen_image_view.dart';

class ChatInfoScreen extends StatelessWidget {
  const ChatInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: Custom_appbar(title: "Chat Info"),
      body: Column(
        children: [
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chat Header Section
                  _buildChatHeaderSection(context),
                  const SizedBox(height: 24),
                  // Members List
                  _buildMembersListSection(context),
                  const SizedBox(height: 24),
                  // Media Section
                  _buildMediaSection(context),
                  SizedBox(height: 24),
                  // Files Section
                  _buildFilesSection(context),
                  SizedBox(height: 24),
                  // Links Section
                  _buildLinksSection(context),
                  SizedBox(height: 96), // Bottom padding for navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@override
Widget _buildChatHeaderSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE4E5F3))),
        ),
        child: const Text(
          'Chat name : Project ABC',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E53B1),
          ),
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          const Text(
            'See members',
            style: TextStyle(fontSize: 14, color: Color(0xFF484848)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Open member search or members screen
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: (8.0)),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: (8.0)),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                focusedBorder: InputBorder.none,
                                hintText: 'Search members',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF949494),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xFF949494),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

@override
Widget _buildMembersListSection(BuildContext context) {
  final chatController = Get.find<ChatController>();
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFA9B7DD).withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: chatController.members.length,
      itemBuilder: (context, index) {
        final member = chatController.members[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person,
                  size: 20,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                member,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF484848),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

@override
Widget _buildMediaSection(BuildContext context) {
  final chatController = Get.find<ChatController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE4E5F3))),
        ),
        child: const Text(
          'Media , file & links',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E53B1),
          ),
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE4E5F3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Media',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E53B1),
                  ),
                ),
                const Text(
                  'View all',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4E53B1)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: chatController.mediaUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = chatController.mediaUrls[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenImageViewer(imageUrl: imageUrl),
                      ),
                    );
                  },
                  child: Container(
                    height: 84,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}

@override
Widget _buildFilesSection(BuildContext context) {
  final chatController = Get.find<ChatController>();
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE4E5F3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Files',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E53B1),
              ),
            ),
            const Text(
              'View all',
              style: TextStyle(fontSize: 14, color: Color(0xFF4E53B1)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          children: chatController.files.map((file) {
            return Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF15642),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        file['name']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4E53B1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          file['size']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF484848),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          file['type']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF484848),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      file['date']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF484848),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Color(0xFFE4E5F3), height: 1),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

@override
Widget _buildLinksSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE4E5F3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Links',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E53B1),
              ),
            ),
            const Text(
              'View all',
              style: TextStyle(fontSize: 14, color: Color(0xFF4E53B1)),
            ),
          ],
        ),

        Divider(color: const Color(0xFFE4E5F3), height: 1),
        const SizedBox(height: 14),

        Row(
          children: [
            const Icon(Icons.link, size: 20, color: Color(0xFF5B5B5B)),
            const SizedBox(width: 8),

            const Text(
              'http://drive.google.com',
              style: TextStyle(fontSize: 12, color: Color(0xFF484848)),
            ),
          ],
        ),
      ],
    ),
  );
}
