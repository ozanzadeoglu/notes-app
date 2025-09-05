
import 'package:connectinno_case_client/core/cache/cache_constants.dart';
import 'package:connectinno_case_client/data/models/note/note_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'queue_model.freezed.dart';
part 'queue_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.queue)
abstract class QueueModel with _$QueueModel{
 const QueueModel._();

 const factory QueueModel({
  /// Queued note
  @HiveField(0) required NoteModel note,
  /// Which operation should be done on note, could be post, put, delete
  @HiveField(1) required String operationType,
 }) = _QueueModel;

 /// Generates a consistent key based on note UUID and operation type
 /// Same UUID + operation type = same key
 /// 
 /// This key will be used as key on hiveBox, and thanks to key's being same,
 /// we would just have latest unique operation on a box.
 String get queueKey => '${note.uuid}_$operationType';
}