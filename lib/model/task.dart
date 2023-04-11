import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  int statusId;

  Task(this.id, this.title, this.description, this.date, this.startTime,
      this.endTime, this.statusId);

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "statusId": statusId
    };
  }

  static Task fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return Task(map["id"], map["title"], map["description"], map["date"],
        map["start_time"], map["end_time"], map["status"]);
  }

  static List<Task> tasksFromJson(String str) {
    List<dynamic> jsonVal = json.decode(str);
    return [
      ...jsonVal.map((e) => Task(e["id"], e["title"], e["description"],
          e["date"], e["startTime"], e["endTime"], e["statusId"]))
    ];
  }
}
