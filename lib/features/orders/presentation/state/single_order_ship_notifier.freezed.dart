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

 int get step; OrderEntity get order;// --- Shipment dimensions (shared with ship-flow) ---
 String get length; String get width; String get height; String get weight; bool get isEditMode; bool get isSaving; String? get error;// --- Editable customer fields ---
 String get customerName; String get customerMobile; String get addressLane1; String get addressLane2; String get landmark; String get pin; String get city; String get state;// --- Editable order fields ---
 String get paymentMode; String get serviceType; String get codAmount; String get clientOrderId;// --- Editable line items ---
 List<EditLineItem> get lineItems;
/// Create a copy of SingleOrderShipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleOrderShipStateCopyWith<SingleOrderShipState> get copyWith => _$SingleOrderShipStateCopyWithImpl<SingleOrderShipState>(this as SingleOrderShipState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleOrderShipState&&(identical(other.step, step) || other.step == step)&&(identical(other.order, order) || other.order == order)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerMobile, customerMobile) || other.customerMobile == customerMobile)&&(identical(other.addressLane1, addressLane1) || other.addressLane1 == addressLane1)&&(identical(other.addressLane2, addressLane2) || other.addressLane2 == addressLane2)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.codAmount, codAmount) || other.codAmount == codAmount)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&const DeepCollectionEquality().equals(other.lineItems, lineItems));
}


@override
int get hashCode => Object.hashAll([runtimeType,step,order,length,width,height,weight,isEditMode,isSaving,error,customerName,customerMobile,addressLane1,addressLane2,landmark,pin,city,state,paymentMode,serviceType,codAmount,clientOrderId,const DeepCollectionEquality().hash(lineItems)]);

@override
String toString() {
  return 'SingleOrderShipState(step: $step, order: $order, length: $length, width: $width, height: $height, weight: $weight, isEditMode: $isEditMode, isSaving: $isSaving, error: $error, customerName: $customerName, customerMobile: $customerMobile, addressLane1: $addressLane1, addressLane2: $addressLane2, landmark: $landmark, pin: $pin, city: $city, state: $state, paymentMode: $paymentMode, serviceType: $serviceType, codAmount: $codAmount, clientOrderId: $clientOrderId, lineItems: $lineItems)';
}


}

/// @nodoc
abstract mixin class $SingleOrderShipStateCopyWith<$Res>  {
  factory $SingleOrderShipStateCopyWith(SingleOrderShipState value, $Res Function(SingleOrderShipState) _then) = _$SingleOrderShipStateCopyWithImpl;
@useResult
$Res call({
 int step, OrderEntity order, String length, String width, String height, String weight, bool isEditMode, bool isSaving, String? error, String customerName, String customerMobile, String addressLane1, String addressLane2, String landmark, String pin, String city, String state, String paymentMode, String serviceType, String codAmount, String clientOrderId, List<EditLineItem> lineItems
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
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? order = null,Object? length = null,Object? width = null,Object? height = null,Object? weight = null,Object? isEditMode = null,Object? isSaving = null,Object? error = freezed,Object? customerName = null,Object? customerMobile = null,Object? addressLane1 = null,Object? addressLane2 = null,Object? landmark = null,Object? pin = null,Object? city = null,Object? state = null,Object? paymentMode = null,Object? serviceType = null,Object? codAmount = null,Object? clientOrderId = null,Object? lineItems = null,}) {
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
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerMobile: null == customerMobile ? _self.customerMobile : customerMobile // ignore: cast_nullable_to_non_nullable
as String,addressLane1: null == addressLane1 ? _self.addressLane1 : addressLane1 // ignore: cast_nullable_to_non_nullable
as String,addressLane2: null == addressLane2 ? _self.addressLane2 : addressLane2 // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,codAmount: null == codAmount ? _self.codAmount : codAmount // ignore: cast_nullable_to_non_nullable
as String,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<EditLineItem>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int step,  OrderEntity order,  String length,  String width,  String height,  String weight,  bool isEditMode,  bool isSaving,  String? error,  String customerName,  String customerMobile,  String addressLane1,  String addressLane2,  String landmark,  String pin,  String city,  String state,  String paymentMode,  String serviceType,  String codAmount,  String clientOrderId,  List<EditLineItem> lineItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SingleOrderShipState() when $default != null:
return $default(_that.step,_that.order,_that.length,_that.width,_that.height,_that.weight,_that.isEditMode,_that.isSaving,_that.error,_that.customerName,_that.customerMobile,_that.addressLane1,_that.addressLane2,_that.landmark,_that.pin,_that.city,_that.state,_that.paymentMode,_that.serviceType,_that.codAmount,_that.clientOrderId,_that.lineItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int step,  OrderEntity order,  String length,  String width,  String height,  String weight,  bool isEditMode,  bool isSaving,  String? error,  String customerName,  String customerMobile,  String addressLane1,  String addressLane2,  String landmark,  String pin,  String city,  String state,  String paymentMode,  String serviceType,  String codAmount,  String clientOrderId,  List<EditLineItem> lineItems)  $default,) {final _that = this;
switch (_that) {
case _SingleOrderShipState():
return $default(_that.step,_that.order,_that.length,_that.width,_that.height,_that.weight,_that.isEditMode,_that.isSaving,_that.error,_that.customerName,_that.customerMobile,_that.addressLane1,_that.addressLane2,_that.landmark,_that.pin,_that.city,_that.state,_that.paymentMode,_that.serviceType,_that.codAmount,_that.clientOrderId,_that.lineItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int step,  OrderEntity order,  String length,  String width,  String height,  String weight,  bool isEditMode,  bool isSaving,  String? error,  String customerName,  String customerMobile,  String addressLane1,  String addressLane2,  String landmark,  String pin,  String city,  String state,  String paymentMode,  String serviceType,  String codAmount,  String clientOrderId,  List<EditLineItem> lineItems)?  $default,) {final _that = this;
switch (_that) {
case _SingleOrderShipState() when $default != null:
return $default(_that.step,_that.order,_that.length,_that.width,_that.height,_that.weight,_that.isEditMode,_that.isSaving,_that.error,_that.customerName,_that.customerMobile,_that.addressLane1,_that.addressLane2,_that.landmark,_that.pin,_that.city,_that.state,_that.paymentMode,_that.serviceType,_that.codAmount,_that.clientOrderId,_that.lineItems);case _:
  return null;

}
}

}

/// @nodoc


class _SingleOrderShipState implements SingleOrderShipState {
  const _SingleOrderShipState({required this.step, required this.order, required this.length, required this.width, required this.height, required this.weight, required this.isEditMode, required this.isSaving, this.error, required this.customerName, required this.customerMobile, required this.addressLane1, required this.addressLane2, required this.landmark, required this.pin, required this.city, required this.state, required this.paymentMode, required this.serviceType, required this.codAmount, required this.clientOrderId, required final  List<EditLineItem> lineItems}): _lineItems = lineItems;
  

@override final  int step;
@override final  OrderEntity order;
// --- Shipment dimensions (shared with ship-flow) ---
@override final  String length;
@override final  String width;
@override final  String height;
@override final  String weight;
@override final  bool isEditMode;
@override final  bool isSaving;
@override final  String? error;
// --- Editable customer fields ---
@override final  String customerName;
@override final  String customerMobile;
@override final  String addressLane1;
@override final  String addressLane2;
@override final  String landmark;
@override final  String pin;
@override final  String city;
@override final  String state;
// --- Editable order fields ---
@override final  String paymentMode;
@override final  String serviceType;
@override final  String codAmount;
@override final  String clientOrderId;
// --- Editable line items ---
 final  List<EditLineItem> _lineItems;
// --- Editable line items ---
@override List<EditLineItem> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}


/// Create a copy of SingleOrderShipState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleOrderShipStateCopyWith<_SingleOrderShipState> get copyWith => __$SingleOrderShipStateCopyWithImpl<_SingleOrderShipState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleOrderShipState&&(identical(other.step, step) || other.step == step)&&(identical(other.order, order) || other.order == order)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerMobile, customerMobile) || other.customerMobile == customerMobile)&&(identical(other.addressLane1, addressLane1) || other.addressLane1 == addressLane1)&&(identical(other.addressLane2, addressLane2) || other.addressLane2 == addressLane2)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.pin, pin) || other.pin == pin)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.paymentMode, paymentMode) || other.paymentMode == paymentMode)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.codAmount, codAmount) || other.codAmount == codAmount)&&(identical(other.clientOrderId, clientOrderId) || other.clientOrderId == clientOrderId)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems));
}


