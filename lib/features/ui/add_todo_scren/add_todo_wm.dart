import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/data/source/to_do_source/todo_source.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/domain/repository.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_model.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_screen_widget.dart';

abstract class IAddTodoWidgetModel extends IWidgetModel {
  ListenableState<EntityState<TodoModel>> get addTodoScreeenListenable;

  ListenableState<EntityState<Priority>> get priorytiListenable;

  ListenableState<EntityState<bool>> get errorListenable;

  void goBack();

  void addTodo();

  void noneTodo();

  void lowTodo();

  void mediumTodo();

  void highTodo();

  Future<void> pickDate();

  TextEditingController get title;

  TextEditingController get description;

  TextEditingController get date;
}

AddTodoWidgetModel addTodoWidgetModelFactory(BuildContext context) {
  return AddTodoWidgetModel(AddTodoModel(TodoBloc(TodoRepository(
    TodoLocalDataSource(),
  ))));
}

class AddTodoWidgetModel extends WidgetModel<AddTodoScreenWidget, AddTodoModel> implements IAddTodoWidgetModel {
  AddTodoWidgetModel(AddTodoModel model) : super(model);

  final _addTodoScreeenListenable = EntityStateNotifier<TodoModel>();

  final _priotityEntity = EntityStateNotifier<Priority>();

  final _errorEntity = EntityStateNotifier<bool>();

  @override
  ListenableState<EntityState<TodoModel>> get addTodoScreeenListenable => _addTodoScreeenListenable;

  @override
  ListenableState<EntityState<Priority>> get priorytiListenable => _priotityEntity;

  @override
  ListenableState<EntityState<bool>> get errorListenable => _errorEntity;

  late final StreamSubscription<TodoState> _todoBlocStreamSubscription;

  @override
  void initWidgetModel() {
    _priotityEntity.content(Priority.none);
    _errorEntity.content(false);

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

  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _dateController = TextEditingController();

  @override
  TextEditingController get title => _titleController;

  @override
  TextEditingController get description => _descriptionController;

  @override
  TextEditingController get date => _dateController;

  bool _validateData() {
    if (_titleController.text.isEmpty) {
      _errorEntity.content(true);
      return true;
    }

    return false;
  }

  @override
  void addTodo() async {
    if (_validateData()) return;
    //! Вот так можно достать данные из entityState любого который ты используешь, провери обязательны
    if (_priotityEntity.value == null) return;
    if (_priotityEntity.value!.data == null) return;

    TodoModel todoModel = TodoModel(
      title: _titleController.text,
      description: _descriptionController.text,
      dueTime: _dateController.text,
      priority: _priotityEntity.value!.data!,
      isCompleted: false,
    );

    model.addTodo(todoModel);
  }

  @override
  Priority selectedPriority = Priority.none;

  @override
  void highTodo() {
    _priotityEntity.content(Priority.high);
  }

  @override
  void lowTodo() {
    _priotityEntity.content(Priority.low);
  }

  @override
  void mediumTodo() {
    _priotityEntity.content(Priority.medium);
  }

  @override
  void noneTodo() {
    _priotityEntity.content(Priority.none);
  }

  @override
  Future<void> pickDate() async {
    DateTime? pickeddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickeddate == null) return;

    if (pickeddate.year != DateTime.now().year) {
      date.text = DateFormat('EEEE, d MMMM y').format(pickeddate);
      return;
    }
    date.text = DateFormat('EEEE, d MMMM').format(pickeddate);
  }
}
