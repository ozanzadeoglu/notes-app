

import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';                                                                      

@freezed
abstract class Note with _$Note {
  const Note._();

  factory Note({
    /// Random generated uuid.
    required String uuid,

    /// Title of the note
    required String title,

    /// Content of the note
    required String content,

    /// When was the note created
    required DateTime createdAt,

    /// When was the note updated last time
    required DateTime updatedAt,
  }) = _Note;

}