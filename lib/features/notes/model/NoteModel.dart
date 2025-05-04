class NoteModel{
  String? title;
  String?id;
  String? description;
  // int? date;
  NoteModel(
      {this.id = "",required this.title,
        // required this.date,
        required this.description});

  NoteModel.fromJson(Map<String, dynamic> json)
      : this(
      title: json['title'],
      // date: json['date'],

      description: json['description'],
      id: json['id'],

  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "title": title,
      // "date": date,

    };

  }
}