// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HistoryOrderEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(DateTime date) getOrdersByDate,
    required TResult Function(int orderId) getOrderItemsByOrderId,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(DateTime date)? getOrdersByDate,
    TResult? Function(int orderId)? getOrderItemsByOrderId,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(DateTime date)? getOrdersByDate,
    TResult Function(int orderId)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOrdersByDate value) getOrdersByDate,
    required TResult Function(_GetOrderItemsByOrderId value)
        getOrderItemsByOrderId,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult? Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryOrderEventCopyWith<$Res> {
  factory $HistoryOrderEventCopyWith(
          HistoryOrderEvent value, $Res Function(HistoryOrderEvent) then) =
      _$HistoryOrderEventCopyWithImpl<$Res, HistoryOrderEvent>;
}

/// @nodoc
class _$HistoryOrderEventCopyWithImpl<$Res, $Val extends HistoryOrderEvent>
    implements $HistoryOrderEventCopyWith<$Res> {
  _$HistoryOrderEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryOrderEvent
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
    extends _$HistoryOrderEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'HistoryOrderEvent.started()';
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
    required TResult Function(DateTime date) getOrdersByDate,
    required TResult Function(int orderId) getOrderItemsByOrderId,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(DateTime date)? getOrdersByDate,
    TResult? Function(int orderId)? getOrderItemsByOrderId,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(DateTime date)? getOrdersByDate,
    TResult Function(int orderId)? getOrderItemsByOrderId,
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
    required TResult Function(_GetOrdersByDate value) getOrdersByDate,
    required TResult Function(_GetOrderItemsByOrderId value)
        getOrderItemsByOrderId,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult? Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements HistoryOrderEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$GetOrdersByDateImplCopyWith<$Res> {
  factory _$$GetOrdersByDateImplCopyWith(_$GetOrdersByDateImpl value,
          $Res Function(_$GetOrdersByDateImpl) then) =
      __$$GetOrdersByDateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$$GetOrdersByDateImplCopyWithImpl<$Res>
    extends _$HistoryOrderEventCopyWithImpl<$Res, _$GetOrdersByDateImpl>
    implements _$$GetOrdersByDateImplCopyWith<$Res> {
  __$$GetOrdersByDateImplCopyWithImpl(
      _$GetOrdersByDateImpl _value, $Res Function(_$GetOrdersByDateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
  }) {
    return _then(_$GetOrdersByDateImpl(
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$GetOrdersByDateImpl implements _GetOrdersByDate {
  const _$GetOrdersByDateImpl(this.date);

  @override
  final DateTime date;

  @override
  String toString() {
    return 'HistoryOrderEvent.getOrdersByDate(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrdersByDateImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrdersByDateImplCopyWith<_$GetOrdersByDateImpl> get copyWith =>
      __$$GetOrdersByDateImplCopyWithImpl<_$GetOrdersByDateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(DateTime date) getOrdersByDate,
    required TResult Function(int orderId) getOrderItemsByOrderId,
  }) {
    return getOrdersByDate(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(DateTime date)? getOrdersByDate,
    TResult? Function(int orderId)? getOrderItemsByOrderId,
  }) {
    return getOrdersByDate?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(DateTime date)? getOrdersByDate,
    TResult Function(int orderId)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    if (getOrdersByDate != null) {
      return getOrdersByDate(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOrdersByDate value) getOrdersByDate,
    required TResult Function(_GetOrderItemsByOrderId value)
        getOrderItemsByOrderId,
  }) {
    return getOrdersByDate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult? Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
  }) {
    return getOrdersByDate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    if (getOrdersByDate != null) {
      return getOrdersByDate(this);
    }
    return orElse();
  }
}

abstract class _GetOrdersByDate implements HistoryOrderEvent {
  const factory _GetOrdersByDate(final DateTime date) = _$GetOrdersByDateImpl;

  DateTime get date;

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrdersByDateImplCopyWith<_$GetOrdersByDateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetOrderItemsByOrderIdImplCopyWith<$Res> {
  factory _$$GetOrderItemsByOrderIdImplCopyWith(
          _$GetOrderItemsByOrderIdImpl value,
          $Res Function(_$GetOrderItemsByOrderIdImpl) then) =
      __$$GetOrderItemsByOrderIdImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int orderId});
}

/// @nodoc
class __$$GetOrderItemsByOrderIdImplCopyWithImpl<$Res>
    extends _$HistoryOrderEventCopyWithImpl<$Res, _$GetOrderItemsByOrderIdImpl>
    implements _$$GetOrderItemsByOrderIdImplCopyWith<$Res> {
  __$$GetOrderItemsByOrderIdImplCopyWithImpl(
      _$GetOrderItemsByOrderIdImpl _value,
      $Res Function(_$GetOrderItemsByOrderIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_$GetOrderItemsByOrderIdImpl(
      null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GetOrderItemsByOrderIdImpl implements _GetOrderItemsByOrderId {
  const _$GetOrderItemsByOrderIdImpl(this.orderId);

  @override
  final int orderId;

  @override
  String toString() {
    return 'HistoryOrderEvent.getOrderItemsByOrderId(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrderItemsByOrderIdImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrderItemsByOrderIdImplCopyWith<_$GetOrderItemsByOrderIdImpl>
      get copyWith => __$$GetOrderItemsByOrderIdImplCopyWithImpl<
          _$GetOrderItemsByOrderIdImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(DateTime date) getOrdersByDate,
    required TResult Function(int orderId) getOrderItemsByOrderId,
  }) {
    return getOrderItemsByOrderId(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(DateTime date)? getOrdersByDate,
    TResult? Function(int orderId)? getOrderItemsByOrderId,
  }) {
    return getOrderItemsByOrderId?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(DateTime date)? getOrdersByDate,
    TResult Function(int orderId)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    if (getOrderItemsByOrderId != null) {
      return getOrderItemsByOrderId(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetOrdersByDate value) getOrdersByDate,
    required TResult Function(_GetOrderItemsByOrderId value)
        getOrderItemsByOrderId,
  }) {
    return getOrderItemsByOrderId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult? Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
  }) {
    return getOrderItemsByOrderId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    if (getOrderItemsByOrderId != null) {
      return getOrderItemsByOrderId(this);
    }
    return orElse();
  }
}

abstract class _GetOrderItemsByOrderId implements HistoryOrderEvent {
  const factory _GetOrderItemsByOrderId(final int orderId) =
      _$GetOrderItemsByOrderIdImpl;

  int get orderId;

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrderItemsByOrderIdImplCopyWith<_$GetOrderItemsByOrderIdImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HistoryOrderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedWithItems value) loadedWithItems,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadedWithItems value)? loadedWithItems,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryOrderStateCopyWith<$Res> {
  factory $HistoryOrderStateCopyWith(
          HistoryOrderState value, $Res Function(HistoryOrderState) then) =
      _$HistoryOrderStateCopyWithImpl<$Res, HistoryOrderState>;
}

/// @nodoc
class _$HistoryOrderStateCopyWithImpl<$Res, $Val extends HistoryOrderState>
    implements $HistoryOrderStateCopyWith<$Res> {
  _$HistoryOrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryOrderState
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
    extends _$HistoryOrderStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'HistoryOrderState.initial()';
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
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
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
    required TResult Function(_LoadedWithItems value) loadedWithItems,
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
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
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
    TResult Function(_LoadedWithItems value)? loadedWithItems,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements HistoryOrderState {
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
    extends _$HistoryOrderStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'HistoryOrderState.loading()';
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
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
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
    required TResult Function(_LoadedWithItems value) loadedWithItems,
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
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
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
    TResult Function(_LoadedWithItems value)? loadedWithItems,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements HistoryOrderState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderModel> orders});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$HistoryOrderStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$LoadedImpl(
      null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<OrderModel> orders) : _orders = orders;

  final List<OrderModel> _orders;
  @override
  List<OrderModel> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'HistoryOrderState.loaded(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  /// Create a copy of HistoryOrderState
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
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) {
    return loaded(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedWithItems value) loadedWithItems,
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
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
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
    TResult Function(_LoadedWithItems value)? loadedWithItems,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements HistoryOrderState {
  const factory _Loaded(final List<OrderModel> orders) = _$LoadedImpl;

  List<OrderModel> get orders;

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedWithItemsImplCopyWith<$Res> {
  factory _$$LoadedWithItemsImplCopyWith(_$LoadedWithItemsImpl value,
          $Res Function(_$LoadedWithItemsImpl) then) =
      __$$LoadedWithItemsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ProductQuantity> orderItems});
}

/// @nodoc
class __$$LoadedWithItemsImplCopyWithImpl<$Res>
    extends _$HistoryOrderStateCopyWithImpl<$Res, _$LoadedWithItemsImpl>
    implements _$$LoadedWithItemsImplCopyWith<$Res> {
  __$$LoadedWithItemsImplCopyWithImpl(
      _$LoadedWithItemsImpl _value, $Res Function(_$LoadedWithItemsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderItems = null,
  }) {
    return _then(_$LoadedWithItemsImpl(
      null == orderItems
          ? _value._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<ProductQuantity>,
    ));
  }
}

/// @nodoc

class _$LoadedWithItemsImpl implements _LoadedWithItems {
  const _$LoadedWithItemsImpl(final List<ProductQuantity> orderItems)
      : _orderItems = orderItems;

  final List<ProductQuantity> _orderItems;
  @override
  List<ProductQuantity> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  @override
  String toString() {
    return 'HistoryOrderState.loadedWithItems(orderItems: $orderItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedWithItemsImpl &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_orderItems));

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedWithItemsImplCopyWith<_$LoadedWithItemsImpl> get copyWith =>
      __$$LoadedWithItemsImplCopyWithImpl<_$LoadedWithItemsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) {
    return loadedWithItems(orderItems);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) {
    return loadedWithItems?.call(orderItems);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadedWithItems != null) {
      return loadedWithItems(orderItems);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_LoadedWithItems value) loadedWithItems,
    required TResult Function(_Error value) error,
  }) {
    return loadedWithItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
    TResult? Function(_Error value)? error,
  }) {
    return loadedWithItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_LoadedWithItems value)? loadedWithItems,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loadedWithItems != null) {
      return loadedWithItems(this);
    }
    return orElse();
  }
}

abstract class _LoadedWithItems implements HistoryOrderState {
  const factory _LoadedWithItems(final List<ProductQuantity> orderItems) =
      _$LoadedWithItemsImpl;

  List<ProductQuantity> get orderItems;

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedWithItemsImplCopyWith<_$LoadedWithItemsImpl> get copyWith =>
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
    extends _$HistoryOrderStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryOrderState
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
    return 'HistoryOrderState.error(message: $message)';
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

  /// Create a copy of HistoryOrderState
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
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
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
    required TResult Function(_LoadedWithItems value) loadedWithItems,
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
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
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
    TResult Function(_LoadedWithItems value)? loadedWithItems,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements HistoryOrderState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
