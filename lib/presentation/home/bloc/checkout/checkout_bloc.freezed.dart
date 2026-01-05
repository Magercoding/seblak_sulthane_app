// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckoutEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CheckoutEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CheckoutEvent()';
  }
}

/// @nodoc
class $CheckoutEventCopyWith<$Res> {
  $CheckoutEventCopyWith(CheckoutEvent _, $Res Function(CheckoutEvent) __);
}

/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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
    TResult Function(_AddItem value)? addItem,
    TResult Function(_RemoveItem value)? removeItem,
    TResult Function(_AddDiscount value)? addDiscount,
    TResult Function(_RemoveDiscount value)? removeDiscount,
    TResult Function(_AddTax value)? addTax,
    TResult Function(_AddServiceCharge value)? addServiceCharge,
    TResult Function(_RemoveTax value)? removeTax,
    TResult Function(_RemoveServiceCharge value)? removeServiceCharge,
    TResult Function(_SaveDraftOrder value)? saveDraftOrder,
    TResult Function(_LoadDraftOrder value)? loadDraftOrder,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _AddItem() when addItem != null:
        return addItem(_that);
      case _RemoveItem() when removeItem != null:
        return removeItem(_that);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(_that);
      case _RemoveDiscount() when removeDiscount != null:
        return removeDiscount(_that);
      case _AddTax() when addTax != null:
        return addTax(_that);
      case _AddServiceCharge() when addServiceCharge != null:
        return addServiceCharge(_that);
      case _RemoveTax() when removeTax != null:
        return removeTax(_that);
      case _RemoveServiceCharge() when removeServiceCharge != null:
        return removeServiceCharge(_that);
      case _SaveDraftOrder() when saveDraftOrder != null:
        return saveDraftOrder(_that);
      case _LoadDraftOrder() when loadDraftOrder != null:
        return loadDraftOrder(_that);
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
    required TResult Function(_AddItem value) addItem,
    required TResult Function(_RemoveItem value) removeItem,
    required TResult Function(_AddDiscount value) addDiscount,
    required TResult Function(_RemoveDiscount value) removeDiscount,
    required TResult Function(_AddTax value) addTax,
    required TResult Function(_AddServiceCharge value) addServiceCharge,
    required TResult Function(_RemoveTax value) removeTax,
    required TResult Function(_RemoveServiceCharge value) removeServiceCharge,
    required TResult Function(_SaveDraftOrder value) saveDraftOrder,
    required TResult Function(_LoadDraftOrder value) loadDraftOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _AddItem():
        return addItem(_that);
      case _RemoveItem():
        return removeItem(_that);
      case _AddDiscount():
        return addDiscount(_that);
      case _RemoveDiscount():
        return removeDiscount(_that);
      case _AddTax():
        return addTax(_that);
      case _AddServiceCharge():
        return addServiceCharge(_that);
      case _RemoveTax():
        return removeTax(_that);
      case _RemoveServiceCharge():
        return removeServiceCharge(_that);
      case _SaveDraftOrder():
        return saveDraftOrder(_that);
      case _LoadDraftOrder():
        return loadDraftOrder(_that);
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
    TResult? Function(_AddItem value)? addItem,
    TResult? Function(_RemoveItem value)? removeItem,
    TResult? Function(_AddDiscount value)? addDiscount,
    TResult? Function(_RemoveDiscount value)? removeDiscount,
    TResult? Function(_AddTax value)? addTax,
    TResult? Function(_AddServiceCharge value)? addServiceCharge,
    TResult? Function(_RemoveTax value)? removeTax,
    TResult? Function(_RemoveServiceCharge value)? removeServiceCharge,
    TResult? Function(_SaveDraftOrder value)? saveDraftOrder,
    TResult? Function(_LoadDraftOrder value)? loadDraftOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _AddItem() when addItem != null:
        return addItem(_that);
      case _RemoveItem() when removeItem != null:
        return removeItem(_that);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(_that);
      case _RemoveDiscount() when removeDiscount != null:
        return removeDiscount(_that);
      case _AddTax() when addTax != null:
        return addTax(_that);
      case _AddServiceCharge() when addServiceCharge != null:
        return addServiceCharge(_that);
      case _RemoveTax() when removeTax != null:
        return removeTax(_that);
      case _RemoveServiceCharge() when removeServiceCharge != null:
        return removeServiceCharge(_that);
      case _SaveDraftOrder() when saveDraftOrder != null:
        return saveDraftOrder(_that);
      case _LoadDraftOrder() when loadDraftOrder != null:
        return loadDraftOrder(_that);
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
    TResult Function(Product product)? addItem,
    TResult Function(Product product)? removeItem,
    TResult Function(Discount discount)? addDiscount,
    TResult Function(String category)? removeDiscount,
    TResult Function(int tax)? addTax,
    TResult Function(int serviceCharge)? addServiceCharge,
    TResult Function()? removeTax,
    TResult Function()? removeServiceCharge,
    TResult Function(int tableNumber, String draftName, int discountAmount)?
        saveDraftOrder,
    TResult Function(DraftOrderModel data)? loadDraftOrder,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _AddItem() when addItem != null:
        return addItem(_that.product);
      case _RemoveItem() when removeItem != null:
        return removeItem(_that.product);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(_that.discount);
      case _RemoveDiscount() when removeDiscount != null:
        return removeDiscount(_that.category);
      case _AddTax() when addTax != null:
        return addTax(_that.tax);
      case _AddServiceCharge() when addServiceCharge != null:
        return addServiceCharge(_that.serviceCharge);
      case _RemoveTax() when removeTax != null:
        return removeTax();
      case _RemoveServiceCharge() when removeServiceCharge != null:
        return removeServiceCharge();
      case _SaveDraftOrder() when saveDraftOrder != null:
        return saveDraftOrder(
            _that.tableNumber, _that.draftName, _that.discountAmount);
      case _LoadDraftOrder() when loadDraftOrder != null:
        return loadDraftOrder(_that.data);
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
    required TResult Function(Product product) addItem,
    required TResult Function(Product product) removeItem,
    required TResult Function(Discount discount) addDiscount,
    required TResult Function(String category) removeDiscount,
    required TResult Function(int tax) addTax,
    required TResult Function(int serviceCharge) addServiceCharge,
    required TResult Function() removeTax,
    required TResult Function() removeServiceCharge,
    required TResult Function(
            int tableNumber, String draftName, int discountAmount)
        saveDraftOrder,
    required TResult Function(DraftOrderModel data) loadDraftOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _AddItem():
        return addItem(_that.product);
      case _RemoveItem():
        return removeItem(_that.product);
      case _AddDiscount():
        return addDiscount(_that.discount);
      case _RemoveDiscount():
        return removeDiscount(_that.category);
      case _AddTax():
        return addTax(_that.tax);
      case _AddServiceCharge():
        return addServiceCharge(_that.serviceCharge);
      case _RemoveTax():
        return removeTax();
      case _RemoveServiceCharge():
        return removeServiceCharge();
      case _SaveDraftOrder():
        return saveDraftOrder(
            _that.tableNumber, _that.draftName, _that.discountAmount);
      case _LoadDraftOrder():
        return loadDraftOrder(_that.data);
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
    TResult? Function(Product product)? addItem,
    TResult? Function(Product product)? removeItem,
    TResult? Function(Discount discount)? addDiscount,
    TResult? Function(String category)? removeDiscount,
    TResult? Function(int tax)? addTax,
    TResult? Function(int serviceCharge)? addServiceCharge,
    TResult? Function()? removeTax,
    TResult? Function()? removeServiceCharge,
    TResult? Function(int tableNumber, String draftName, int discountAmount)?
        saveDraftOrder,
    TResult? Function(DraftOrderModel data)? loadDraftOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _AddItem() when addItem != null:
        return addItem(_that.product);
      case _RemoveItem() when removeItem != null:
        return removeItem(_that.product);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(_that.discount);
      case _RemoveDiscount() when removeDiscount != null:
        return removeDiscount(_that.category);
      case _AddTax() when addTax != null:
        return addTax(_that.tax);
      case _AddServiceCharge() when addServiceCharge != null:
        return addServiceCharge(_that.serviceCharge);
      case _RemoveTax() when removeTax != null:
        return removeTax();
      case _RemoveServiceCharge() when removeServiceCharge != null:
        return removeServiceCharge();
      case _SaveDraftOrder() when saveDraftOrder != null:
        return saveDraftOrder(
            _that.tableNumber, _that.draftName, _that.discountAmount);
      case _LoadDraftOrder() when loadDraftOrder != null:
        return loadDraftOrder(_that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements CheckoutEvent {
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
    return 'CheckoutEvent.started()';
  }
}

