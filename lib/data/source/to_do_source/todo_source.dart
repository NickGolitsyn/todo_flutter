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

    TodoListModel todoListModels = TodoListModel.fromJson(jsonDecode(data));
    return todoListModels.todoListModel;
  }

  Future<bool> saveTodo(TodoModel todoModel) async {
    List<TodoModel> todoListModels = await loadTodo();
    TodoListModel todoListModel = TodoListModel(todoListModels);

    try {
      todoListModel.todoListModel.add(todoModel);
      await _secureStorage.write(key: key, value: jsonEncode(todoListModel));
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> deleteAllTodo() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> deleteTodo(int index) async {
    List<TodoModel> todoListModels = await loadTodo();
    try {
      await todoListModels.removeAt(index);
      _secureStorage.write(key: key, value: jsonEncode(todoListModels));
    } catch (e) {
      return false;
    }
    return true;
  }
}
