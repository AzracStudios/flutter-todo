class Task {
  int? _id;
  String _title;
  String _description;
  String date;
  String startTime;
  String endTime;

  Task(this._title, this._description, this.date, this.startTime, this.endTime);
  Task.withId(this._id, this._title, this._description, this.date,
      this.startTime, this.endTime);

  int? get id => _id;
  String get title => _title;
  String get description => _description;

  set title(String newTitle) {
    if (newTitle.length < 30 && newTitle.length > 6) _title = newTitle;
  }

  set description(String newDescription) {
    if (newDescription.length < 300) _description = newDescription;
  }

  Map<String, Object?> toMap() {
    return {
      "id": _id,
      "title": _title,
      "description": _description,
      "date": date,
      "start_time": startTime,
      "end_time": endTime
    };
  }

  static Task fromMapObject(Map<String, dynamic> map) {
    return Task.withId(map["id"], map["title"], map["description"], map["date"],
        map["start_time"], map["end_time"]);
  }
}