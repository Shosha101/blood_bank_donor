// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AboutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AboutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AboutState()';
}


}

/// @nodoc
class $AboutStateCopyWith<$Res>  {
$AboutStateCopyWith(AboutState _, $Res Function(AboutState) __);
}


/// Adds pattern-matching-related methods to [AboutState].
extension AboutStatePatterns on AboutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( AboutStateStateLoading value)?  hospitalsLoading,TResult Function( AboutStateStateError value)?  aboutError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case AboutStateStateLoading() when hospitalsLoading != null:
return hospitalsLoading(_that);case AboutStateStateError() when aboutError != null:
return aboutError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( AboutStateStateLoading value)  hospitalsLoading,required TResult Function( AboutStateStateError value)  aboutError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case AboutStateStateLoading():
return hospitalsLoading(_that);case AboutStateStateError():
return aboutError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( AboutStateStateLoading value)?  hospitalsLoading,TResult? Function( AboutStateStateError value)?  aboutError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case AboutStateStateLoading() when hospitalsLoading != null:
return hospitalsLoading(_that);case AboutStateStateError() when aboutError != null:
return aboutError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  hospitalsLoading,TResult Function( ErrorHandler errorHandler)?  aboutError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case AboutStateStateLoading() when hospitalsLoading != null:
return hospitalsLoading();case AboutStateStateError() when aboutError != null:
return aboutError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  hospitalsLoading,required TResult Function( ErrorHandler errorHandler)  aboutError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case AboutStateStateLoading():
return hospitalsLoading();case AboutStateStateError():
return aboutError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  hospitalsLoading,TResult? Function( ErrorHandler errorHandler)?  aboutError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case AboutStateStateLoading() when hospitalsLoading != null:
return hospitalsLoading();case AboutStateStateError() when aboutError != null:
return aboutError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AboutState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AboutState.initial()';
}


}




/// @nodoc


class AboutStateStateLoading implements AboutState {
  const AboutStateStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AboutStateStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AboutState.hospitalsLoading()';
}


}




/// @nodoc


class AboutStateStateError implements AboutState {
  const AboutStateStateError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of AboutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AboutStateStateErrorCopyWith<AboutStateStateError> get copyWith => _$AboutStateStateErrorCopyWithImpl<AboutStateStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AboutStateStateError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'AboutState.aboutError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $AboutStateStateErrorCopyWith<$Res> implements $AboutStateCopyWith<$Res> {
  factory $AboutStateStateErrorCopyWith(AboutStateStateError value, $Res Function(AboutStateStateError) _then) = _$AboutStateStateErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$AboutStateStateErrorCopyWithImpl<$Res>
    implements $AboutStateStateErrorCopyWith<$Res> {
  _$AboutStateStateErrorCopyWithImpl(this._self, this._then);

  final AboutStateStateError _self;
  final $Res Function(AboutStateStateError) _then;

/// Create a copy of AboutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(AboutStateStateError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
