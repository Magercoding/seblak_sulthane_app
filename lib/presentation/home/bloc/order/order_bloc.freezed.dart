// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OrderEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OrderEvent()';
  }
}

/// @nodoc
class $OrderEventCopyWith<$Res> {
  $OrderEventCopyWith(OrderEvent _, $Res Function(OrderEvent) __);
}

/// Adds pattern-matching-related methods to [OrderEvent].
extension OrderEventPatterns on OrderEvent {
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
    TResult Function(_Order value)? order,
    TResult Function(_LoadHistoricalOrder value)? loadHistoricalOrder,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _Order() when order != null:
        return order(_that);
      case _LoadHistoricalOrder() when loadHistoricalOrder != null:
        return loadHistoricalOrder(_that);
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
    required TResult Function(_Order value) order,
    required TResult Function(_LoadHistoricalOrder value) loadHistoricalOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _Order():
        return order(_that);
      case _LoadHistoricalOrder():
        return loadHistoricalOrder(_that);
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
    TResult? Function(_Order value)? order,
    TResult? Function(_LoadHistoricalOrder value)? loadHistoricalOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _Order() when order != null:
        return order(_that);
      case _LoadHistoricalOrder() when loadHistoricalOrder != null:
        return loadHistoricalOrder(_that);
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
    TResult Function(
            List<ProductQuantity> items,
            int discount,
            int discountAmount,
            int tax,
            int serviceCharge,
            int paymentAmount,
            String customerName,
            int tableNumber,
            String status,
            String paymentStatus,
            String paymentMethod,
            int totalPriceFinal,
            String orderType,
            String notes)?
        order,
    TResult Function(OrderModel order)? loadHistoricalOrder,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _Order() when order != null:
        return order(
            _that.items,
            _that.discount,
            _that.discountAmount,
            _that.tax,
            _that.serviceCharge,
            _that.paymentAmount,
            _that.customerName,
            _that.tableNumber,
            _that.status,
            _that.paymentStatus,
            _that.paymentMethod,
            _that.totalPriceFinal,
            _that.orderType,
            _that.notes);
      case _LoadHistoricalOrder() when loadHistoricalOrder != null:
        return loadHistoricalOrder(_that.order);
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
    required TResult Function(
            List<ProductQuantity> items,
            int discount,
            int discountAmount,
            int tax,
            int serviceCharge,
            int paymentAmount,
            String customerName,
            int tableNumber,
            String status,
            String paymentStatus,
            String paymentMethod,
            int totalPriceFinal,
            String orderType,
            String notes)
        order,
    required TResult Function(OrderModel order) loadHistoricalOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _Order():
        return order(
            _that.items,
            _that.discount,
            _that.discountAmount,
            _that.tax,
            _that.serviceCharge,
            _that.paymentAmount,
            _that.customerName,
            _that.tableNumber,
            _that.status,
            _that.paymentStatus,
            _that.paymentMethod,
            _that.totalPriceFinal,
            _that.orderType,
            _that.notes);
      case _LoadHistoricalOrder():
        return loadHistoricalOrder(_that.order);
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
    TResult? Function(
            List<ProductQuantity> items,
            int discount,
            int discountAmount,
            int tax,
            int serviceCharge,
            int paymentAmount,
            String customerName,
            int tableNumber,
            String status,
            String paymentStatus,
            String paymentMethod,
            int totalPriceFinal,
            String orderType,
            String notes)?
        order,
    TResult? Function(OrderModel order)? loadHistoricalOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _Order() when order != null:
        return order(
            _that.items,
            _that.discount,
            _that.discountAmount,
            _that.tax,
            _that.serviceCharge,
            _that.paymentAmount,
            _that.customerName,
            _that.tableNumber,
            _that.status,
            _that.paymentStatus,
            _that.paymentMethod,
            _that.totalPriceFinal,
            _that.orderType,
            _that.notes);
      case _LoadHistoricalOrder() when loadHistoricalOrder != null:
        return loadHistoricalOrder(_that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements OrderEvent {
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
    return 'OrderEvent.started()';
  }
}

/// @nodoc

class _Order implements OrderEvent {
  const _Order(
      final List<ProductQuantity> items,
      this.discount,
      this.discountAmount,
      this.tax,
      this.serviceCharge,
      this.paymentAmount,
      this.customerName,
      this.tableNumber,
      this.status,
      this.paymentStatus,
      this.paymentMethod,
      this.totalPriceFinal,
      {this.orderType = 'dine_in',
      this.notes = ''})
      : _items = items;

