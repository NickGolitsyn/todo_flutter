part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitialBlocState extends TodoState {}

class TodoLoadingBlocState extends TodoState {}

class TodoLoadedBlocState extends TodoState {
  TodoLoadedBlocState(
    this.todoModels,
  );

  List<TodoModel> todoModels;
}

class TodoErrorBlocState extends TodoState {}

class TodoDeletedBlocState extends TodoState {}

class TodoDeletingErrorBlocState extends TodoState {}

class TodoAddedBlocState extends TodoState {}

class TodoAddingErrorBlocState extends TodoState {}