/// @nodoc

class _AddItem implements CheckoutEvent {
  const _AddItem(this.product);

  final Product product;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddItemCopyWith<_AddItem> get copyWith =>
      __$AddItemCopyWithImpl<_AddItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddItem &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  @override
  String toString() {
    return 'CheckoutEvent.addItem(product: $product)';
  }
}

/// @nodoc
abstract mixin class _$AddItemCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$AddItemCopyWith(_AddItem value, $Res Function(_AddItem) _then) =
      __$AddItemCopyWithImpl;
  @useResult
  $Res call({Product product});
}

/// @nodoc
class __$AddItemCopyWithImpl<$Res> implements _$AddItemCopyWith<$Res> {
  __$AddItemCopyWithImpl(this._self, this._then);

  final _AddItem _self;
  final $Res Function(_AddItem) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? product = null,
  }) {
    return _then(_AddItem(
      null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc

class _RemoveItem implements CheckoutEvent {
  const _RemoveItem(this.product);

  final Product product;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoveItemCopyWith<_RemoveItem> get copyWith =>
      __$RemoveItemCopyWithImpl<_RemoveItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveItem &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  @override
  String toString() {
    return 'CheckoutEvent.removeItem(product: $product)';
  }
}

/// @nodoc
abstract mixin class _$RemoveItemCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$RemoveItemCopyWith(
          _RemoveItem value, $Res Function(_RemoveItem) _then) =
      __$RemoveItemCopyWithImpl;
  @useResult
  $Res call({Product product});
}

/// @nodoc
class __$RemoveItemCopyWithImpl<$Res> implements _$RemoveItemCopyWith<$Res> {
  __$RemoveItemCopyWithImpl(this._self, this._then);

  final _RemoveItem _self;
  final $Res Function(_RemoveItem) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? product = null,
  }) {
    return _then(_RemoveItem(
      null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc

class _AddDiscount implements CheckoutEvent {
  const _AddDiscount(this.discount);

  final Discount discount;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddDiscountCopyWith<_AddDiscount> get copyWith =>
      __$AddDiscountCopyWithImpl<_AddDiscount>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddDiscount &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, discount);

  @override
  String toString() {
    return 'CheckoutEvent.addDiscount(discount: $discount)';
  }
}

/// @nodoc
abstract mixin class _$AddDiscountCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$AddDiscountCopyWith(
          _AddDiscount value, $Res Function(_AddDiscount) _then) =
      __$AddDiscountCopyWithImpl;
  @useResult
  $Res call({Discount discount});
}

/// @nodoc
class __$AddDiscountCopyWithImpl<$Res> implements _$AddDiscountCopyWith<$Res> {
  __$AddDiscountCopyWithImpl(this._self, this._then);

  final _AddDiscount _self;
  final $Res Function(_AddDiscount) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? discount = null,
  }) {
    return _then(_AddDiscount(
      null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as Discount,
    ));
  }
}

