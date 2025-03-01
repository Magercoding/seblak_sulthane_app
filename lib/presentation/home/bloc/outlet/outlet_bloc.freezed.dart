// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outlet_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OutletEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int id) getOutlet,
    required TResult Function(OutletModel outlet) saveOutlet,
    required TResult Function() getAllOutlets,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int id)? getOutlet,
    TResult? Function(OutletModel outlet)? saveOutlet,
    TResult? Function()? getAllOutlets,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int id)? getOutlet,
    TResult Function(OutletModel outlet)? saveOutlet,
    TResult Function()? getAllOutlets,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOutlet value) getOutlet,
    required TResult Function(_SaveOutlet value) saveOutlet,
    required TResult Function(_GetAllOutlets value) getAllOutlets,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOutlet value)? getOutlet,
    TResult? Function(_SaveOutlet value)? saveOutlet,
    TResult? Function(_GetAllOutlets value)? getAllOutlets,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOutlet value)? getOutlet,
    TResult Function(_SaveOutlet value)? saveOutlet,
    TResult Function(_GetAllOutlets value)? getAllOutlets,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutletEventCopyWith<$Res> {
  factory $OutletEventCopyWith(
          OutletEvent value, $Res Function(OutletEvent) then) =
      _$OutletEventCopyWithImpl<$Res, OutletEvent>;
}

/// @nodoc
class _$OutletEventCopyWithImpl<$Res, $Val extends OutletEvent>
    implements $OutletEventCopyWith<$Res> {
  _$OutletEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$OutletEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'OutletEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int id) getOutlet,
    required TResult Function(OutletModel outlet) saveOutlet,
    required TResult Function() getAllOutlets,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int id)? getOutlet,
    TResult? Function(OutletModel outlet)? saveOutlet,
    TResult? Function()? getAllOutlets,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int id)? getOutlet,
    TResult Function(OutletModel outlet)? saveOutlet,
    TResult Function()? getAllOutlets,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOutlet value) getOutlet,
    required TResult Function(_SaveOutlet value) saveOutlet,
    required TResult Function(_GetAllOutlets value) getAllOutlets,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOutlet value)? getOutlet,
    TResult? Function(_SaveOutlet value)? saveOutlet,
    TResult? Function(_GetAllOutlets value)? getAllOutlets,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOutlet value)? getOutlet,
    TResult Function(_SaveOutlet value)? saveOutlet,
    TResult Function(_GetAllOutlets value)? getAllOutlets,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements OutletEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$GetOutletImplCopyWith<$Res> {
  factory _$$GetOutletImplCopyWith(
          _$GetOutletImpl value, $Res Function(_$GetOutletImpl) then) =
      __$$GetOutletImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$GetOutletImplCopyWithImpl<$Res>
    extends _$OutletEventCopyWithImpl<$Res, _$GetOutletImpl>
    implements _$$GetOutletImplCopyWith<$Res> {
  __$$GetOutletImplCopyWithImpl(
      _$GetOutletImpl _value, $Res Function(_$GetOutletImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$GetOutletImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GetOutletImpl implements _GetOutlet {
  const _$GetOutletImpl(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'OutletEvent.getOutlet(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOutletImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOutletImplCopyWith<_$GetOutletImpl> get copyWith =>
      __$$GetOutletImplCopyWithImpl<_$GetOutletImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int id) getOutlet,
    required TResult Function(OutletModel outlet) saveOutlet,
    required TResult Function() getAllOutlets,
  }) {
    return getOutlet(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int id)? getOutlet,
    TResult? Function(OutletModel outlet)? saveOutlet,
    TResult? Function()? getAllOutlets,
  }) {
    return getOutlet?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int id)? getOutlet,
    TResult Function(OutletModel outlet)? saveOutlet,
    TResult Function()? getAllOutlets,
    required TResult orElse(),
  }) {
    if (getOutlet != null) {
      return getOutlet(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOutlet value) getOutlet,
    required TResult Function(_SaveOutlet value) saveOutlet,
    required TResult Function(_GetAllOutlets value) getAllOutlets,
  }) {
    return getOutlet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOutlet value)? getOutlet,
    TResult? Function(_SaveOutlet value)? saveOutlet,
    TResult? Function(_GetAllOutlets value)? getAllOutlets,
  }) {
    return getOutlet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOutlet value)? getOutlet,
    TResult Function(_SaveOutlet value)? saveOutlet,
    TResult Function(_GetAllOutlets value)? getAllOutlets,
    required TResult orElse(),
  }) {
    if (getOutlet != null) {
      return getOutlet(this);
    }
    return orElse();
  }
}

