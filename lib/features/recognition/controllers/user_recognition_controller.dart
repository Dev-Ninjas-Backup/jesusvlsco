import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Simple, local models and a controller to keep the UI reactive and
/// ready to be wired to a backend later.

class CommentModel {
  final String id;
  final String authorName;
  final String message;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.message,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class RecognitionModel {
  final String id;
  final String fromName;
  final String toName;
  final String category; // e.g. "Well done", "Creative"
  final DateTime createdAt;
  String visibility; // e.g. "Everyone can see this" or "10 people can see this"
  int likes;
  final List<CommentModel> comments;
  bool liked;

  RecognitionModel({
    required this.id,
    required this.fromName,
    required this.toName,
    required this.category,
    DateTime? createdAt,
    this.visibility = 'Everyone can see this',
    this.likes = 0,
    List<CommentModel>? comments,
    this.liked = false,
  }) : createdAt = createdAt ?? DateTime.now(),
       comments = comments ?? [];

  RecognitionModel copyWith({
    int? likes,
    bool? liked,
    List<CommentModel>? comments,
    String? visibility,
  }) {
    return RecognitionModel(
      id: id,
      fromName: fromName,
      toName: toName,
      category: category,
      createdAt: createdAt,
      visibility: visibility ?? this.visibility,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      liked: liked ?? this.liked,
    );
  }
}

class UserRecognitionController extends GetxController {
  // Reactive list of recognitions.
  final RxList<RecognitionModel> recognitions = <RecognitionModel>[].obs;

  // simple categories for the horizontal "My recognition" row
  final RxList<String> categories = <String>[
    'Creative',
    'Well done',
    'Leader',
    'Creative',
  ].obs;

  // Filters for the recognition feed dropdown. Default matches the design options.
  final List<String> filters = [
    'All Recognitions',
    'My Recognitions',
    'Shared with Me',
  ];

  final RxString selectedFilter = 'All Recognitions'.obs;

  // text controller used by the write input at the bottom
  final TextEditingController inputController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMockData();
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }

  // Placeholder for a backend call. Right now it creates mock entries.
  Future<void> fetchMockData() async {
    await Future.delayed(const Duration(milliseconds: 250));

    recognitions.assignAll([
      RecognitionModel(
        id: 'r1',
        fromName: 'XYZ',
        toName: 'Sahida Akter',
        category: 'Well Done',
        createdAt: DateTime(2025, 6, 21, 15, 25),
        visibility: 'Everyone can see this',
        likes: 0,
        comments: [],
      ),
      RecognitionModel(
        id: 'r2',
        fromName: 'ABC',
        toName: 'Sahida Akter',
        category: 'Well Done',
        createdAt: DateTime(2025, 6, 19, 14, 46),
        visibility: '10 people can see this',
        likes: 1,
        comments: [
          CommentModel(
            id: 'c1',
            authorName: 'Leslie Alexander',
            message: 'Well-done! Keep it up.',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
          CommentModel(
            id: 'c2',
            authorName: 'Cody Fisher',
            message: 'Thanks',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ],
      ),
    ]);
  }

  // Toggle like locally and update counts. Backend call can be wired here.
  void toggleLike(String recognitionId) {
    final idx = recognitions.indexWhere((r) => r.id == recognitionId);
    if (idx == -1) return;
    final current = recognitions[idx];
    final liked = !current.liked;
    final likes = liked
        ? current.likes + 1
        : (current.likes > 0 ? current.likes - 1 : 0);
    recognitions[idx] = current.copyWith(likes: likes, liked: liked);
  }

  // Add comment locally and clear input. Backend call can be wired here.
  void addComment(String recognitionId, String authorName, String message) {
    if (message.trim().isEmpty) return;
    final idx = recognitions.indexWhere((r) => r.id == recognitionId);
    if (idx == -1) return;
    final r = recognitions[idx];
    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: authorName,
      message: message.trim(),
    );
    final updatedComments = List<CommentModel>.from(r.comments)
      ..add(newComment);
    recognitions[idx] = r.copyWith(comments: updatedComments);
  }

  // Convenience helper for the UI to post a comment from the bottom input.
  void postFromInput(String recognitionId, String authorName) {
    final text = inputController.text;
    if (text.trim().isEmpty) return;
    addComment(recognitionId, authorName, text);
    inputController.clear();
  }
}
