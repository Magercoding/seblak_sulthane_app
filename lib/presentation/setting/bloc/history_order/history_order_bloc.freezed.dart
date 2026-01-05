// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryOrderEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryOrderEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryOrderEvent()';
  }
}

/// @nodoc
class $HistoryOrderEventCopyWith<$Res> {
  $HistoryOrderEventCopyWith(
      HistoryOrderEvent _, $Res Function(HistoryOrderEvent) __);
}

/// Adds pattern-matching-related methods to [HistoryOrderEvent].
extension HistoryOrderEventPatterns on HistoryOrderEvent {
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
    TResult Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetOrdersByDate() when getOrdersByDate != null:
        return getOrdersByDate(_that);
      case _GetOrderItemsByOrderId() when getOrderItemsByOrderId != null:
        return getOrderItemsByOrderId(_that);
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
    required TResult Function(_GetOrdersByDate value) getOrdersByDate,
    required TResult Function(_GetOrderItemsByOrderId value)
        getOrderItemsByOrderId,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _GetOrdersByDate():
        return getOrdersByDate(_that);
      case _GetOrderItemsByOrderId():
        return getOrderItemsByOrderId(_that);
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
    TResult? Function(_GetOrdersByDate value)? getOrdersByDate,
    TResult? Function(_GetOrderItemsByOrderId value)? getOrderItemsByOrderId,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetOrdersByDate() when getOrdersByDate != null:
        return getOrdersByDate(_that);
      case _GetOrderItemsByOrderId() when getOrderItemsByOrderId != null:
        return getOrderItemsByOrderId(_that);
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
    TResult Function(DateTime date)? getOrdersByDate,
    TResult Function(int orderId)? getOrderItemsByOrderId,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetOrdersByDate() when getOrdersByDate != null:
        return getOrdersByDate(_that.date);
      case _GetOrderItemsByOrderId() when getOrderItemsByOrderId != null:
        return getOrderItemsByOrderId(_that.orderId);
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
    required TResult Function(DateTime date) getOrdersByDate,
    required TResult Function(int orderId) getOrderItemsByOrderId,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _GetOrdersByDate():
        return getOrdersByDate(_that.date);
      case _GetOrderItemsByOrderId():
        return getOrderItemsByOrderId(_that.orderId);
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
    TResult? Function(DateTime date)? getOrdersByDate,
    TResult? Function(int orderId)? getOrderItemsByOrderId,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetOrdersByDate() when getOrdersByDate != null:
        return getOrdersByDate(_that.date);
      case _GetOrderItemsByOrderId() when getOrderItemsByOrderId != null:
        return getOrderItemsByOrderId(_that.orderId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements HistoryOrderEvent {
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
    return 'HistoryOrderEvent.started()';
  }
}

/// @nodoc

class _GetOrdersByDate implements HistoryOrderEvent {
  const _GetOrdersByDate(this.date);

