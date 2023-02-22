import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/domain/repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._todoRepository) : super(TodoInitialBlocState()) {
    on<DeleteTodoBlocEvent>(_deleteTodo);
    on<AddTodoBlocEvent>(_addTodo);
    on<CompleteTodoBlocEvent>(_completeTodo);
    on<LoadTodoBlocEvent>(_loadTodo);
  }

  final TodoRepository _todoRepository;

  Future<void> _deleteTodo(DeleteTodoBlocEvent event, Emitter emit) async {
    // emit(TodoLoadingBlocState());
    emit(TodoDeletingBlocState());

    await Future.delayed(const Duration(seconds: 1));

    bool res = await _todoRepository.deleteTodo(event.index);

    if (res) {
      emit(TodoDeletedBlocState());
      return;
    }

    emit(TodoDeletingErrorBlocState());
  }

  Future<void> _addTodo(AddTodoBlocEvent event, Emitter emit) async {
    emit(TodoLoadingBlocState());

    bool res = await _todoRepository.saveTodo(event.todoModel);

    if (res) {
      emit(TodoAddedBlocState());
      return;
    }

    emit(TodoAddingErrorBlocState());
  }

  Future<void> _completeTodo(CompleteTodoBlocEvent event, Emitter emit) async {}

  Future<void> _loadTodo(LoadTodoBlocEvent event, Emitter emit) async {
    emit(TodoLoadingBlocState());

    List<TodoModel> todoModel = await _todoRepository.loadTodo();
    todoModel = _sortTodoModel(todoModel);
    emit(TodoLoadedBlocState(todoModel));
  }

  List<TodoModel> _sortTodoModel(List<TodoModel> todoModel) {
    List<TodoModel> todoModelLow = [];
    List<TodoModel> todoModelMedium = [];
    List<TodoModel> todoModelHight = [];
    List<TodoModel> todoModelNone = [];

    for (int i = 0; i < todoModel.length; i++) {
      switch (todoModel[i].priority) {
        case Priority.high:
          todoModelHight.add(todoModel[i]);
          break;
        case Priority.medium:
          todoModelMedium.add(todoModel[i]);
          break;
        case Priority.low:
          todoModelLow.add(todoModel[i]);
          break;
        case Priority.none:
          todoModelNone.add(todoModel[i]);
          break;
      }
    }

    todoModel = todoModelHight;

    for (int i = 0; i < todoModelMedium.length; i++) {
      todoModel.add(todoModelMedium[i]);
    }
    for (int i = 0; i < todoModelLow.length; i++) {
      todoModel.add(todoModelLow[i]);
    }
    for (int i = 0; i < todoModelNone.length; i++) {
      todoModel.add(todoModelNone[i]);
    }
    return todoModel;
  }
}
