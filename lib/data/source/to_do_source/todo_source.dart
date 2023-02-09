import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/to_do_list_model/todo_list_model.dart';
import '../../models/to_do_model/todo_model.dart';

class TodoLocalDataSource {
  String key = 'key2';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<List<TodoModel>> loadTodo() async {
    String? data = await _secureStorage.read(key: key);

    if (data == null) return [];

    TodoListModel todoListModel = TodoListModel.fromJson(jsonDecode(data));
    return todoListModel.todoListModel;
  }

  Future<void> saveTodo(TodoModel todoModel) async {
    List<TodoModel> todoListModels = await loadTodo();

    todoListModels.add(todoModel);

    await _secureStorage.write(key: key, value: jsonEncode(todoListModels));
  }

  Future<void> deleteAllTodo() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> deleteTodo(int index) async {
    List<TodoModel> todoListModels = await loadTodo();
    try {
      todoListModels.removeAt(index);
    } catch (e) {
      return false;
    }
    return true;
    // await _secureStorage.write(key: key, value: jsonEncode(todoListModels));
  }
}