  final List<ProductQuantity> _items;
  List<ProductQuantity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final int discount;
  final int discountAmount;
  final int tax;
  final int serviceCharge;
  final int paymentAmount;
  final String customerName;
  final int tableNumber;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final int totalPriceFinal;
  @JsonKey()
  final String orderType;
// Use named parameter with default value
  @JsonKey()
  final String notes;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Order &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.serviceCharge, serviceCharge) ||
                other.serviceCharge == serviceCharge) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.tableNumber, tableNumber) ||
                other.tableNumber == tableNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.totalPriceFinal, totalPriceFinal) ||
                other.totalPriceFinal == totalPriceFinal) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      discount,
      discountAmount,
      tax,
      serviceCharge,
      paymentAmount,
      customerName,
      tableNumber,
      status,
      paymentStatus,
      paymentMethod,
      totalPriceFinal,
      orderType,
      notes);

  @override
  String toString() {
    return 'OrderEvent.order(items: $items, discount: $discount, discountAmount: $discountAmount, tax: $tax, serviceCharge: $serviceCharge, paymentAmount: $paymentAmount, customerName: $customerName, tableNumber: $tableNumber, status: $status, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, totalPriceFinal: $totalPriceFinal, orderType: $orderType, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res>
    implements $OrderEventCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) =
      __$OrderCopyWithImpl;
  @useResult
  $Res call(
      {List<ProductQuantity> items,
      int discount,
      int discountAmount,
      int tax,
      int serviceCharge,
      int paymentAmount,
      String customerName,
      int tableNumber,
      String status,
      String paymentStatus,
      String paymentMethod,
      int totalPriceFinal,
      String orderType,
      String notes});
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? discount = null,
    Object? discountAmount = null,
    Object? tax = null,
    Object? serviceCharge = null,
    Object? paymentAmount = null,
    Object? customerName = null,
    Object? tableNumber = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? paymentMethod = null,
    Object? totalPriceFinal = null,
    Object? orderType = null,
    Object? notes = null,
  }) {
    return _then(_Order(
      null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ProductQuantity>,
      null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      null == discountAmount
          ? _self.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int,
      null == tax
          ? _self.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as int,
      null == serviceCharge
          ? _self.serviceCharge
          : serviceCharge // ignore: cast_nullable_to_non_nullable
              as int,
      null == paymentAmount
          ? _self.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as int,
      null == customerName
          ? _self.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      null == tableNumber
          ? _self.tableNumber
          : tableNumber // ignore: cast_nullable_to_non_nullable
              as int,
      null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      null == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      null == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      null == totalPriceFinal
          ? _self.totalPriceFinal
          : totalPriceFinal // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _self.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _LoadHistoricalOrder implements OrderEvent {
  const _LoadHistoricalOrder(this.order);

  final OrderModel order;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadHistoricalOrderCopyWith<_LoadHistoricalOrder> get copyWith =>
      __$LoadHistoricalOrderCopyWithImpl<_LoadHistoricalOrder>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadHistoricalOrder &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order);

  @override
  String toString() {
    return 'OrderEvent.loadHistoricalOrder(order: $order)';
  }
}

/// @nodoc
abstract mixin class _$LoadHistoricalOrderCopyWith<$Res>
    implements $OrderEventCopyWith<$Res> {
  factory _$LoadHistoricalOrderCopyWith(_LoadHistoricalOrder value,
          $Res Function(_LoadHistoricalOrder) _then) =
      __$LoadHistoricalOrderCopyWithImpl;
  @useResult
  $Res call({OrderModel order});
}

/// @nodoc
class __$LoadHistoricalOrderCopyWithImpl<$Res>
    implements _$LoadHistoricalOrderCopyWith<$Res> {
  __$LoadHistoricalOrderCopyWithImpl(this._self, this._then);

  final _LoadHistoricalOrder _self;
  final $Res Function(_LoadHistoricalOrder) _then;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? order = null,
  }) {
    return _then(_LoadHistoricalOrder(
      null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
    ));
  }
}

/// @nodoc
mixin _$OrderState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OrderState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OrderState()';
  }
}

/// @nodoc
class $OrderStateCopyWith<$Res> {
  $OrderStateCopyWith(OrderState _, $Res Function(OrderState) __);
}

/// Adds pattern-matching-related methods to [OrderState].
extension OrderStatePatterns on OrderState {
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
    TResult Function(OrderModel orderModel, int orderId)? loaded,
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
        return loaded(_that.orderModel, _that.orderId);
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
    required TResult Function(OrderModel orderModel, int orderId) loaded,
    required TResult Function(String message) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(_that.orderModel, _that.orderId);
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
    TResult? Function(OrderModel orderModel, int orderId)? loaded,
    TResult? Function(String message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.orderModel, _that.orderId);
      case _Error() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements OrderState {
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
    return 'OrderState.initial()';
  }
}

/// @nodoc

class _Loading implements OrderState {
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
    return 'OrderState.loading()';
  }
}

/// @nodoc

class _Loaded implements OrderState {
  const _Loaded(this.orderModel, this.orderId);

  final OrderModel orderModel;
  final int orderId;

  /// Create a copy of OrderState
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
            (identical(other.orderModel, orderModel) ||
                other.orderModel == orderModel) &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderModel, orderId);

  @override
  String toString() {
    return 'OrderState.loaded(orderModel: $orderModel, orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({OrderModel orderModel, int orderId});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderModel = null,
    Object? orderId = null,
  }) {
    return _then(_Loaded(
      null == orderModel
          ? _self.orderModel
          : orderModel // ignore: cast_nullable_to_non_nullable
              as OrderModel,
      null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Error implements OrderState {
  const _Error(this.message);

  final String message;

  /// Create a copy of OrderState
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
    return 'OrderState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
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

  /// Create a copy of OrderState
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
