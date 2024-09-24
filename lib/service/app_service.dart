import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todolist/Model/todoList.dart';

class AppService {
  List<dynamic> _taskLists = [];

  List<dynamic> get taskLists => _taskLists;

  Future<void> fetchData() async {
    final url = Uri.parse("http://10.0.2.2:3000/lists");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _taskLists = data;
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> addTask(Todolist list) async {
    final url = Uri.parse("http://10.0.2.2:3000/lists");

    // Convert Todolist object to a JSON map
    final Map<String, dynamic> data = list.toJson();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // Handle successful response
        print('Task added successfully: ${response.body}');

        await fetchData();
      } else {
        // Handle error response
        print('Failed to add task: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      // Handle any other errors
      print('Error occurred: $e');
    }
  }

  Future<void> deleteTask(int id) async {
    final url = Uri.parse("http://10.0.2.2:3000/lists/$id");

    try {
      final response = await http.delete(url);

      // Handle different status codes for DELETE requests
      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Task deleted successfully");
        await fetchData(); // Refresh the task list
      } else {
        print('Failed to delete task. Status code: ${response.statusCode}');
        // Print the response body for more details
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  Future<void> updateTask(int id, Todolist list) async {
    final url = Uri.parse("http://10.0.2.2:3000/lists/$id");

    final Map<String, dynamic> data = list.toJson();

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Task updated successfully");
        await fetchData(); // Ensure this function is implemented to refresh data
      } else {
        print('Failed to update task. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> search(String task) async {
    final url = Uri.parse("http://10.0.2.2:3000/lists/search?task=$task");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _taskLists = data; // Update _taskLists with search results
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      print('Error searching tasks: $e');
    }
  }
}