  final DateTime date;

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetOrdersByDateCopyWith<_GetOrdersByDate> get copyWith =>
      __$GetOrdersByDateCopyWithImpl<_GetOrdersByDate>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetOrdersByDate &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  @override
  String toString() {
    return 'HistoryOrderEvent.getOrdersByDate(date: $date)';
  }
}

/// @nodoc
abstract mixin class _$GetOrdersByDateCopyWith<$Res>
    implements $HistoryOrderEventCopyWith<$Res> {
  factory _$GetOrdersByDateCopyWith(
          _GetOrdersByDate value, $Res Function(_GetOrdersByDate) _then) =
      __$GetOrdersByDateCopyWithImpl;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$GetOrdersByDateCopyWithImpl<$Res>
    implements _$GetOrdersByDateCopyWith<$Res> {
  __$GetOrdersByDateCopyWithImpl(this._self, this._then);

  final _GetOrdersByDate _self;
  final $Res Function(_GetOrdersByDate) _then;

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
  }) {
    return _then(_GetOrdersByDate(
      null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _GetOrderItemsByOrderId implements HistoryOrderEvent {
  const _GetOrderItemsByOrderId(this.orderId);

  final int orderId;

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetOrderItemsByOrderIdCopyWith<_GetOrderItemsByOrderId> get copyWith =>
      __$GetOrderItemsByOrderIdCopyWithImpl<_GetOrderItemsByOrderId>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetOrderItemsByOrderId &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @override
  String toString() {
    return 'HistoryOrderEvent.getOrderItemsByOrderId(orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class _$GetOrderItemsByOrderIdCopyWith<$Res>
    implements $HistoryOrderEventCopyWith<$Res> {
  factory _$GetOrderItemsByOrderIdCopyWith(_GetOrderItemsByOrderId value,
          $Res Function(_GetOrderItemsByOrderId) _then) =
      __$GetOrderItemsByOrderIdCopyWithImpl;
  @useResult
  $Res call({int orderId});
}

/// @nodoc
class __$GetOrderItemsByOrderIdCopyWithImpl<$Res>
    implements _$GetOrderItemsByOrderIdCopyWith<$Res> {
  __$GetOrderItemsByOrderIdCopyWithImpl(this._self, this._then);

  final _GetOrderItemsByOrderId _self;
  final $Res Function(_GetOrderItemsByOrderId) _then;

  /// Create a copy of HistoryOrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_GetOrderItemsByOrderId(
      null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$HistoryOrderState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryOrderState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryOrderState()';
  }
}

/// @nodoc
class $HistoryOrderStateCopyWith<$Res> {
  $HistoryOrderStateCopyWith(
      HistoryOrderState _, $Res Function(HistoryOrderState) __);
}

/// Adds pattern-matching-related methods to [HistoryOrderState].
extension HistoryOrderStatePatterns on HistoryOrderState {
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
    TResult Function(_LoadedWithItems value)? loadedWithItems,
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
      case _LoadedWithItems() when loadedWithItems != null:
        return loadedWithItems(_that);
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
    required TResult Function(_LoadedWithItems value) loadedWithItems,
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
      case _LoadedWithItems():
        return loadedWithItems(_that);
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
    TResult? Function(_LoadedWithItems value)? loadedWithItems,
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
      case _LoadedWithItems() when loadedWithItems != null:
        return loadedWithItems(_that);
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
    TResult Function(List<OrderModel> orders)? loaded,
    TResult Function(List<ProductQuantity> orderItems)? loadedWithItems,
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
        return loaded(_that.orders);
      case _LoadedWithItems() when loadedWithItems != null:
        return loadedWithItems(_that.orderItems);
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
    required TResult Function(List<OrderModel> orders) loaded,
    required TResult Function(List<ProductQuantity> orderItems) loadedWithItems,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(_that.orders);
      case _LoadedWithItems():
        return loadedWithItems(_that.orderItems);
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
    TResult? Function(List<OrderModel> orders)? loaded,
    TResult? Function(List<ProductQuantity> orderItems)? loadedWithItems,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.orders);
      case _LoadedWithItems() when loadedWithItems != null:
        return loadedWithItems(_that.orderItems);
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements HistoryOrderState {
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
    return 'HistoryOrderState.initial()';
  }
}

/// @nodoc

class _Loading implements HistoryOrderState {
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
    return 'HistoryOrderState.loading()';
  }
}

/// @nodoc

class _Loaded implements HistoryOrderState {
  const _Loaded(final List<OrderModel> orders) : _orders = orders;

  final List<OrderModel> _orders;
  List<OrderModel> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  /// Create a copy of HistoryOrderState
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
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  @override
  String toString() {
    return 'HistoryOrderState.loaded(orders: $orders)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $HistoryOrderStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({List<OrderModel> orders});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orders = null,
  }) {
    return _then(_Loaded(
      null == orders
          ? _self._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
    ));
  }
}

/// @nodoc

class _LoadedWithItems implements HistoryOrderState {
  const _LoadedWithItems(final List<ProductQuantity> orderItems)
      : _orderItems = orderItems;

  final List<ProductQuantity> _orderItems;
  List<ProductQuantity> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadedWithItemsCopyWith<_LoadedWithItems> get copyWith =>
      __$LoadedWithItemsCopyWithImpl<_LoadedWithItems>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadedWithItems &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_orderItems));

  @override
  String toString() {
    return 'HistoryOrderState.loadedWithItems(orderItems: $orderItems)';
  }
}

/// @nodoc
abstract mixin class _$LoadedWithItemsCopyWith<$Res>
    implements $HistoryOrderStateCopyWith<$Res> {
  factory _$LoadedWithItemsCopyWith(
          _LoadedWithItems value, $Res Function(_LoadedWithItems) _then) =
      __$LoadedWithItemsCopyWithImpl;
  @useResult
  $Res call({List<ProductQuantity> orderItems});
}

/// @nodoc
class __$LoadedWithItemsCopyWithImpl<$Res>
    implements _$LoadedWithItemsCopyWith<$Res> {
  __$LoadedWithItemsCopyWithImpl(this._self, this._then);

  final _LoadedWithItems _self;
  final $Res Function(_LoadedWithItems) _then;

  /// Create a copy of HistoryOrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderItems = null,
  }) {
    return _then(_LoadedWithItems(
      null == orderItems
          ? _self._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<ProductQuantity>,
    ));
  }
}

/// @nodoc

class _Error implements HistoryOrderState {
  const _Error(this.message);

  final String message;

  /// Create a copy of HistoryOrderState
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
    return 'HistoryOrderState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $HistoryOrderStateCopyWith<$Res> {
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

  /// Create a copy of HistoryOrderState
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