abstract class _GetOutlet implements OutletEvent {
  const factory _GetOutlet(final int id) = _$GetOutletImpl;

  int get id;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOutletImplCopyWith<_$GetOutletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveOutletImplCopyWith<$Res> {
  factory _$$SaveOutletImplCopyWith(
          _$SaveOutletImpl value, $Res Function(_$SaveOutletImpl) then) =
      __$$SaveOutletImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutletModel outlet});
}

/// @nodoc
class __$$SaveOutletImplCopyWithImpl<$Res>
    extends _$OutletEventCopyWithImpl<$Res, _$SaveOutletImpl>
    implements _$$SaveOutletImplCopyWith<$Res> {
  __$$SaveOutletImplCopyWithImpl(
      _$SaveOutletImpl _value, $Res Function(_$SaveOutletImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outlet = null,
  }) {
    return _then(_$SaveOutletImpl(
      null == outlet
          ? _value.outlet
          : outlet // ignore: cast_nullable_to_non_nullable
              as OutletModel,
    ));
  }
}

/// @nodoc

class _$SaveOutletImpl implements _SaveOutlet {
  const _$SaveOutletImpl(this.outlet);

  @override
  final OutletModel outlet;

  @override
  String toString() {
    return 'OutletEvent.saveOutlet(outlet: $outlet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveOutletImpl &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outlet);

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveOutletImplCopyWith<_$SaveOutletImpl> get copyWith =>
      __$$SaveOutletImplCopyWithImpl<_$SaveOutletImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int id) getOutlet,
    required TResult Function(OutletModel outlet) saveOutlet,
    required TResult Function() getAllOutlets,
  }) {
    return saveOutlet(outlet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int id)? getOutlet,
    TResult? Function(OutletModel outlet)? saveOutlet,
    TResult? Function()? getAllOutlets,
  }) {
    return saveOutlet?.call(outlet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int id)? getOutlet,
    TResult Function(OutletModel outlet)? saveOutlet,
    TResult Function()? getAllOutlets,
    required TResult orElse(),
  }) {
    if (saveOutlet != null) {
      return saveOutlet(outlet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOutlet value) getOutlet,
    required TResult Function(_SaveOutlet value) saveOutlet,
    required TResult Function(_GetAllOutlets value) getAllOutlets,
  }) {
    return saveOutlet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOutlet value)? getOutlet,
    TResult? Function(_SaveOutlet value)? saveOutlet,
    TResult? Function(_GetAllOutlets value)? getAllOutlets,
  }) {
    return saveOutlet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOutlet value)? getOutlet,
    TResult Function(_SaveOutlet value)? saveOutlet,
    TResult Function(_GetAllOutlets value)? getAllOutlets,
    required TResult orElse(),
  }) {
    if (saveOutlet != null) {
      return saveOutlet(this);
    }
    return orElse();
  }
}

abstract class _SaveOutlet implements OutletEvent {
  const factory _SaveOutlet(final OutletModel outlet) = _$SaveOutletImpl;

