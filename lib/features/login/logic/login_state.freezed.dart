// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( LoginStateLoading value)?  loading,TResult Function( LoginStateSuccess value)?  success,TResult Function( LoginStateLogoutSuccess value)?  logoutSuccess,TResult Function( LoginStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case LoginStateLoading() when loading != null:
return loading(_that);case LoginStateSuccess() when success != null:
return success(_that);case LoginStateLogoutSuccess() when logoutSuccess != null:
return logoutSuccess(_that);case LoginStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( LoginStateLoading value)  loading,required TResult Function( LoginStateSuccess value)  success,required TResult Function( LoginStateLogoutSuccess value)  logoutSuccess,required TResult Function( LoginStateError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case LoginStateLoading():
return loading(_that);case LoginStateSuccess():
return success(_that);case LoginStateLogoutSuccess():
return logoutSuccess(_that);case LoginStateError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( LoginStateLoading value)?  loading,TResult? Function( LoginStateSuccess value)?  success,TResult? Function( LoginStateLogoutSuccess value)?  logoutSuccess,TResult? Function( LoginStateError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case LoginStateLoading() when loading != null:
return loading(_that);case LoginStateSuccess() when success != null:
return success(_that);case LoginStateLogoutSuccess() when logoutSuccess != null:
return logoutSuccess(_that);case LoginStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LoginResponse loginResponse,  String? phoneNumber)?  success,TResult Function()?  logoutSuccess,TResult Function( ErrorHandler errorHandler)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case LoginStateLoading() when loading != null:
return loading();case LoginStateSuccess() when success != null:
return success(_that.loginResponse,_that.phoneNumber);case LoginStateLogoutSuccess() when logoutSuccess != null:
return logoutSuccess();case LoginStateError() when error != null:
return error(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LoginResponse loginResponse,  String? phoneNumber)  success,required TResult Function()  logoutSuccess,required TResult Function( ErrorHandler errorHandler)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case LoginStateLoading():
return loading();case LoginStateSuccess():
return success(_that.loginResponse,_that.phoneNumber);case LoginStateLogoutSuccess():
return logoutSuccess();case LoginStateError():
return error(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LoginResponse loginResponse,  String? phoneNumber)?  success,TResult? Function()?  logoutSuccess,TResult? Function( ErrorHandler errorHandler)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case LoginStateLoading() when loading != null:
return loading();case LoginStateSuccess() when success != null:
return success(_that.loginResponse,_that.phoneNumber);case LoginStateLogoutSuccess() when logoutSuccess != null:
return logoutSuccess();case LoginStateError() when error != null:
return error(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LoginState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class LoginStateLoading implements LoginState {
  const LoginStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loading()';
}


}




/// @nodoc


class LoginStateSuccess implements LoginState {
  const LoginStateSuccess(this.loginResponse, {this.phoneNumber});
  

 final  LoginResponse loginResponse;
 final  String? phoneNumber;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateSuccessCopyWith<LoginStateSuccess> get copyWith => _$LoginStateSuccessCopyWithImpl<LoginStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateSuccess&&(identical(other.loginResponse, loginResponse) || other.loginResponse == loginResponse)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,loginResponse,phoneNumber);

@override
String toString() {
  return 'LoginState.success(loginResponse: $loginResponse, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $LoginStateSuccessCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $LoginStateSuccessCopyWith(LoginStateSuccess value, $Res Function(LoginStateSuccess) _then) = _$LoginStateSuccessCopyWithImpl;
@useResult
$Res call({
 LoginResponse loginResponse, String? phoneNumber
});




}
/// @nodoc
class _$LoginStateSuccessCopyWithImpl<$Res>
    implements $LoginStateSuccessCopyWith<$Res> {
  _$LoginStateSuccessCopyWithImpl(this._self, this._then);

  final LoginStateSuccess _self;
  final $Res Function(LoginStateSuccess) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginResponse = null,Object? phoneNumber = freezed,}) {
  return _then(LoginStateSuccess(
null == loginResponse ? _self.loginResponse : loginResponse // ignore: cast_nullable_to_non_nullable
as LoginResponse,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class LoginStateLogoutSuccess implements LoginState {
  const LoginStateLogoutSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateLogoutSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.logoutSuccess()';
}


}




/// @nodoc


class LoginStateError implements LoginState {
  const LoginStateError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateErrorCopyWith<LoginStateError> get copyWith => _$LoginStateErrorCopyWithImpl<LoginStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStateError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'LoginState.error(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $LoginStateErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $LoginStateErrorCopyWith(LoginStateError value, $Res Function(LoginStateError) _then) = _$LoginStateErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$LoginStateErrorCopyWithImpl<$Res>
    implements $LoginStateErrorCopyWith<$Res> {
  _$LoginStateErrorCopyWithImpl(this._self, this._then);

  final LoginStateError _self;
  final $Res Function(LoginStateError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(LoginStateError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
