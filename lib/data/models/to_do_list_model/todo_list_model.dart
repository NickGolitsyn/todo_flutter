import 'package:json_annotation/json_annotation.dart';
import '../to_do_model/todo_model.dart';

part 'todo_list_model.g.dart';

@JsonSerializable()
class TodoListModel {
  TodoListModel(this.todoListModel);
  List<TodoModel>? todoListModel;

  factory TodoListModel.fromJson(Map<String, dynamic> json) => _$TodoListModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListModelToJson(this);
}