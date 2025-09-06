import 'package:connectinno_case_client/data/network/models/notes/note_api_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_response.freezed.dart';
part 'notes_response.g.dart';

@freezed
abstract class NotesResponse with _$NotesResponse {
  const factory NotesResponse({
  required final List<NoteApiModel> notes,
  required final String lastSyncDate,

  }) = _NotesResponse;

  const NotesResponse._();

  factory NotesResponse.fromJson(Map<String, dynamic> json) =>
      _$NotesResponseFromJson(json);

}