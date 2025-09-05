// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueModel {

/// Queued note
@HiveField(0) NoteModel get note;/// Which operation should be done on note, could be post, put, delete
@HiveField(1) String get operationType;
/// Create a copy of QueueModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueModelCopyWith<QueueModel> get copyWith => _$QueueModelCopyWithImpl<QueueModel>(this as QueueModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueModel&&(identical(other.note, note) || other.note == note)&&(identical(other.operationType, operationType) || other.operationType == operationType));
}


@override
int get hashCode => Object.hash(runtimeType,note,operationType);

@override
String toString() {
  return 'QueueModel(note: $note, operationType: $operationType)';
}


}

/// @nodoc
abstract mixin class $QueueModelCopyWith<$Res>  {
  factory $QueueModelCopyWith(QueueModel value, $Res Function(QueueModel) _then) = _$QueueModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) NoteModel note,@HiveField(1) String operationType
});


$NoteModelCopyWith<$Res> get note;

}
/// @nodoc
class _$QueueModelCopyWithImpl<$Res>
    implements $QueueModelCopyWith<$Res> {
  _$QueueModelCopyWithImpl(this._self, this._then);

  final QueueModel _self;
  final $Res Function(QueueModel) _then;

/// Create a copy of QueueModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? note = null,Object? operationType = null,}) {
  return _then(_self.copyWith(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as NoteModel,operationType: null == operationType ? _self.operationType : operationType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of QueueModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteModelCopyWith<$Res> get note {
  
  return $NoteModelCopyWith<$Res>(_self.note, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueModel].
extension QueueModelPatterns on QueueModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueModel value)  $default,){
final _that = this;
switch (_that) {
case _QueueModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueModel value)?  $default,){
final _that = this;
switch (_that) {
case _QueueModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  NoteModel note, @HiveField(1)  String operationType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueModel() when $default != null:
return $default(_that.note,_that.operationType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  NoteModel note, @HiveField(1)  String operationType)  $default,) {final _that = this;
switch (_that) {
case _QueueModel():
return $default(_that.note,_that.operationType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  NoteModel note, @HiveField(1)  String operationType)?  $default,) {final _that = this;
switch (_that) {
case _QueueModel() when $default != null:
return $default(_that.note,_that.operationType);case _:
  return null;

}
}

}

/// @nodoc


class _QueueModel extends QueueModel {
  const _QueueModel({@HiveField(0) required this.note, @HiveField(1) required this.operationType}): super._();
  

/// Queued note
@override@HiveField(0) final  NoteModel note;
/// Which operation should be done on note, could be post, put, delete
@override@HiveField(1) final  String operationType;

/// Create a copy of QueueModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueModelCopyWith<_QueueModel> get copyWith => __$QueueModelCopyWithImpl<_QueueModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueModel&&(identical(other.note, note) || other.note == note)&&(identical(other.operationType, operationType) || other.operationType == operationType));
}


@override
int get hashCode => Object.hash(runtimeType,note,operationType);

@override
String toString() {
  return 'QueueModel(note: $note, operationType: $operationType)';
}


}

/// @nodoc
abstract mixin class _$QueueModelCopyWith<$Res> implements $QueueModelCopyWith<$Res> {
  factory _$QueueModelCopyWith(_QueueModel value, $Res Function(_QueueModel) _then) = __$QueueModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) NoteModel note,@HiveField(1) String operationType
});


@override $NoteModelCopyWith<$Res> get note;

}
/// @nodoc
class __$QueueModelCopyWithImpl<$Res>
    implements _$QueueModelCopyWith<$Res> {
  __$QueueModelCopyWithImpl(this._self, this._then);

  final _QueueModel _self;
  final $Res Function(_QueueModel) _then;

/// Create a copy of QueueModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? note = null,Object? operationType = null,}) {
  return _then(_QueueModel(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as NoteModel,operationType: null == operationType ? _self.operationType : operationType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of QueueModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteModelCopyWith<$Res> get note {
  
  return $NoteModelCopyWith<$Res>(_self.note, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}

// dart format on
