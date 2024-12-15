class EventModel {
  final String id;
  final String title;
  final DateTime eventDate;
  final String desc;
  List<dynamic> gifts = [];

  EventModel({
    required this.id,
    required this.title,
    required this.eventDate,
    required this.desc,
  });
}
