import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/features/ui/home/home_view.dart';

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

  Future<void> goBack(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreenWidget()));
    // await Navigator.pop(context);
  }
}
