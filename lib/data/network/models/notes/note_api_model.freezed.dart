// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteApiModel {

 String get uuid; String get title; String get content; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted;
/// Create a copy of NoteApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteApiModelCopyWith<NoteApiModel> get copyWith => _$NoteApiModelCopyWithImpl<NoteApiModel>(this as NoteApiModel, _$identity);

  /// Serializes this NoteApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,content,createdAt,updatedAt,isDeleted);

@override
String toString() {
  return 'NoteApiModel(uuid: $uuid, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $NoteApiModelCopyWith<$Res>  {
  factory $NoteApiModelCopyWith(NoteApiModel value, $Res Function(NoteApiModel) _then) = _$NoteApiModelCopyWithImpl;
@useResult
$Res call({
 String uuid, String title, String content, DateTime createdAt, DateTime updatedAt, bool isDeleted
});




}
/// @nodoc
class _$NoteApiModelCopyWithImpl<$Res>
    implements $NoteApiModelCopyWith<$Res> {
  _$NoteApiModelCopyWithImpl(this._self, this._then);

  final NoteApiModel _self;
  final $Res Function(NoteApiModel) _then;

/// Create a copy of NoteApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = null,Object? title = null,Object? content = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteApiModel].
extension NoteApiModelPatterns on NoteApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteApiModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uuid,  String title,  String content,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteApiModel() when $default != null:
return $default(_that.uuid,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uuid,  String title,  String content,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _NoteApiModel():
return $default(_that.uuid,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uuid,  String title,  String content,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _NoteApiModel() when $default != null:
return $default(_that.uuid,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteApiModel extends NoteApiModel {
  const _NoteApiModel({required this.uuid, required this.title, required this.content, required this.createdAt, required this.updatedAt, required this.isDeleted}): super._();
  factory _NoteApiModel.fromJson(Map<String, dynamic> json) => _$NoteApiModelFromJson(json);

@override final  String uuid;
@override final  String title;
@override final  String content;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  bool isDeleted;

/// Create a copy of NoteApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteApiModelCopyWith<_NoteApiModel> get copyWith => __$NoteApiModelCopyWithImpl<_NoteApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,content,createdAt,updatedAt,isDeleted);

@override
String toString() {
  return 'NoteApiModel(uuid: $uuid, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$NoteApiModelCopyWith<$Res> implements $NoteApiModelCopyWith<$Res> {
  factory _$NoteApiModelCopyWith(_NoteApiModel value, $Res Function(_NoteApiModel) _then) = __$NoteApiModelCopyWithImpl;
@override @useResult
$Res call({
 String uuid, String title, String content, DateTime createdAt, DateTime updatedAt, bool isDeleted
});




}
/// @nodoc
class __$NoteApiModelCopyWithImpl<$Res>
    implements _$NoteApiModelCopyWith<$Res> {
  __$NoteApiModelCopyWithImpl(this._self, this._then);

  final _NoteApiModel _self;
  final $Res Function(_NoteApiModel) _then;

/// Create a copy of NoteApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = null,Object? title = null,Object? content = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,}) {
  return _then(_NoteApiModel(
uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