  OutletModel get outlet;

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveOutletImplCopyWith<_$SaveOutletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetAllOutletsImplCopyWith<$Res> {
  factory _$$GetAllOutletsImplCopyWith(
          _$GetAllOutletsImpl value, $Res Function(_$GetAllOutletsImpl) then) =
      __$$GetAllOutletsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetAllOutletsImplCopyWithImpl<$Res>
    extends _$OutletEventCopyWithImpl<$Res, _$GetAllOutletsImpl>
    implements _$$GetAllOutletsImplCopyWith<$Res> {
  __$$GetAllOutletsImplCopyWithImpl(
      _$GetAllOutletsImpl _value, $Res Function(_$GetAllOutletsImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetAllOutletsImpl implements _GetAllOutlets {
  const _$GetAllOutletsImpl();

  @override
  String toString() {
    return 'OutletEvent.getAllOutlets()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetAllOutletsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(int id) getOutlet,
    required TResult Function(OutletModel outlet) saveOutlet,
    required TResult Function() getAllOutlets,
  }) {
    return getAllOutlets();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(int id)? getOutlet,
    TResult? Function(OutletModel outlet)? saveOutlet,
    TResult? Function()? getAllOutlets,
  }) {
    return getAllOutlets?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(int id)? getOutlet,
    TResult Function(OutletModel outlet)? saveOutlet,
    TResult Function()? getAllOutlets,
    required TResult orElse(),
  }) {
    if (getAllOutlets != null) {
      return getAllOutlets();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOutlet value) getOutlet,
    required TResult Function(_SaveOutlet value) saveOutlet,
    required TResult Function(_GetAllOutlets value) getAllOutlets,
  }) {
    return getAllOutlets(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOutlet value)? getOutlet,
    TResult? Function(_SaveOutlet value)? saveOutlet,
    TResult? Function(_GetAllOutlets value)? getAllOutlets,
  }) {
    return getAllOutlets?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOutlet value)? getOutlet,
    TResult Function(_SaveOutlet value)? saveOutlet,
    TResult Function(_GetAllOutlets value)? getAllOutlets,
    required TResult orElse(),
  }) {
    if (getAllOutlets != null) {
      return getAllOutlets(this);
    }
    return orElse();
  }
}

abstract class _GetAllOutlets implements OutletEvent {
  const factory _GetAllOutlets() = _$GetAllOutletsImpl;
}

/// @nodoc
mixin _$OutletState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OutletModel outlet)? loaded,
    TResult Function(List<OutletModel> outlets)? loadedAll,
    TResult Function(OutletModel outlet)? saved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadedAll value)? loadedAll,
    TResult Function(_Saved value)? saved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutletStateCopyWith<$Res> {
  factory $OutletStateCopyWith(
          OutletState value, $Res Function(OutletState) then) =
      _$OutletStateCopyWithImpl<$Res, OutletState>;
}

