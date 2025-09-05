import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import '../../../domain/entities/note/note.dart';
import '../../../core/cache/cache_constants.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.note)
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    @HiveField(0) required String uuid,
    @HiveField(1) required String title,
    @HiveField(2) required String content,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) required DateTime updatedAt,
  }) = _NoteModel;

  const NoteModel._();

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  factory NoteModel.fromEntity(Note entity) {
    return NoteModel(
      uuid: entity.uuid,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Note toEntity() {
    return Note(
      uuid: uuid,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}