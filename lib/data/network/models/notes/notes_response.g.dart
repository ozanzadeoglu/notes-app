// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotesResponse _$NotesResponseFromJson(Map<String, dynamic> json) =>
    _NotesResponse(
      notes: (json['notes'] as List<dynamic>)
          .map((e) => NoteApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastSyncDate: json['lastSyncDate'] as String,
    );

Map<String, dynamic> _$NotesResponseToJson(_NotesResponse instance) =>
    <String, dynamic>{
      'notes': instance.notes,
      'lastSyncDate': instance.lastSyncDate,
    };
