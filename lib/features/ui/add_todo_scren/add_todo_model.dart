import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';

class AddTodoModel extends ElementaryModel {
  AddTodoModel(this._addTodoBloc);
  final TodoBloc _addTodoBloc;

  Stream<TodoState> get homeBlocStream => _addTodoBloc.stream;

  void addTodo(TodoModel todoModel) async {
    _addTodoBloc.add(AddTodoBlocEvent(todoModel));
  }

  void loadTodo() {
    _addTodoBloc.add(LoadTodoBlocEvent());
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
