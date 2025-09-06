// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotesResponse {

 List<NoteApiModel> get notes; String get lastSyncDate;
/// Create a copy of NotesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotesResponseCopyWith<NotesResponse> get copyWith => _$NotesResponseCopyWithImpl<NotesResponse>(this as NotesResponse, _$identity);

  /// Serializes this NotesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotesResponse&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.lastSyncDate, lastSyncDate) || other.lastSyncDate == lastSyncDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notes),lastSyncDate);

@override
String toString() {
  return 'NotesResponse(notes: $notes, lastSyncDate: $lastSyncDate)';
}


}

/// @nodoc
abstract mixin class $NotesResponseCopyWith<$Res>  {
  factory $NotesResponseCopyWith(NotesResponse value, $Res Function(NotesResponse) _then) = _$NotesResponseCopyWithImpl;
@useResult
$Res call({
 List<NoteApiModel> notes, String lastSyncDate
});




}
/// @nodoc
class _$NotesResponseCopyWithImpl<$Res>
    implements $NotesResponseCopyWith<$Res> {
  _$NotesResponseCopyWithImpl(this._self, this._then);

  final NotesResponse _self;
  final $Res Function(NotesResponse) _then;

/// Create a copy of NotesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notes = null,Object? lastSyncDate = null,}) {
  return _then(_self.copyWith(
notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<NoteApiModel>,lastSyncDate: null == lastSyncDate ? _self.lastSyncDate : lastSyncDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotesResponse].
extension NotesResponsePatterns on NotesResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotesResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotesResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotesResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotesResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NoteApiModel> notes,  String lastSyncDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotesResponse() when $default != null:
return $default(_that.notes,_that.lastSyncDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NoteApiModel> notes,  String lastSyncDate)  $default,) {final _that = this;
switch (_that) {
case _NotesResponse():
return $default(_that.notes,_that.lastSyncDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NoteApiModel> notes,  String lastSyncDate)?  $default,) {final _that = this;
switch (_that) {
case _NotesResponse() when $default != null:
return $default(_that.notes,_that.lastSyncDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotesResponse extends NotesResponse {
  const _NotesResponse({required final  List<NoteApiModel> notes, required this.lastSyncDate}): _notes = notes,super._();
  factory _NotesResponse.fromJson(Map<String, dynamic> json) => _$NotesResponseFromJson(json);

 final  List<NoteApiModel> _notes;
@override List<NoteApiModel> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override final  String lastSyncDate;

/// Create a copy of NotesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotesResponseCopyWith<_NotesResponse> get copyWith => __$NotesResponseCopyWithImpl<_NotesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotesResponse&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.lastSyncDate, lastSyncDate) || other.lastSyncDate == lastSyncDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notes),lastSyncDate);

@override
String toString() {
  return 'NotesResponse(notes: $notes, lastSyncDate: $lastSyncDate)';
}


}

/// @nodoc
abstract mixin class _$NotesResponseCopyWith<$Res> implements $NotesResponseCopyWith<$Res> {
  factory _$NotesResponseCopyWith(_NotesResponse value, $Res Function(_NotesResponse) _then) = __$NotesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<NoteApiModel> notes, String lastSyncDate
});




}
/// @nodoc
class __$NotesResponseCopyWithImpl<$Res>
    implements _$NotesResponseCopyWith<$Res> {
  __$NotesResponseCopyWithImpl(this._self, this._then);

  final _NotesResponse _self;
  final $Res Function(_NotesResponse) _then;

/// Create a copy of NotesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notes = null,Object? lastSyncDate = null,}) {
  return _then(_NotesResponse(
notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<NoteApiModel>,lastSyncDate: null == lastSyncDate ? _self.lastSyncDate : lastSyncDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
