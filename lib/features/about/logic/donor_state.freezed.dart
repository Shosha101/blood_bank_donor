// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'donor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonorState()';
}


}

/// @nodoc
class $DonorStateCopyWith<$Res>  {
$DonorStateCopyWith(DonorState _, $Res Function(DonorState) __);
}


/// Adds pattern-matching-related methods to [DonorState].
extension DonorStatePatterns on DonorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( DonorStateLoading value)?  loading,TResult Function( DonorStateSuccess value)?  success,TResult Function( DonorStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case DonorStateLoading() when loading != null:
return loading(_that);case DonorStateSuccess() when success != null:
return success(_that);case DonorStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( DonorStateLoading value)  loading,required TResult Function( DonorStateSuccess value)  success,required TResult Function( DonorStateError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case DonorStateLoading():
return loading(_that);case DonorStateSuccess():
return success(_that);case DonorStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( DonorStateLoading value)?  loading,TResult? Function( DonorStateSuccess value)?  success,TResult? Function( DonorStateError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case DonorStateLoading() when loading != null:
return loading(_that);case DonorStateSuccess() when success != null:
return success(_that);case DonorStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DonorModel donor)?  success,TResult Function( ApiErrorModel error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case DonorStateLoading() when loading != null:
return loading();case DonorStateSuccess() when success != null:
return success(_that.donor);case DonorStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DonorModel donor)  success,required TResult Function( ApiErrorModel error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case DonorStateLoading():
return loading();case DonorStateSuccess():
return success(_that.donor);case DonorStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DonorModel donor)?  success,TResult? Function( ApiErrorModel error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case DonorStateLoading() when loading != null:
return loading();case DonorStateSuccess() when success != null:
return success(_that.donor);case DonorStateError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DonorState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonorState.initial()';
}


}




/// @nodoc


class DonorStateLoading implements DonorState {
  const DonorStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonorStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DonorState.loading()';
}


}




/// @nodoc


class DonorStateSuccess implements DonorState {
  const DonorStateSuccess(this.donor);
  

 final  DonorModel donor;

/// Create a copy of DonorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonorStateSuccessCopyWith<DonorStateSuccess> get copyWith => _$DonorStateSuccessCopyWithImpl<DonorStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonorStateSuccess&&(identical(other.donor, donor) || other.donor == donor));
}


@override
int get hashCode => Object.hash(runtimeType,donor);

@override
String toString() {
  return 'DonorState.success(donor: $donor)';
}


}

/// @nodoc
abstract mixin class $DonorStateSuccessCopyWith<$Res> implements $DonorStateCopyWith<$Res> {
  factory $DonorStateSuccessCopyWith(DonorStateSuccess value, $Res Function(DonorStateSuccess) _then) = _$DonorStateSuccessCopyWithImpl;
@useResult
$Res call({
 DonorModel donor
});




}
/// @nodoc
class _$DonorStateSuccessCopyWithImpl<$Res>
    implements $DonorStateSuccessCopyWith<$Res> {
  _$DonorStateSuccessCopyWithImpl(this._self, this._then);

  final DonorStateSuccess _self;
  final $Res Function(DonorStateSuccess) _then;

/// Create a copy of DonorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? donor = null,}) {
  return _then(DonorStateSuccess(
null == donor ? _self.donor : donor // ignore: cast_nullable_to_non_nullable
as DonorModel,
  ));
}


}

/// @nodoc


class DonorStateError implements DonorState {
  const DonorStateError(this.error);
  

 final  ApiErrorModel error;

/// Create a copy of DonorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DonorStateErrorCopyWith<DonorStateError> get copyWith => _$DonorStateErrorCopyWithImpl<DonorStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonorStateError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'DonorState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $DonorStateErrorCopyWith<$Res> implements $DonorStateCopyWith<$Res> {
  factory $DonorStateErrorCopyWith(DonorStateError value, $Res Function(DonorStateError) _then) = _$DonorStateErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel error
});




}
/// @nodoc
class _$DonorStateErrorCopyWithImpl<$Res>
    implements $DonorStateErrorCopyWith<$Res> {
  _$DonorStateErrorCopyWithImpl(this._self, this._then);

  final DonorStateError _self;
  final $Res Function(DonorStateError) _then;

/// Create a copy of DonorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DonorStateError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
