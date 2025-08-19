// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestsState()';
}


}

/// @nodoc
class $RequestsStateCopyWith<$Res>  {
$RequestsStateCopyWith(RequestsState _, $Res Function(RequestsState) __);
}


/// Adds pattern-matching-related methods to [RequestsState].
extension RequestsStatePatterns on RequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( RequestsStateLoading value)?  loading,TResult Function( RequestsStateSuccess value)?  success,TResult Function( RequestsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case RequestsStateLoading() when loading != null:
return loading(_that);case RequestsStateSuccess() when success != null:
return success(_that);case RequestsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( RequestsStateLoading value)  loading,required TResult Function( RequestsStateSuccess value)  success,required TResult Function( RequestsStateError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case RequestsStateLoading():
return loading(_that);case RequestsStateSuccess():
return success(_that);case RequestsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( RequestsStateLoading value)?  loading,TResult? Function( RequestsStateSuccess value)?  success,TResult? Function( RequestsStateError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case RequestsStateLoading() when loading != null:
return loading(_that);case RequestsStateSuccess() when success != null:
return success(_that);case RequestsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RequestModel> requests)?  success,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case RequestsStateLoading() when loading != null:
return loading();case RequestsStateSuccess() when success != null:
return success(_that.requests);case RequestsStateError() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RequestModel> requests)  success,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case RequestsStateLoading():
return loading();case RequestsStateSuccess():
return success(_that.requests);case RequestsStateError():
return error(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RequestModel> requests)?  success,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case RequestsStateLoading() when loading != null:
return loading();case RequestsStateSuccess() when success != null:
return success(_that.requests);case RequestsStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RequestsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestsState.initial()';
}


}




/// @nodoc


class RequestsStateLoading implements RequestsState {
  const RequestsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RequestsState.loading()';
}


}




/// @nodoc


class RequestsStateSuccess implements RequestsState {
  const RequestsStateSuccess(final  List<RequestModel> requests): _requests = requests;
  

 final  List<RequestModel> _requests;
 List<RequestModel> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}


/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestsStateSuccessCopyWith<RequestsStateSuccess> get copyWith => _$RequestsStateSuccessCopyWithImpl<RequestsStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsStateSuccess&&const DeepCollectionEquality().equals(other._requests, _requests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requests));

@override
String toString() {
  return 'RequestsState.success(requests: $requests)';
}


}

/// @nodoc
abstract mixin class $RequestsStateSuccessCopyWith<$Res> implements $RequestsStateCopyWith<$Res> {
  factory $RequestsStateSuccessCopyWith(RequestsStateSuccess value, $Res Function(RequestsStateSuccess) _then) = _$RequestsStateSuccessCopyWithImpl;
@useResult
$Res call({
 List<RequestModel> requests
});




}
/// @nodoc
class _$RequestsStateSuccessCopyWithImpl<$Res>
    implements $RequestsStateSuccessCopyWith<$Res> {
  _$RequestsStateSuccessCopyWithImpl(this._self, this._then);

  final RequestsStateSuccess _self;
  final $Res Function(RequestsStateSuccess) _then;

/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requests = null,}) {
  return _then(RequestsStateSuccess(
null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<RequestModel>,
  ));
}


}

/// @nodoc


class RequestsStateError implements RequestsState {
  const RequestsStateError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestsStateErrorCopyWith<RequestsStateError> get copyWith => _$RequestsStateErrorCopyWithImpl<RequestsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'RequestsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $RequestsStateErrorCopyWith<$Res> implements $RequestsStateCopyWith<$Res> {
  factory $RequestsStateErrorCopyWith(RequestsStateError value, $Res Function(RequestsStateError) _then) = _$RequestsStateErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$RequestsStateErrorCopyWithImpl<$Res>
    implements $RequestsStateErrorCopyWith<$Res> {
  _$RequestsStateErrorCopyWithImpl(this._self, this._then);

  final RequestsStateError _self;
  final $Res Function(RequestsStateError) _then;

/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(RequestsStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
