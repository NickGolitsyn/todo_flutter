import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/source/to_do_source/todo_source.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/domain/repository.dart';
import 'package:todo/features/ui/home/home_model.dart';

import '../../../data/models/to_do_model/todo_model.dart';
import 'home_view.dart';

abstract class IHomeWidgetModel extends IWidgetModel {
  ListenableState<EntityState<String>> get mainScreeenListenable;
  ListenableState<EntityState<TodoModel>> get totoModelListenable;

  ListenableState<EntityState<List<TodoModel>>> get todoModelListEntity;

  Future<void> navigateToAddTodoScreen();

  TextEditingController get controller;

  void deleteTodo(int index);

  void loadTodo();
}

HomeWidgetModel homeWidgetModelFactory(BuildContext context) {
  return HomeWidgetModel(
    HomeModel(
      TodoBloc(TodoRepository(
        TodoLocalDataSource(),
      )),
    ),
  );
}

class HomeWidgetModel extends WidgetModel<HomeScreenWidget, HomeModel> implements IHomeWidgetModel {
  HomeWidgetModel(HomeModel model) : super(model);

  final _mainScreenEntity = EntityStateNotifier<String>();

  late final StreamSubscription<TodoState> _homeBlocStreamSubcription;

  @override
  void initWidgetModel() {
    model.loadTodo();

    _homeBlocStreamSubcription = model.homeBlocStream.listen(_updateStates);

    super.initWidgetModel();
  }

  void _updateStates(TodoState state) {
    if (state is TodoLoadedBlocState) {
      _todoModelEntity.content(state.todoModels);
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
    print('done');
    model.loadTodo();
  }

  @override
  void loadTodo() {}

  final _contoller = TextEditingController();

  @override
  TextEditingController get controller => _contoller;

  @override
  ListenableState<EntityState<TodoModel>> get totoModelListenable => throw UnimplementedError();

  final _todoModelEntity = EntityStateNotifier<List<TodoModel>>();

  @override
  ListenableState<EntityState<List<TodoModel>>> get todoModelListEntity => _todoModelEntity;

  @override
  Future<void> navigateToAddTodoScreen() async {
    await model.navigateToAddTodo(context);
  }
}
