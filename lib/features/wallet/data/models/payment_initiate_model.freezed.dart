// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_initiate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentInitiateModel {

 String get orderId; num get amount;
/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentInitiateModelCopyWith<PaymentInitiateModel> get copyWith => _$PaymentInitiateModelCopyWithImpl<PaymentInitiateModel>(this as PaymentInitiateModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentInitiateModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,amount);

@override
String toString() {
  return 'PaymentInitiateModel(orderId: $orderId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PaymentInitiateModelCopyWith<$Res>  {
  factory $PaymentInitiateModelCopyWith(PaymentInitiateModel value, $Res Function(PaymentInitiateModel) _then) = _$PaymentInitiateModelCopyWithImpl;
@useResult
$Res call({
 String orderId, num amount
});




}
/// @nodoc
class _$PaymentInitiateModelCopyWithImpl<$Res>
    implements $PaymentInitiateModelCopyWith<$Res> {
  _$PaymentInitiateModelCopyWithImpl(this._self, this._then);

  final PaymentInitiateModel _self;
  final $Res Function(PaymentInitiateModel) _then;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentInitiateModel].
extension PaymentInitiateModelPatterns on PaymentInitiateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CashfreeInitiateModel value)?  cashfree,TResult Function( RazorpayInitiateModel value)?  razorpay,TResult Function( PayUInitiateModel value)?  payu,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CashfreeInitiateModel() when cashfree != null:
return cashfree(_that);case RazorpayInitiateModel() when razorpay != null:
return razorpay(_that);case PayUInitiateModel() when payu != null:
return payu(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CashfreeInitiateModel value)  cashfree,required TResult Function( RazorpayInitiateModel value)  razorpay,required TResult Function( PayUInitiateModel value)  payu,}){
final _that = this;
switch (_that) {
case CashfreeInitiateModel():
return cashfree(_that);case RazorpayInitiateModel():
return razorpay(_that);case PayUInitiateModel():
return payu(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CashfreeInitiateModel value)?  cashfree,TResult? Function( RazorpayInitiateModel value)?  razorpay,TResult? Function( PayUInitiateModel value)?  payu,}){
final _that = this;
switch (_that) {
case CashfreeInitiateModel() when cashfree != null:
return cashfree(_that);case RazorpayInitiateModel() when razorpay != null:
return razorpay(_that);case PayUInitiateModel() when payu != null:
return payu(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String orderId,  String cfOrderId,  String paymentSessionId,  num amount,  DateTime createdAt,  String status)?  cashfree,TResult Function( String orderId,  String id,  num amount,  num amountDue,  num amountPaid,  String currency,  DateTime createdAt,  String status)?  razorpay,TResult Function( String orderId,  String key,  String txnid,  num amount,  String hash,  String surl,  String furl,  String productInfo,  String firstName,  String email,  String phone)?  payu,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CashfreeInitiateModel() when cashfree != null:
return cashfree(_that.orderId,_that.cfOrderId,_that.paymentSessionId,_that.amount,_that.createdAt,_that.status);case RazorpayInitiateModel() when razorpay != null:
return razorpay(_that.orderId,_that.id,_that.amount,_that.amountDue,_that.amountPaid,_that.currency,_that.createdAt,_that.status);case PayUInitiateModel() when payu != null:
return payu(_that.orderId,_that.key,_that.txnid,_that.amount,_that.hash,_that.surl,_that.furl,_that.productInfo,_that.firstName,_that.email,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String orderId,  String cfOrderId,  String paymentSessionId,  num amount,  DateTime createdAt,  String status)  cashfree,required TResult Function( String orderId,  String id,  num amount,  num amountDue,  num amountPaid,  String currency,  DateTime createdAt,  String status)  razorpay,required TResult Function( String orderId,  String key,  String txnid,  num amount,  String hash,  String surl,  String furl,  String productInfo,  String firstName,  String email,  String phone)  payu,}) {final _that = this;
switch (_that) {
case CashfreeInitiateModel():
return cashfree(_that.orderId,_that.cfOrderId,_that.paymentSessionId,_that.amount,_that.createdAt,_that.status);case RazorpayInitiateModel():
return razorpay(_that.orderId,_that.id,_that.amount,_that.amountDue,_that.amountPaid,_that.currency,_that.createdAt,_that.status);case PayUInitiateModel():
return payu(_that.orderId,_that.key,_that.txnid,_that.amount,_that.hash,_that.surl,_that.furl,_that.productInfo,_that.firstName,_that.email,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String orderId,  String cfOrderId,  String paymentSessionId,  num amount,  DateTime createdAt,  String status)?  cashfree,TResult? Function( String orderId,  String id,  num amount,  num amountDue,  num amountPaid,  String currency,  DateTime createdAt,  String status)?  razorpay,TResult? Function( String orderId,  String key,  String txnid,  num amount,  String hash,  String surl,  String furl,  String productInfo,  String firstName,  String email,  String phone)?  payu,}) {final _that = this;
switch (_that) {
case CashfreeInitiateModel() when cashfree != null:
return cashfree(_that.orderId,_that.cfOrderId,_that.paymentSessionId,_that.amount,_that.createdAt,_that.status);case RazorpayInitiateModel() when razorpay != null:
return razorpay(_that.orderId,_that.id,_that.amount,_that.amountDue,_that.amountPaid,_that.currency,_that.createdAt,_that.status);case PayUInitiateModel() when payu != null:
return payu(_that.orderId,_that.key,_that.txnid,_that.amount,_that.hash,_that.surl,_that.furl,_that.productInfo,_that.firstName,_that.email,_that.phone);case _:
  return null;

}
}

}

