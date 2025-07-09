
class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String dateTime;
  final bool isRead;
  final bool hasResponse;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isRead = false,
    this.hasResponse = false,
  });
}
