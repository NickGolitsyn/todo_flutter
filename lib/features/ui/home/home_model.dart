import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_screen_widget.dart';

class HomeModel extends ElementaryModel {
  HomeModel(this._homeBloc);
  final TodoBloc _homeBloc;

  Stream<TodoState> get homeBlocStream => _homeBloc.stream;

  void deleteTodo(int index) {
    _homeBloc.add(DeleteTodoBlocEvent(index));
  }

  void addTodo(TodoModel todoModel) {
    _homeBloc.add(AddTodoBlocEvent(todoModel));
  }

  void loadTodo() {
    _homeBloc.add(LoadTodoBlocEvent());
  }

  Future<void> navigateToAddTodo(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTodoScreenWidget()));
  }
}
