import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(
    this._todoRepository
  ) : super(TodoInitialBlocState()) {
    on<DeleteTodoBlocEvent>(_deleteTodo);
    on<AddTodoBlocEvent>(_addTodo);
    on<CompleteTodoBlocEvent>(_completeTodo);
    on<LoadTodoBlocEvent>(_loadTodo);
  }

  final TodoRepository _todoRepository;

  Future<void> _deleteTodo(DeleteTodoBlocEvent event, Emitter emit) async {
    emit(TodoLoadingBlocState());

    await Future.delayed(Duration(seconds: 2));

    bool res = await _todoRepository.deleteTodo(event.index);

    if (res) {
      emit(TodoDeletedBlocState());
      return;
    }

    emit(TodoDeletingErrorBlocState());
  }

  Future<void> _addTodo(AddTodoBlocEvent event, Emitter emit) async {
    emit(TodoLoadingBlocState());

    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> _completeTodo(CompleteTodoBlocEvent event, Emitter emit) async {}

  Future<void> _loadTodo(LoadTodoBlocEvent event, Emitter emit) async {
    emit(TodoLoadingBlocState());

    await Future.delayed(Duration(seconds: 2));

    emit(TodoLoadedBlocState());
  }
}
