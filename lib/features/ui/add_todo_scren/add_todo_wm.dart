import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/data/source/to_do_source/todo_source.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/domain/repository.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_model.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_screen_widget.dart';

abstract class IAddTodoWidgetModel extends IWidgetModel {
  ListenableState<EntityState<TodoModel>> get addTodoScreeenListenable;

  void goBack();

  TextEditingController get title;

  TextEditingController get description;

  TextEditingController get date;

  void addTodo(TodoModel todoModel);

  late Priority selectedPriority;
}

AddTodoWidgetModel addTodoWidgetModelFactory(BuildContext context) {
  return AddTodoWidgetModel(
    AddTodoModel(
      TodoBloc(
        TodoRepository(
          TodoLocalDataSource(),
        )
      )
    )
  );
}

class AddTodoWidgetModel extends WidgetModel<AddTodoScreenWidget, AddTodoModel> implements IAddTodoWidgetModel {
  AddTodoWidgetModel(AddTodoModel model) : super(model);

  final _addTodoScreeenListenable = EntityStateNotifier<TodoModel>();

  final _contoller = TextEditingController();

  @override
  TextEditingController get controller => _contoller;

  @override
  ListenableState<EntityState<TodoModel>> get addTodoScreeenListenable => _addTodoScreeenListenable;

  late final StreamSubscription<TodoState> _todoBlocStreamSubscription;

  @override
  void initWidgetModel() {
    _todoBlocStreamSubscription = model.homeBlocStream.listen(_updateTodoBlocStates);

    super.initWidgetModel();
  }

  Future<void> _updateTodoBlocStates(TodoState state) async {
    if (state is TodoAddedBlocState) {
      model.goBack(context);
    }
  }

  @override
  void dispose() {
    _todoBlocStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void goBack() => model.goBack(context);

  final _title = TextEditingController();

  final _description = TextEditingController();

  final _date = TextEditingController();

  @override
  TextEditingController get title => _title;

  @override
  TextEditingController get description => _description;

  @override
  TextEditingController get date => _date;

  @override
  void addTodo(TodoModel todoModel) async {
    model.addTodo(todoModel);
  }
  
  @override
  Priority selectedPriority = Priority.none;
}