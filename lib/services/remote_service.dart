import "dart:convert";

import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:todo_app/model/task.dart";
import "package:http/http.dart" as http;

import "../model/task_status.dart";

class RemoteService {
  var client = http.Client();
  var baseUrl = dotenv.env["API_URL"];
  var headers = {
    "connection": "close",
    "content-type": "application/json; charset=utf-8",
    "server": "Kestrel",
    "transfer-encoding": "chunked"
  };

  Future<List<Task>?> getTasks() async {
    var uri = Uri.parse("$baseUrl/GetAll");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return Task.tasksFromJson(json);
    }
    return null;
  }

  Future<Task?> getTaskById(int id) async {
    var uri = Uri.parse("$baseUrl/Get/$id");
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return Task.tasksFromJson("[{json}]")[0];
    }
    return null;
  }

  Future<List<TaskStatus>?> getStatus() async {
    var uri = Uri.parse("$baseUrl/GetStatus");
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var j = response.body;
      return [...json.decode(j).map((e) => TaskStatus(e["id"], e["title"]))];
    }
    return null;
  }

  Future<int> postTask(dynamic task) async {
    var uri = Uri.parse("$baseUrl/Add");
    var response =
        await client.post(uri, body: json.encode(task), headers: headers);
    return response.statusCode;
  }

  Future<int> putTask(dynamic task) async {
    var uri = Uri.parse("$baseUrl/Update");
    var response =
        await client.put(uri, body: json.encode(task), headers: headers);
    return response.statusCode;
  }

  Future<int> deleteTask(int id) async {
    var uri = Uri.parse("$baseUrl/Delete/$id");
    var response = await client.delete(uri, headers: headers);
    return response.statusCode;
  }
}