/// @nodoc

class _RemoveDiscount implements CheckoutEvent {
  const _RemoveDiscount(this.category);

  final String category;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoveDiscountCopyWith<_RemoveDiscount> get copyWith =>
      __$RemoveDiscountCopyWithImpl<_RemoveDiscount>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveDiscount &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  @override
  String toString() {
    return 'CheckoutEvent.removeDiscount(category: $category)';
  }
}

/// @nodoc
abstract mixin class _$RemoveDiscountCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$RemoveDiscountCopyWith(
          _RemoveDiscount value, $Res Function(_RemoveDiscount) _then) =
      __$RemoveDiscountCopyWithImpl;
  @useResult
  $Res call({String category});
}

/// @nodoc
class __$RemoveDiscountCopyWithImpl<$Res>
    implements _$RemoveDiscountCopyWith<$Res> {
  __$RemoveDiscountCopyWithImpl(this._self, this._then);

  final _RemoveDiscount _self;
  final $Res Function(_RemoveDiscount) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
  }) {
    return _then(_RemoveDiscount(
      null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _AddTax implements CheckoutEvent {
  const _AddTax(this.tax);

  final int tax;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddTaxCopyWith<_AddTax> get copyWith =>
      __$AddTaxCopyWithImpl<_AddTax>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddTax &&
            (identical(other.tax, tax) || other.tax == tax));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tax);

  @override
  String toString() {
    return 'CheckoutEvent.addTax(tax: $tax)';
  }
}

/// @nodoc
abstract mixin class _$AddTaxCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$AddTaxCopyWith(_AddTax value, $Res Function(_AddTax) _then) =
      __$AddTaxCopyWithImpl;
  @useResult
  $Res call({int tax});
}