/// @nodoc


class CashfreeInitiateModel extends PaymentInitiateModel {
  const CashfreeInitiateModel({required this.orderId, required this.cfOrderId, required this.paymentSessionId, required this.amount, required this.createdAt, required this.status}): super._();
  

@override final  String orderId;
 final  String cfOrderId;
 final  String paymentSessionId;
@override final  num amount;
 final  DateTime createdAt;
 final  String status;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashfreeInitiateModelCopyWith<CashfreeInitiateModel> get copyWith => _$CashfreeInitiateModelCopyWithImpl<CashfreeInitiateModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashfreeInitiateModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.cfOrderId, cfOrderId) || other.cfOrderId == cfOrderId)&&(identical(other.paymentSessionId, paymentSessionId) || other.paymentSessionId == paymentSessionId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,cfOrderId,paymentSessionId,amount,createdAt,status);

@override
String toString() {
  return 'PaymentInitiateModel.cashfree(orderId: $orderId, cfOrderId: $cfOrderId, paymentSessionId: $paymentSessionId, amount: $amount, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $CashfreeInitiateModelCopyWith<$Res> implements $PaymentInitiateModelCopyWith<$Res> {
  factory $CashfreeInitiateModelCopyWith(CashfreeInitiateModel value, $Res Function(CashfreeInitiateModel) _then) = _$CashfreeInitiateModelCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String cfOrderId, String paymentSessionId, num amount, DateTime createdAt, String status
});




}
/// @nodoc
class _$CashfreeInitiateModelCopyWithImpl<$Res>
    implements $CashfreeInitiateModelCopyWith<$Res> {
  _$CashfreeInitiateModelCopyWithImpl(this._self, this._then);

  final CashfreeInitiateModel _self;
  final $Res Function(CashfreeInitiateModel) _then;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? cfOrderId = null,Object? paymentSessionId = null,Object? amount = null,Object? createdAt = null,Object? status = null,}) {
  return _then(CashfreeInitiateModel(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,cfOrderId: null == cfOrderId ? _self.cfOrderId : cfOrderId // ignore: cast_nullable_to_non_nullable
as String,paymentSessionId: null == paymentSessionId ? _self.paymentSessionId : paymentSessionId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RazorpayInitiateModel extends PaymentInitiateModel {
  const RazorpayInitiateModel({required this.orderId, required this.id, required this.amount, required this.amountDue, required this.amountPaid, required this.currency, required this.createdAt, required this.status}): super._();
  

@override final  String orderId;
 final  String id;
@override final  num amount;
 final  num amountDue;
 final  num amountPaid;
 final  String currency;
 final  DateTime createdAt;
 final  String status;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RazorpayInitiateModelCopyWith<RazorpayInitiateModel> get copyWith => _$RazorpayInitiateModelCopyWithImpl<RazorpayInitiateModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RazorpayInitiateModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountDue, amountDue) || other.amountDue == amountDue)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,id,amount,amountDue,amountPaid,currency,createdAt,status);

@override
String toString() {
  return 'PaymentInitiateModel.razorpay(orderId: $orderId, id: $id, amount: $amount, amountDue: $amountDue, amountPaid: $amountPaid, currency: $currency, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $RazorpayInitiateModelCopyWith<$Res> implements $PaymentInitiateModelCopyWith<$Res> {
  factory $RazorpayInitiateModelCopyWith(RazorpayInitiateModel value, $Res Function(RazorpayInitiateModel) _then) = _$RazorpayInitiateModelCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String id, num amount, num amountDue, num amountPaid, String currency, DateTime createdAt, String status
});




}
/// @nodoc
class _$RazorpayInitiateModelCopyWithImpl<$Res>
    implements $RazorpayInitiateModelCopyWith<$Res> {
  _$RazorpayInitiateModelCopyWithImpl(this._self, this._then);

  final RazorpayInitiateModel _self;
  final $Res Function(RazorpayInitiateModel) _then;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? id = null,Object? amount = null,Object? amountDue = null,Object? amountPaid = null,Object? currency = null,Object? createdAt = null,Object? status = null,}) {
  return _then(RazorpayInitiateModel(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,amountDue: null == amountDue ? _self.amountDue : amountDue // ignore: cast_nullable_to_non_nullable
as num,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PayUInitiateModel extends PaymentInitiateModel {
  const PayUInitiateModel({required this.orderId, required this.key, required this.txnid, required this.amount, required this.hash, required this.surl, required this.furl, required this.productInfo, required this.firstName, required this.email, required this.phone}): super._();
  

@override final  String orderId;
 final  String key;
 final  String txnid;
@override final  num amount;
 final  String hash;
 final  String surl;
 final  String furl;
 final  String productInfo;
 final  String firstName;
 final  String email;
 final  String phone;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayUInitiateModelCopyWith<PayUInitiateModel> get copyWith => _$PayUInitiateModelCopyWithImpl<PayUInitiateModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayUInitiateModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.key, key) || other.key == key)&&(identical(other.txnid, txnid) || other.txnid == txnid)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.surl, surl) || other.surl == surl)&&(identical(other.furl, furl) || other.furl == furl)&&(identical(other.productInfo, productInfo) || other.productInfo == productInfo)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,key,txnid,amount,hash,surl,furl,productInfo,firstName,email,phone);

