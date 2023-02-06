// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      title: json['title'] as String,
      description: json['description'] as String,
      dueTime: json['dueTime'] as String,
      priority: $enumDecode(_$PriorityEnumMap, json['priority']),
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dueTime': instance.dueTime,
      'priority': _$PriorityEnumMap[instance.priority]!,
    };

const _$PriorityEnumMap = {
  Priority.high: 'high',
  Priority.medium: 'medium',
  Priority.low: 'low',
  Priority.none: 'none',
};