/// @nodoc
class _$OutletStateCopyWithImpl<$Res, $Val extends OutletState>
    implements $OutletStateCopyWith<$Res> {
  _$OutletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OutletStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'OutletState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
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
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
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
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OutletState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$OutletStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'OutletState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
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
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
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
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements OutletState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutletModel outlet});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$OutletStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outlet = null,
  }) {
    return _then(_$LoadedImpl(
      null == outlet
          ? _value.outlet
          : outlet // ignore: cast_nullable_to_non_nullable
              as OutletModel,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.outlet);

  @override
  final OutletModel outlet;

  @override
  String toString() {
    return 'OutletState.loaded(outlet: $outlet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outlet);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    return loaded(outlet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(outlet);
  }

  @override
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
    if (loaded != null) {
      return loaded(outlet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
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
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements OutletState {
  const factory _Loaded(final OutletModel outlet) = _$LoadedImpl;

  OutletModel get outlet;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedAllImplCopyWith<$Res> {
  factory _$$LoadedAllImplCopyWith(
          _$LoadedAllImpl value, $Res Function(_$LoadedAllImpl) then) =
      __$$LoadedAllImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OutletModel> outlets});
}

/// @nodoc
class __$$LoadedAllImplCopyWithImpl<$Res>
    extends _$OutletStateCopyWithImpl<$Res, _$LoadedAllImpl>
    implements _$$LoadedAllImplCopyWith<$Res> {
  __$$LoadedAllImplCopyWithImpl(
      _$LoadedAllImpl _value, $Res Function(_$LoadedAllImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outlets = null,
  }) {
    return _then(_$LoadedAllImpl(
      null == outlets
          ? _value._outlets
          : outlets // ignore: cast_nullable_to_non_nullable
              as List<OutletModel>,
    ));
  }
}

/// @nodoc

class _$LoadedAllImpl implements _LoadedAll {
  const _$LoadedAllImpl(final List<OutletModel> outlets) : _outlets = outlets;

  final List<OutletModel> _outlets;
  @override
  List<OutletModel> get outlets {
    if (_outlets is EqualUnmodifiableListView) return _outlets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outlets);
  }

  @override
  String toString() {
    return 'OutletState.loadedAll(outlets: $outlets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedAllImpl &&
            const DeepCollectionEquality().equals(other._outlets, _outlets));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_outlets));

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedAllImplCopyWith<_$LoadedAllImpl> get copyWith =>
      __$$LoadedAllImplCopyWithImpl<_$LoadedAllImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    return loadedAll(outlets);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    return loadedAll?.call(outlets);
  }

  @override
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
    if (loadedAll != null) {
      return loadedAll(outlets);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    return loadedAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    return loadedAll?.call(this);
  }

  @override
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
    if (loadedAll != null) {
      return loadedAll(this);
    }
    return orElse();
  }
}

abstract class _LoadedAll implements OutletState {
  const factory _LoadedAll(final List<OutletModel> outlets) = _$LoadedAllImpl;

  List<OutletModel> get outlets;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedAllImplCopyWith<_$LoadedAllImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SavedImplCopyWith<$Res> {
  factory _$$SavedImplCopyWith(
          _$SavedImpl value, $Res Function(_$SavedImpl) then) =
      __$$SavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutletModel outlet});
}

/// @nodoc
class __$$SavedImplCopyWithImpl<$Res>
    extends _$OutletStateCopyWithImpl<$Res, _$SavedImpl>
    implements _$$SavedImplCopyWith<$Res> {
  __$$SavedImplCopyWithImpl(
      _$SavedImpl _value, $Res Function(_$SavedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outlet = null,
  }) {
    return _then(_$SavedImpl(
      null == outlet
          ? _value.outlet
          : outlet // ignore: cast_nullable_to_non_nullable
              as OutletModel,
    ));
  }
}

/// @nodoc

class _$SavedImpl implements _Saved {
  const _$SavedImpl(this.outlet);

  @override
  final OutletModel outlet;

  @override
  String toString() {
    return 'OutletState.saved(outlet: $outlet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedImpl &&
            (identical(other.outlet, outlet) || other.outlet == outlet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outlet);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedImplCopyWith<_$SavedImpl> get copyWith =>
      __$$SavedImplCopyWithImpl<_$SavedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    return saved(outlet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    return saved?.call(outlet);
  }

  @override
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
    if (saved != null) {
      return saved(outlet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    return saved?.call(this);
  }

  @override
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
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class _Saved implements OutletState {
  const factory _Saved(final OutletModel outlet) = _$SavedImpl;

  OutletModel get outlet;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedImplCopyWith<_$SavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$OutletStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'OutletState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OutletModel outlet) loaded,
    required TResult Function(List<OutletModel> outlets) loadedAll,
    required TResult Function(OutletModel outlet) saved,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OutletModel outlet)? loaded,
    TResult? Function(List<OutletModel> outlets)? loadedAll,
    TResult? Function(OutletModel outlet)? saved,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
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
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedAll value) loadedAll,
    required TResult Function(_Saved value) saved,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedAll value)? loadedAll,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
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
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements OutletState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of OutletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