@override
String toString() {
  return 'PaymentInitiateModel.payu(orderId: $orderId, key: $key, txnid: $txnid, amount: $amount, hash: $hash, surl: $surl, furl: $furl, productInfo: $productInfo, firstName: $firstName, email: $email, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $PayUInitiateModelCopyWith<$Res> implements $PaymentInitiateModelCopyWith<$Res> {
  factory $PayUInitiateModelCopyWith(PayUInitiateModel value, $Res Function(PayUInitiateModel) _then) = _$PayUInitiateModelCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String key, String txnid, num amount, String hash, String surl, String furl, String productInfo, String firstName, String email, String phone
});




}
/// @nodoc
class _$PayUInitiateModelCopyWithImpl<$Res>
    implements $PayUInitiateModelCopyWith<$Res> {
  _$PayUInitiateModelCopyWithImpl(this._self, this._then);

  final PayUInitiateModel _self;
  final $Res Function(PayUInitiateModel) _then;

/// Create a copy of PaymentInitiateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? key = null,Object? txnid = null,Object? amount = null,Object? hash = null,Object? surl = null,Object? furl = null,Object? productInfo = null,Object? firstName = null,Object? email = null,Object? phone = null,}) {
  return _then(PayUInitiateModel(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,txnid: null == txnid ? _self.txnid : txnid // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,surl: null == surl ? _self.surl : surl // ignore: cast_nullable_to_non_nullable
as String,furl: null == furl ? _self.furl : furl // ignore: cast_nullable_to_non_nullable
as String,productInfo: null == productInfo ? _self.productInfo : productInfo // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
