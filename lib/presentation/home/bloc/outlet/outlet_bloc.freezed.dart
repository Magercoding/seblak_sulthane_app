// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outlet_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OutletEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OutletEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OutletEvent()';
  }
}

/// @nodoc
class $OutletEventCopyWith<$Res> {
  $OutletEventCopyWith(OutletEvent _, $Res Function(OutletEvent) __);
}

/// Adds pattern-matching-related methods to [OutletEvent].
extension OutletEventPatterns on OutletEvent {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOutlet value)? getOutlet,
    TResult Function(_SaveOutlet value)? saveOutlet,
    TResult Function(_GetAllOutlets value)? getAllOutlets,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetOutlet() when getOutlet != null:
        return getOutlet(_that);
      case _SaveOutlet() when saveOutlet != null:
        return saveOutlet(_that);
      case _GetAllOutlets() when getAllOutlets != null:
        return getAllOutlets(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOutlet value) getOutlet,
    required TResult Function(_SaveOutlet value) saveOutlet,
    required TResult Function(_GetAllOutlets value) getAllOutlets,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _GetOutlet():
        return getOutlet(_that);
      case _SaveOutlet():
        return saveOutlet(_that);
      case _GetAllOutlets():
        return getAllOutlets(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOutlet value)? getOutlet,
    TResult? Function(_SaveOutlet value)? saveOutlet,
    TResult? Function(_GetAllOutlets value)? getAllOutlets,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetOutlet() when getOutlet != null:
        return getOutlet(_that);
      case _SaveOutlet() when saveOutlet != null:
        return saveOutlet(_that);
      case _GetAllOutlets() when getAllOutlets != null:
        return getAllOutlets(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int id)? getOutlet,
    TResult Function(OutletModel outlet)? saveOutlet,
    TResult Function()? getAllOutlets,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetOutlet() when getOutlet != null:
        return getOutlet(_that.id);
      case _SaveOutlet() when saveOutlet != null:
        return saveOutlet(_that.outlet);
      case _GetAllOutlets() when getAllOutlets != null:
        return getAllOutlets();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int id) getOutlet,
    required TResult Function(OutletModel outlet) saveOutlet,
    required TResult Function() getAllOutlets,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _GetOutlet():
        return getOutlet(_that.id);
      case _SaveOutlet():
        return saveOutlet(_that.outlet);
      case _GetAllOutlets():
        return getAllOutlets();
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int id)? getOutlet,
    TResult? Function(OutletModel outlet)? saveOutlet,
    TResult? Function()? getAllOutlets,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetOutlet() when getOutlet != null:
        return getOutlet(_that.id);
      case _SaveOutlet() when saveOutlet != null:
        return saveOutlet(_that.outlet);
      case _GetAllOutlets() when getAllOutlets != null:
        return getAllOutlets();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements OutletEvent {
  const _Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OutletEvent.started()';
  }
}

/// @nodoc

class _GetOutlet implements OutletEvent {
  const _GetOutlet(this.id);

  final int id;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetOutletCopyWith<_GetOutlet> get copyWith =>
      __$GetOutletCopyWithImpl<_GetOutlet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetOutlet &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'OutletEvent.getOutlet(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$GetOutletCopyWith<$Res>
    implements $OutletEventCopyWith<$Res> {
  factory _$GetOutletCopyWith(
          _GetOutlet value, $Res Function(_GetOutlet) _then) =
      __$GetOutletCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$GetOutletCopyWithImpl<$Res> implements _$GetOutletCopyWith<$Res> {
  __$GetOutletCopyWithImpl(this._self, this._then);

  final _GetOutlet _self;
  final $Res Function(_GetOutlet) _then;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_GetOutlet(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _SaveOutlet implements OutletEvent {
  const _SaveOutlet(this.outlet);

  final OutletModel outlet;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveOutletCopyWith<_SaveOutlet> get copyWith =>
      __$SaveOutletCopyWithImpl<_SaveOutlet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveOutlet &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outlet);

  @override
  String toString() {
    return 'OutletEvent.saveOutlet(outlet: $outlet)';
  }
}

/// @nodoc
abstract mixin class _$SaveOutletCopyWith<$Res>
    implements $OutletEventCopyWith<$Res> {
  factory _$SaveOutletCopyWith(
          _SaveOutlet value, $Res Function(_SaveOutlet) _then) =
      __$SaveOutletCopyWithImpl;
  @useResult
  $Res call({OutletModel outlet});
}

/// @nodoc
class __$SaveOutletCopyWithImpl<$Res> implements _$SaveOutletCopyWith<$Res> {
  __$SaveOutletCopyWithImpl(this._self, this._then);

  final _SaveOutlet _self;
  final $Res Function(_SaveOutlet) _then;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? outlet = null,
  }) {
    return _then(_SaveOutlet(
      null == outlet
          ? _self.outlet
          : outlet // ignore: cast_nullable_to_non_nullable
              as OutletModel,
    ));
  }
}

/// @nodoc

class _GetAllOutlets implements OutletEvent {
  const _GetAllOutlets();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetAllOutlets);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OutletEvent.getAllOutlets()';
  }
}

/// @nodoc
mixin _$OutletState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OutletState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OutletState()';
  }
}

