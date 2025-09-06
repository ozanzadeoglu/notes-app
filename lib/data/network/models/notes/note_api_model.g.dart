// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteApiModel _$NoteApiModelFromJson(Map<String, dynamic> json) =>
    _NoteApiModel(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool,
    );

Map<String, dynamic> _$NoteApiModelToJson(_NoteApiModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
    };
