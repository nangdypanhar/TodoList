import 'package:flutter/material.dart';
import 'package:todolist/Model/todoList.dart';
import 'package:todolist/service/app_service.dart';

class TaskProvider extends ChangeNotifier {
  final AppService service = AppService();

  List<dynamic> _taskLists = [];
  String searchQuery = '';

  List<dynamic> get taskLists {
    if (searchQuery.isEmpty) {
      return _taskLists;
    } else {
      return _taskLists.where((task) {
        return task['task'].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }

  TaskProvider() {
    getData();
  }

  Future<void> getData() async {
    await service.fetchData();
    _taskLists = service.taskLists;
    notifyListeners();
  }

  Future<void> addTask(Todolist newList) async {
    await service.addTask(newList);
    getData();
  }

  Future<void> deleteTask(int id) async {
    await service.deleteTask(id);
    getData();
  }

  Future<void> updateTask(int id, Todolist list) async {
    await service.updateTask(id, list);
    getData();
  }

  Future<void> searchTasks(String query) async {
    await service.search(query);
    searchQuery = query;
    getData();
  }
}
