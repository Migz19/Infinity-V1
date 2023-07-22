

class EventModel {
  String title;
  List<String> ?images;
  String date;
  String location;
  String description;
  String ?id;

  EventModel(
      {required this.title,
      required this.images,
      required this.date,
      required this.location,
      required this.description,  this.id});

}
