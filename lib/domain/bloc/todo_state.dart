part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitialBlocState extends TodoState {}

class TodoLoadingBlocState extends TodoState {}

class TodoLoadedBlocState extends TodoState {}

class TodoErrorBlocState extends TodoState {}

class TodoDeletedBlocState extends TodoState {}

class TodoDeletingErrorBlocState extends TodoState {}