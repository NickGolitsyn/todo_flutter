import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/source/to_do_source/todo_source.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/domain/repository.dart';
import 'package:todo/home/home_model.dart';

import '../data/models/to_do_model/todo_model.dart';
import 'home_view.dart';

abstract class IHomeWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get mainScreeenListenable;
  ListenableState<EntityState<TodoModel>> get totoModelListenable;

  TextEditingController get controller;

  void deleteTodo(int index);

  void loadTodo();
}

HomeWidgetModel homeWidgetModelFactory(BuildContext context) {
  return HomeWidgetModel(
    HomeModel(
      TodoBloc(
        TodoRepository(
          TodoLocalDataSource(),
        )
      ),
    ),
  );
}

class HomeWidgetModel extends WidgetModel<HomeScreenWidget, HomeModel> implements IHomeWidgetModel {
  HomeWidgetModel(HomeModel model) : super(model);

  final _mainScreenEntity = EntityStateNotifier<String>();

  late final StreamSubscription<TodoState> _homeBlocStreamSubcription;

  @override
  void initWidgetModel() {
    _mainScreenEntity.content('Hello elementary World');

    _homeBlocStreamSubcription = model.homeBlocStream.listen(_updateStates);

    super.initWidgetModel();
  }

  void _updateStates(TodoState state) {
    if (state is TodoDeletedBlocState) {
      print('hi');
    } 
    if (state is TodoDeletingErrorBlocState) {
      print('error');
      _mainScreenEntity.error();
    }
    if (state is TodoLoadingBlocState) {
      print('loading...');
    }
  }

  @override
  ListenableState<EntityState<String>> get mainScreeenListenable => _mainScreenEntity;

  @override
  void dispose() {
    _homeBlocStreamSubcription.cancel();
    super.dispose();
  }

  @override
  void deleteTodo(int index) {
    model.deleteTodo(index);
  }

  @override
  void loadTodo() {}

  final _contoller = TextEditingController();

  @override
  TextEditingController get controller => _contoller;
  
  @override
  ListenableState<EntityState<TodoModel>> get totoModelListenable => throw UnimplementedError();
}