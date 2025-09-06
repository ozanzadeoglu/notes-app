import 'package:connectinno_case_client/data/models/note/note_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_api_model.freezed.dart';
part 'note_api_model.g.dart';

@freezed
abstract class NoteApiModel with _$NoteApiModel {
  const factory NoteApiModel({
     required String uuid,
     required String title,
     required String content,
     required DateTime createdAt,
     required DateTime updatedAt,
     required bool isDeleted,
  }) = _NoteApiModel;

  const NoteApiModel._();

  factory NoteApiModel.fromJson(Map<String, dynamic> json) =>
      _$NoteApiModelFromJson(json);

    NoteModel toModel() {
    return NoteModel(
      uuid: uuid,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