/// @nodoc
class __$AddTaxCopyWithImpl<$Res> implements _$AddTaxCopyWith<$Res> {
  __$AddTaxCopyWithImpl(this._self, this._then);

  final _AddTax _self;
  final $Res Function(_AddTax) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tax = null,
  }) {
    return _then(_AddTax(
      null == tax
          ? _self.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _AddServiceCharge implements CheckoutEvent {
  const _AddServiceCharge(this.serviceCharge);

  final int serviceCharge;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddServiceChargeCopyWith<_AddServiceCharge> get copyWith =>
      __$AddServiceChargeCopyWithImpl<_AddServiceCharge>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddServiceCharge &&
            (identical(other.serviceCharge, serviceCharge) ||
                other.serviceCharge == serviceCharge));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serviceCharge);

  @override
  String toString() {
    return 'CheckoutEvent.addServiceCharge(serviceCharge: $serviceCharge)';
  }
}

/// @nodoc
abstract mixin class _$AddServiceChargeCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$AddServiceChargeCopyWith(
          _AddServiceCharge value, $Res Function(_AddServiceCharge) _then) =
      __$AddServiceChargeCopyWithImpl;
  @useResult
  $Res call({int serviceCharge});
}

/// @nodoc
class __$AddServiceChargeCopyWithImpl<$Res>
    implements _$AddServiceChargeCopyWith<$Res> {
  __$AddServiceChargeCopyWithImpl(this._self, this._then);

  final _AddServiceCharge _self;
  final $Res Function(_AddServiceCharge) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serviceCharge = null,
  }) {
    return _then(_AddServiceCharge(
      null == serviceCharge
          ? _self.serviceCharge
          : serviceCharge // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _RemoveTax implements CheckoutEvent {
  const _RemoveTax();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RemoveTax);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CheckoutEvent.removeTax()';
  }
}

/// @nodoc

class _RemoveServiceCharge implements CheckoutEvent {
  const _RemoveServiceCharge();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RemoveServiceCharge);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CheckoutEvent.removeServiceCharge()';
  }
}

/// @nodoc

class _SaveDraftOrder implements CheckoutEvent {
  const _SaveDraftOrder(this.tableNumber, this.draftName, this.discountAmount);

  final int tableNumber;
  final String draftName;
  final int discountAmount;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveDraftOrderCopyWith<_SaveDraftOrder> get copyWith =>
      __$SaveDraftOrderCopyWithImpl<_SaveDraftOrder>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveDraftOrder &&
            (identical(other.tableNumber, tableNumber) ||
                other.tableNumber == tableNumber) &&
            (identical(other.draftName, draftName) ||
                other.draftName == draftName) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tableNumber, draftName, discountAmount);

  @override
  String toString() {
    return 'CheckoutEvent.saveDraftOrder(tableNumber: $tableNumber, draftName: $draftName, discountAmount: $discountAmount)';
  }
}

/// @nodoc
abstract mixin class _$SaveDraftOrderCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$SaveDraftOrderCopyWith(
          _SaveDraftOrder value, $Res Function(_SaveDraftOrder) _then) =
      __$SaveDraftOrderCopyWithImpl;
  @useResult
  $Res call({int tableNumber, String draftName, int discountAmount});
}

