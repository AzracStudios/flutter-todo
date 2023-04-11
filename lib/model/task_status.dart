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

  static TaskStatus findStatus(List<TaskStatus> statuses, int? id) {
    for (var status in statuses) {
      if (status.id == id) return status;
    }

    return TaskStatus(-1, "null");
  }
}
