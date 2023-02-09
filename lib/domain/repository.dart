import 'package:todo/data/source/to_do_source/todo_source.dart';

import '../data/models/to_do_list_model/todo_list_model.dart';
import '../data/models/to_do_model/todo_model.dart';

class TodoRepository {
  TodoRepository(
    this._todoLocalDataSource,
  );
  
  final TodoLocalDataSource _todoLocalDataSource;

  Future<void> saveTodo(TodoModel todoModel) => _todoLocalDataSource.saveTodo(todoModel);

  Future<TodoListModel?> loadTodo() => _todoLocalDataSource.loadTodo();

  Future<bool> deleteTodo(int index) => _todoLocalDataSource.deleteTodo(index);
}