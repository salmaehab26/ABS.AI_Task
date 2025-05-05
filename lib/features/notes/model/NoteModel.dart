class NoteModel {
  String? userId;
  String? title;
  String? id;
  String? description;


  NoteModel({this.id = "", required this.title, required this.description,required this.userId});

  NoteModel.fromJson(Map<String, dynamic> json)
    : this(
    userId: json['userid'],
        title: json['title'],
        description: json['description'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    return {
      'userid':userId,
      "id": id,
      "description": description,
      "title": title,

      // "date": date,
    };
  }
}