/// @nodoc
class __$SaveDraftOrderCopyWithImpl<$Res>
    implements _$SaveDraftOrderCopyWith<$Res> {
  __$SaveDraftOrderCopyWithImpl(this._self, this._then);

  final _SaveDraftOrder _self;
  final $Res Function(_SaveDraftOrder) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tableNumber = null,
    Object? draftName = null,
    Object? discountAmount = null,
  }) {
    return _then(_SaveDraftOrder(
      null == tableNumber
          ? _self.tableNumber
          : tableNumber // ignore: cast_nullable_to_non_nullable
              as int,
      null == draftName
          ? _self.draftName
          : draftName // ignore: cast_nullable_to_non_nullable
              as String,
      null == discountAmount
          ? _self.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _LoadDraftOrder implements CheckoutEvent {
  const _LoadDraftOrder(this.data);

  final DraftOrderModel data;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadDraftOrderCopyWith<_LoadDraftOrder> get copyWith =>
      __$LoadDraftOrderCopyWithImpl<_LoadDraftOrder>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadDraftOrder &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'CheckoutEvent.loadDraftOrder(data: $data)';
  }
}

/// @nodoc
abstract mixin class _$LoadDraftOrderCopyWith<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  factory _$LoadDraftOrderCopyWith(
          _LoadDraftOrder value, $Res Function(_LoadDraftOrder) _then) =
      __$LoadDraftOrderCopyWithImpl;
  @useResult
  $Res call({DraftOrderModel data});
}

/// @nodoc
class __$LoadDraftOrderCopyWithImpl<$Res>
    implements _$LoadDraftOrderCopyWith<$Res> {
  __$LoadDraftOrderCopyWithImpl(this._self, this._then);

  final _LoadDraftOrder _self;
  final $Res Function(_LoadDraftOrder) _then;

  /// Create a copy of CheckoutEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(_LoadDraftOrder(
      null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as DraftOrderModel,
    ));
  }
}

/// @nodoc
mixin _$CheckoutState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CheckoutState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CheckoutState()';
  }
}

/// @nodoc
class $CheckoutStateCopyWith<$Res> {
  $CheckoutStateCopyWith(CheckoutState _, $Res Function(CheckoutState) __);
}

/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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
    TResult Function(_SavedDraftOrder value)? savedDraftOrder,
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
      case _SavedDraftOrder() when savedDraftOrder != null:
        return savedDraftOrder(_that);
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
    required TResult Function(_SavedDraftOrder value) savedDraftOrder,
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
      case _SavedDraftOrder():
        return savedDraftOrder(_that);
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
    TResult? Function(_SavedDraftOrder value)? savedDraftOrder,
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
      case _SavedDraftOrder() when savedDraftOrder != null:
        return savedDraftOrder(_that);
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
    TResult Function(
            List<ProductQuantity> items,
            List<Discount> discounts,
            int discount,
            int discountAmount,
            int tax,
            int serviceCharge,
            int totalQuantity,
            int totalPrice,
            String draftName)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(int orderId)? savedDraftOrder,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(
            _that.items,
            _that.discounts,
            _that.discount,
            _that.discountAmount,
            _that.tax,
            _that.serviceCharge,
            _that.totalQuantity,
            _that.totalPrice,
            _that.draftName);
      case _Error() when error != null:
        return error(_that.message);
      case _SavedDraftOrder() when savedDraftOrder != null:
        return savedDraftOrder(_that.orderId);
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
    required TResult Function(
            List<ProductQuantity> items,
            List<Discount> discounts,
            int discount,
            int discountAmount,
            int tax,
            int serviceCharge,
            int totalQuantity,
            int totalPrice,
            String draftName)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(int orderId) savedDraftOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(
            _that.items,
            _that.discounts,
            _that.discount,
            _that.discountAmount,
            _that.tax,
            _that.serviceCharge,
            _that.totalQuantity,
            _that.totalPrice,
            _that.draftName);
      case _Error():
        return error(_that.message);
      case _SavedDraftOrder():
        return savedDraftOrder(_that.orderId);
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
    TResult? Function(
            List<ProductQuantity> items,
            List<Discount> discounts,
            int discount,
            int discountAmount,
            int tax,
            int serviceCharge,
            int totalQuantity,
            int totalPrice,
            String draftName)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(int orderId)? savedDraftOrder,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(
            _that.items,
            _that.discounts,
            _that.discount,
            _that.discountAmount,
            _that.tax,
            _that.serviceCharge,
            _that.totalQuantity,
            _that.totalPrice,
            _that.draftName);
      case _Error() when error != null:
        return error(_that.message);
      case _SavedDraftOrder() when savedDraftOrder != null:
        return savedDraftOrder(_that.orderId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements CheckoutState {
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
    return 'CheckoutState.initial()';
  }
}