@override
int get hashCode => Object.hashAll([runtimeType,step,order,length,width,height,weight,isEditMode,isSaving,error,customerName,customerMobile,addressLane1,addressLane2,landmark,pin,city,state,paymentMode,serviceType,codAmount,clientOrderId,const DeepCollectionEquality().hash(_lineItems)]);

@override
String toString() {
  return 'SingleOrderShipState(step: $step, order: $order, length: $length, width: $width, height: $height, weight: $weight, isEditMode: $isEditMode, isSaving: $isSaving, error: $error, customerName: $customerName, customerMobile: $customerMobile, addressLane1: $addressLane1, addressLane2: $addressLane2, landmark: $landmark, pin: $pin, city: $city, state: $state, paymentMode: $paymentMode, serviceType: $serviceType, codAmount: $codAmount, clientOrderId: $clientOrderId, lineItems: $lineItems)';
}


}

/// @nodoc
abstract mixin class _$SingleOrderShipStateCopyWith<$Res> implements $SingleOrderShipStateCopyWith<$Res> {
  factory _$SingleOrderShipStateCopyWith(_SingleOrderShipState value, $Res Function(_SingleOrderShipState) _then) = __$SingleOrderShipStateCopyWithImpl;
@override @useResult
$Res call({
 int step, OrderEntity order, String length, String width, String height, String weight, bool isEditMode, bool isSaving, String? error, String customerName, String customerMobile, String addressLane1, String addressLane2, String landmark, String pin, String city, String state, String paymentMode, String serviceType, String codAmount, String clientOrderId, List<EditLineItem> lineItems
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
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? order = null,Object? length = null,Object? width = null,Object? height = null,Object? weight = null,Object? isEditMode = null,Object? isSaving = null,Object? error = freezed,Object? customerName = null,Object? customerMobile = null,Object? addressLane1 = null,Object? addressLane2 = null,Object? landmark = null,Object? pin = null,Object? city = null,Object? state = null,Object? paymentMode = null,Object? serviceType = null,Object? codAmount = null,Object? clientOrderId = null,Object? lineItems = null,}) {
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
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerMobile: null == customerMobile ? _self.customerMobile : customerMobile // ignore: cast_nullable_to_non_nullable
as String,addressLane1: null == addressLane1 ? _self.addressLane1 : addressLane1 // ignore: cast_nullable_to_non_nullable
as String,addressLane2: null == addressLane2 ? _self.addressLane2 : addressLane2 // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,paymentMode: null == paymentMode ? _self.paymentMode : paymentMode // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,codAmount: null == codAmount ? _self.codAmount : codAmount // ignore: cast_nullable_to_non_nullable
as String,clientOrderId: null == clientOrderId ? _self.clientOrderId : clientOrderId // ignore: cast_nullable_to_non_nullable
as String,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<EditLineItem>,
  ));
}


}

// dart format on
