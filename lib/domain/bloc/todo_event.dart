part of 'todo_bloc.dart';

abstract class TodoEvent {}

class LoadTodoBlocEvent extends TodoEvent {}

class AddTodoBlocEvent extends TodoEvent {
  AddTodoBlocEvent(this.todoModel);
  TodoModel todoModel;
}

class DeleteTodoBlocEvent extends TodoEvent {
  DeleteTodoBlocEvent(this.index);
  int index;
}

class CompleteTodoBlocEvent extends TodoEvent {}