/// @nodoc

class _Loading implements CheckoutState {
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
    return 'CheckoutState.loading()';
  }
}

/// @nodoc

class _Loaded implements CheckoutState {
  const _Loaded(
      final List<ProductQuantity> items,
      final List<Discount> discounts,
      this.discount,
      this.discountAmount,
      this.tax,
      this.serviceCharge,
      this.totalQuantity,
      this.totalPrice,
      this.draftName)
      : _items = items,
        _discounts = discounts;

  final List<ProductQuantity> _items;
  List<ProductQuantity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<Discount> _discounts;
  List<Discount> get discounts {
    if (_discounts is EqualUnmodifiableListView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discounts);
  }

  final int discount;
  final int discountAmount;
  final int tax;
  final int serviceCharge;
  final int totalQuantity;
  final int totalPrice;
  final String draftName;

  /// Create a copy of CheckoutState
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
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._discounts, _discounts) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.serviceCharge, serviceCharge) ||
                other.serviceCharge == serviceCharge) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.draftName, draftName) ||
                other.draftName == draftName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_discounts),
      discount,
      discountAmount,
      tax,
      serviceCharge,
      totalQuantity,
      totalPrice,
      draftName);

  @override
  String toString() {
    return 'CheckoutState.loaded(items: $items, discounts: $discounts, discount: $discount, discountAmount: $discountAmount, tax: $tax, serviceCharge: $serviceCharge, totalQuantity: $totalQuantity, totalPrice: $totalPrice, draftName: $draftName)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<ProductQuantity> items,
      List<Discount> discounts,
      int discount,
      int discountAmount,
      int tax,
      int serviceCharge,
      int totalQuantity,
      int totalPrice,
      String draftName});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? discounts = null,
    Object? discount = null,
    Object? discountAmount = null,
    Object? tax = null,
    Object? serviceCharge = null,
    Object? totalQuantity = null,
    Object? totalPrice = null,
    Object? draftName = null,
  }) {
    return _then(_Loaded(
      null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ProductQuantity>,
      null == discounts
          ? _self._discounts
          : discounts // ignore: cast_nullable_to_non_nullable
              as List<Discount>,
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
      null == totalQuantity
          ? _self.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      null == draftName
          ? _self.draftName
          : draftName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Error implements CheckoutState {
  const _Error(this.message);

  final String message;

  /// Create a copy of CheckoutState
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
    return 'CheckoutState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
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

  /// Create a copy of CheckoutState
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

/// @nodoc

class _SavedDraftOrder implements CheckoutState {
  const _SavedDraftOrder(this.orderId);

  final int orderId;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedDraftOrderCopyWith<_SavedDraftOrder> get copyWith =>
      __$SavedDraftOrderCopyWithImpl<_SavedDraftOrder>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedDraftOrder &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  @override
  String toString() {
    return 'CheckoutState.savedDraftOrder(orderId: $orderId)';
  }
}

/// @nodoc
abstract mixin class _$SavedDraftOrderCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$SavedDraftOrderCopyWith(
          _SavedDraftOrder value, $Res Function(_SavedDraftOrder) _then) =
      __$SavedDraftOrderCopyWithImpl;
  @useResult
  $Res call({int orderId});
}

/// @nodoc
class __$SavedDraftOrderCopyWithImpl<$Res>
    implements _$SavedDraftOrderCopyWith<$Res> {
  __$SavedDraftOrderCopyWithImpl(this._self, this._then);

  final _SavedDraftOrder _self;
  final $Res Function(_SavedDraftOrder) _then;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_SavedDraftOrder(
      null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
