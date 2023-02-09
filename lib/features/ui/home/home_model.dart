import 'package:elementary/elementary.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';

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
}
