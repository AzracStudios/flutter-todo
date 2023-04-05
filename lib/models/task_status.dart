class TaskStatus {
  int id;
  String title;

  TaskStatus(this.id, this.title);

  

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
    };
  }

  static TaskStatus fromMapObject(Map<String, dynamic> map) {
    return TaskStatus(map["id"], map["title"]);
  }
}