/// @nodoc
class $OutletStateCopyWith<$Res> {
  $OutletStateCopyWith(OutletState _, $Res Function(OutletState) __);
}

/// Adds pattern-matching-related methods to [OutletState].
extension OutletStatePatterns on OutletState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadedAll value)? loadedAll,
    TResult Function(_Saved value)? saved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _Loaded() when loaded != null:
        return loaded(_that);
      case _LoadedAll() when loadedAll != null:
        return loadedAll(_that);
      case _Saved() when saved != null:
        return saved(_that);
      case _Error() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _Loading():
        return loading(_that);
      case _Loaded():
        return loaded(_that);
      case _LoadedAll():
        return loadedAll(_that);
      case _Saved():
        return saved(_that);
      case _Error():
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _Loaded() when loaded != null:
        return loaded(_that);
      case _LoadedAll() when loadedAll != null:
        return loadedAll(_that);
      case _Saved() when saved != null:
        return saved(_that);
      case _Error() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OutletModel outlet)? loaded,
    TResult Function(List<OutletModel> outlets)? loadedAll,
    TResult Function(OutletModel outlet)? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.outlet);
      case _LoadedAll() when loadedAll != null:
        return loadedAll(_that.outlets);
      case _Saved() when saved != null:
        return saved(_that.outlet);
      case _Error() when error != null:
        return error(_that.message);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(_that.outlet);
      case _LoadedAll():
        return loadedAll(_that.outlets);
      case _Saved():
        return saved(_that.outlet);
      case _Error():
        return error(_that.message);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.outlet);
      case _LoadedAll() when loadedAll != null:
        return loadedAll(_that.outlets);
      case _Saved() when saved != null:
        return saved(_that.outlet);
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements OutletState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OutletState.initial()';
  }
}

/// @nodoc

class _Loading implements OutletState {
  const _Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OutletState.loading()';
  }
}

/// @nodoc

class _Loaded implements OutletState {
  const _Loaded(this.outlet);

  final OutletModel outlet;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loaded &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outlet);

  @override
  String toString() {
    return 'OutletState.loaded(outlet: $outlet)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $OutletStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({OutletModel outlet});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? outlet = null,
  }) {
    return _then(_Loaded(
      null == outlet
          ? _self.outlet
          : outlet // ignore: cast_nullable_to_non_nullable
              as OutletModel,
    ));
  }
}

/// @nodoc

class _LoadedAll implements OutletState {
  const _LoadedAll(final List<OutletModel> outlets) : _outlets = outlets;

  final List<OutletModel> _outlets;
  List<OutletModel> get outlets {
    if (_outlets is EqualUnmodifiableListView) return _outlets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outlets);
  }

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadedAllCopyWith<_LoadedAll> get copyWith =>
      __$LoadedAllCopyWithImpl<_LoadedAll>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadedAll &&
            const DeepCollectionEquality().equals(other._outlets, _outlets));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_outlets));

  @override
  String toString() {
    return 'OutletState.loadedAll(outlets: $outlets)';
  }
}

/// @nodoc
abstract mixin class _$LoadedAllCopyWith<$Res>
    implements $OutletStateCopyWith<$Res> {
  factory _$LoadedAllCopyWith(
          _LoadedAll value, $Res Function(_LoadedAll) _then) =
      __$LoadedAllCopyWithImpl;
  @useResult
  $Res call({List<OutletModel> outlets});
}

/// @nodoc
class __$LoadedAllCopyWithImpl<$Res> implements _$LoadedAllCopyWith<$Res> {
  __$LoadedAllCopyWithImpl(this._self, this._then);

  final _LoadedAll _self;
  final $Res Function(_LoadedAll) _then;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? outlets = null,
  }) {
    return _then(_LoadedAll(
      null == outlets
          ? _self._outlets
          : outlets // ignore: cast_nullable_to_non_nullable
              as List<OutletModel>,
    ));
  }
}

/// @nodoc

class _Saved implements OutletState {
  const _Saved(this.outlet);

  final OutletModel outlet;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedCopyWith<_Saved> get copyWith =>
      __$SavedCopyWithImpl<_Saved>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Saved &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outlet);

  @override
  String toString() {
    return 'OutletState.saved(outlet: $outlet)';
  }
}

/// @nodoc
abstract mixin class _$SavedCopyWith<$Res>
    implements $OutletStateCopyWith<$Res> {
  factory _$SavedCopyWith(_Saved value, $Res Function(_Saved) _then) =
      __$SavedCopyWithImpl;
  @useResult
  $Res call({OutletModel outlet});
}

/// @nodoc
class __$SavedCopyWithImpl<$Res> implements _$SavedCopyWith<$Res> {
  __$SavedCopyWithImpl(this._self, this._then);

  final _Saved _self;
  final $Res Function(_Saved) _then;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? outlet = null,
  }) {
    return _then(_Saved(
      null == outlet
          ? _self.outlet
          : outlet // ignore: cast_nullable_to_non_nullable
              as OutletModel,
    ));
  }
}

/// @nodoc

class _Error implements OutletState {
  const _Error(this.message);

  final String message;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'OutletState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $OutletStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Error(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
