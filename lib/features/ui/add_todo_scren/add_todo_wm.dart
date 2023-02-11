import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/data/source/to_do_source/todo_source.dart';
import 'package:todo/domain/bloc/todo_bloc.dart';
import 'package:todo/domain/repository.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_model.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_screen_widget.dart';

abstract class IAddTodoWidgetModel extends IWidgetModel {
  ListenableState<EntityState<TodoModel>> get addTodoScreeenListenable;

  Future<void> goBack();

  TextEditingController get controller;

  void deleteTodo(int index);

  void loadTodo();
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

  // final _todoModelListEntity = EntityStateNotifier<String>();
  // final _todoModelListEntity = ListenableState<EntityState<TodoModel>>();
  final _addTodoScreeenListenable = EntityStateNotifier<TodoModel>();
  
  @override
  // TODO: implement controller
  TextEditingController get controller => throw UnimplementedError();
  
  @override
  void deleteTodo(int index) {
    // TODO: implement deleteTodo
  }
  
  @override
  void loadTodo() {
    // TODO: implement loadTodo
  }
  
  @override
  // TODO: implement mainScreeenListenable
  // ListenableState<EntityState<TodoModel>> get mainScreeenListenable => throw UnimplementedError();
  ListenableState<EntityState<TodoModel>> get addTodoScreeenListenable => _addTodoScreeenListenable;
  
  // @override
  // Future<void> navigateToAddTodoScreen() {
  //   // TODO: implement navigateToAddTodoScreen
  //   throw UnimplementedError();
  // }

  @override
  Future<void> goBack() async {
    await model.goBack(context);

    model.loadTodo();
  }
}
