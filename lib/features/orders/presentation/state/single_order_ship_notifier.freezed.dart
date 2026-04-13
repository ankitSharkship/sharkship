// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_order_ship_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SingleOrderShipState {

 int get step; OrderEntity get order; String get length; String get width; String get height; String get weight; bool get isEditMode; bool get isSaving; String? get error;
/// Create a copy of SingleOrderShipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleOrderShipStateCopyWith<SingleOrderShipState> get copyWith => _$SingleOrderShipStateCopyWithImpl<SingleOrderShipState>(this as SingleOrderShipState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleOrderShipState&&(identical(other.step, step) || other.step == step)&&(identical(other.order, order) || other.order == order)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,step,order,length,width,height,weight,isEditMode,isSaving,error);

@override
String toString() {
  return 'SingleOrderShipState(step: $step, order: $order, length: $length, width: $width, height: $height, weight: $weight, isEditMode: $isEditMode, isSaving: $isSaving, error: $error)';
}


}

/// @nodoc
abstract mixin class $SingleOrderShipStateCopyWith<$Res>  {
  factory $SingleOrderShipStateCopyWith(SingleOrderShipState value, $Res Function(SingleOrderShipState) _then) = _$SingleOrderShipStateCopyWithImpl;
@useResult
$Res call({
 int step, OrderEntity order, String length, String width, String height, String weight, bool isEditMode, bool isSaving, String? error
});




}
/// @nodoc
class _$SingleOrderShipStateCopyWithImpl<$Res>
    implements $SingleOrderShipStateCopyWith<$Res> {
  _$SingleOrderShipStateCopyWithImpl(this._self, this._then);

  final SingleOrderShipState _self;
  final $Res Function(SingleOrderShipState) _then;

/// Create a copy of SingleOrderShipState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? order = null,Object? length = null,Object? width = null,Object? height = null,Object? weight = null,Object? isEditMode = null,Object? isSaving = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as String,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SingleOrderShipState].
extension SingleOrderShipStatePatterns on SingleOrderShipState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SingleOrderShipState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SingleOrderShipState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SingleOrderShipState value)  $default,){
final _that = this;
switch (_that) {
case _SingleOrderShipState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SingleOrderShipState value)?  $default,){
final _that = this;
switch (_that) {
case _SingleOrderShipState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int step,  OrderEntity order,  String length,  String width,  String height,  String weight,  bool isEditMode,  bool isSaving,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SingleOrderShipState() when $default != null:
return $default(_that.step,_that.order,_that.length,_that.width,_that.height,_that.weight,_that.isEditMode,_that.isSaving,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int step,  OrderEntity order,  String length,  String width,  String height,  String weight,  bool isEditMode,  bool isSaving,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SingleOrderShipState():
return $default(_that.step,_that.order,_that.length,_that.width,_that.height,_that.weight,_that.isEditMode,_that.isSaving,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int step,  OrderEntity order,  String length,  String width,  String height,  String weight,  bool isEditMode,  bool isSaving,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SingleOrderShipState() when $default != null:
return $default(_that.step,_that.order,_that.length,_that.width,_that.height,_that.weight,_that.isEditMode,_that.isSaving,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SingleOrderShipState implements SingleOrderShipState {
  const _SingleOrderShipState({required this.step, required this.order, required this.length, required this.width, required this.height, required this.weight, required this.isEditMode, required this.isSaving, this.error});
  

@override final  int step;
@override final  OrderEntity order;
@override final  String length;
@override final  String width;
@override final  String height;
@override final  String weight;
@override final  bool isEditMode;
@override final  bool isSaving;
@override final  String? error;

/// Create a copy of SingleOrderShipState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleOrderShipStateCopyWith<_SingleOrderShipState> get copyWith => __$SingleOrderShipStateCopyWithImpl<_SingleOrderShipState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleOrderShipState&&(identical(other.step, step) || other.step == step)&&(identical(other.order, order) || other.order == order)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,step,order,length,width,height,weight,isEditMode,isSaving,error);

@override
String toString() {
  return 'SingleOrderShipState(step: $step, order: $order, length: $length, width: $width, height: $height, weight: $weight, isEditMode: $isEditMode, isSaving: $isSaving, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SingleOrderShipStateCopyWith<$Res> implements $SingleOrderShipStateCopyWith<$Res> {
  factory _$SingleOrderShipStateCopyWith(_SingleOrderShipState value, $Res Function(_SingleOrderShipState) _then) = __$SingleOrderShipStateCopyWithImpl;
@override @useResult
$Res call({
 int step, OrderEntity order, String length, String width, String height, String weight, bool isEditMode, bool isSaving, String? error
});




}
/// @nodoc
class __$SingleOrderShipStateCopyWithImpl<$Res>
    implements _$SingleOrderShipStateCopyWith<$Res> {
  __$SingleOrderShipStateCopyWithImpl(this._self, this._then);

  final _SingleOrderShipState _self;
  final $Res Function(_SingleOrderShipState) _then;

/// Create a copy of SingleOrderShipState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? order = null,Object? length = null,Object? width = null,Object? height = null,Object? weight = null,Object? isEditMode = null,Object? isSaving = null,Object? error = freezed,}) {
  return _then(_SingleOrderShipState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as String,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
