// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discount_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscountEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DiscountEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DiscountEvent()';
  }
}

/// @nodoc
class $DiscountEventCopyWith<$Res> {
  $DiscountEventCopyWith(DiscountEvent _, $Res Function(DiscountEvent) __);
}

/// Adds pattern-matching-related methods to [DiscountEvent].
extension DiscountEventPatterns on DiscountEvent {
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
    TResult Function(_GetDiscounts value)? getDiscounts,
    TResult Function(_GetDiscountsByCategory value)? getDiscountsByCategory,
    TResult Function(_AddDiscount value)? addDiscount,
    TResult Function(_UpdateDiscount value)? updateDiscount,
    TResult Function(_DeleteDiscount value)? deleteDiscount,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetDiscounts() when getDiscounts != null:
        return getDiscounts(_that);
      case _GetDiscountsByCategory() when getDiscountsByCategory != null:
        return getDiscountsByCategory(_that);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(_that);
      case _UpdateDiscount() when updateDiscount != null:
        return updateDiscount(_that);
      case _DeleteDiscount() when deleteDiscount != null:
        return deleteDiscount(_that);
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
    required TResult Function(_GetDiscounts value) getDiscounts,
    required TResult Function(_GetDiscountsByCategory value)
        getDiscountsByCategory,
    required TResult Function(_AddDiscount value) addDiscount,
    required TResult Function(_UpdateDiscount value) updateDiscount,
    required TResult Function(_DeleteDiscount value) deleteDiscount,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _GetDiscounts():
        return getDiscounts(_that);
      case _GetDiscountsByCategory():
        return getDiscountsByCategory(_that);
      case _AddDiscount():
        return addDiscount(_that);
      case _UpdateDiscount():
        return updateDiscount(_that);
      case _DeleteDiscount():
        return deleteDiscount(_that);
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
    TResult? Function(_GetDiscounts value)? getDiscounts,
    TResult? Function(_GetDiscountsByCategory value)? getDiscountsByCategory,
    TResult? Function(_AddDiscount value)? addDiscount,
    TResult? Function(_UpdateDiscount value)? updateDiscount,
    TResult? Function(_DeleteDiscount value)? deleteDiscount,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetDiscounts() when getDiscounts != null:
        return getDiscounts(_that);
      case _GetDiscountsByCategory() when getDiscountsByCategory != null:
        return getDiscountsByCategory(_that);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(_that);
      case _UpdateDiscount() when updateDiscount != null:
        return updateDiscount(_that);
      case _DeleteDiscount() when deleteDiscount != null:
        return deleteDiscount(_that);
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
    TResult Function()? getDiscounts,
    TResult Function(String category)? getDiscountsByCategory,
    TResult Function(
            String name, String description, double value, String category)?
        addDiscount,
    TResult Function(int id, String name, String description, double value,
            String category)?
        updateDiscount,
    TResult Function(int id)? deleteDiscount,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetDiscounts() when getDiscounts != null:
        return getDiscounts();
      case _GetDiscountsByCategory() when getDiscountsByCategory != null:
        return getDiscountsByCategory(_that.category);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(
            _that.name, _that.description, _that.value, _that.category);
      case _UpdateDiscount() when updateDiscount != null:
        return updateDiscount(_that.id, _that.name, _that.description,
            _that.value, _that.category);
      case _DeleteDiscount() when deleteDiscount != null:
        return deleteDiscount(_that.id);
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
    required TResult Function() getDiscounts,
    required TResult Function(String category) getDiscountsByCategory,
    required TResult Function(
            String name, String description, double value, String category)
        addDiscount,
    required TResult Function(int id, String name, String description,
            double value, String category)
        updateDiscount,
    required TResult Function(int id) deleteDiscount,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _GetDiscounts():
        return getDiscounts();
      case _GetDiscountsByCategory():
        return getDiscountsByCategory(_that.category);
      case _AddDiscount():
        return addDiscount(
            _that.name, _that.description, _that.value, _that.category);
      case _UpdateDiscount():
        return updateDiscount(_that.id, _that.name, _that.description,
            _that.value, _that.category);
      case _DeleteDiscount():
        return deleteDiscount(_that.id);
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
    TResult? Function()? getDiscounts,
    TResult? Function(String category)? getDiscountsByCategory,
    TResult? Function(
            String name, String description, double value, String category)?
        addDiscount,
    TResult? Function(int id, String name, String description, double value,
            String category)?
        updateDiscount,
    TResult? Function(int id)? deleteDiscount,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetDiscounts() when getDiscounts != null:
        return getDiscounts();
      case _GetDiscountsByCategory() when getDiscountsByCategory != null:
        return getDiscountsByCategory(_that.category);
      case _AddDiscount() when addDiscount != null:
        return addDiscount(
            _that.name, _that.description, _that.value, _that.category);
      case _UpdateDiscount() when updateDiscount != null:
        return updateDiscount(_that.id, _that.name, _that.description,
            _that.value, _that.category);
      case _DeleteDiscount() when deleteDiscount != null:
        return deleteDiscount(_that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements DiscountEvent {
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
    return 'DiscountEvent.started()';
  }
}

/// @nodoc

class _GetDiscounts implements DiscountEvent {
  const _GetDiscounts();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetDiscounts);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DiscountEvent.getDiscounts()';
  }
}

/// @nodoc

class _GetDiscountsByCategory implements DiscountEvent {
  const _GetDiscountsByCategory(this.category);

  final String category;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetDiscountsByCategoryCopyWith<_GetDiscountsByCategory> get copyWith =>
      __$GetDiscountsByCategoryCopyWithImpl<_GetDiscountsByCategory>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetDiscountsByCategory &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  @override
  String toString() {
    return 'DiscountEvent.getDiscountsByCategory(category: $category)';
  }
}

/// @nodoc
abstract mixin class _$GetDiscountsByCategoryCopyWith<$Res>
    implements $DiscountEventCopyWith<$Res> {
  factory _$GetDiscountsByCategoryCopyWith(_GetDiscountsByCategory value,
          $Res Function(_GetDiscountsByCategory) _then) =
      __$GetDiscountsByCategoryCopyWithImpl;
  @useResult
  $Res call({String category});
}

/// @nodoc
class __$GetDiscountsByCategoryCopyWithImpl<$Res>
    implements _$GetDiscountsByCategoryCopyWith<$Res> {
  __$GetDiscountsByCategoryCopyWithImpl(this._self, this._then);

  final _GetDiscountsByCategory _self;
  final $Res Function(_GetDiscountsByCategory) _then;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
  }) {
    return _then(_GetDiscountsByCategory(
      null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _AddDiscount implements DiscountEvent {
  const _AddDiscount(
      {required this.name,
      required this.description,
      required this.value,
      required this.category});

  final String name;
  final String description;
  final double value;
  final String category;

  /// Create a copy of DiscountEvent
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, value, category);

  @override
  String toString() {
    return 'DiscountEvent.addDiscount(name: $name, description: $description, value: $value, category: $category)';
  }
}

/// @nodoc
abstract mixin class _$AddDiscountCopyWith<$Res>
    implements $DiscountEventCopyWith<$Res> {
  factory _$AddDiscountCopyWith(
          _AddDiscount value, $Res Function(_AddDiscount) _then) =
      __$AddDiscountCopyWithImpl;
  @useResult
  $Res call({String name, String description, double value, String category});
}

/// @nodoc
class __$AddDiscountCopyWithImpl<$Res> implements _$AddDiscountCopyWith<$Res> {
  __$AddDiscountCopyWithImpl(this._self, this._then);

  final _AddDiscount _self;
  final $Res Function(_AddDiscount) _then;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? value = null,
    Object? category = null,
  }) {
    return _then(_AddDiscount(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _UpdateDiscount implements DiscountEvent {
  const _UpdateDiscount(
      {required this.id,
      required this.name,
      required this.description,
      required this.value,
      required this.category});

  final int id;
  final String name;
  final String description;
  final double value;
  final String category;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateDiscountCopyWith<_UpdateDiscount> get copyWith =>
      __$UpdateDiscountCopyWithImpl<_UpdateDiscount>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateDiscount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, value, category);

  @override
  String toString() {
    return 'DiscountEvent.updateDiscount(id: $id, name: $name, description: $description, value: $value, category: $category)';
  }
}

/// @nodoc
abstract mixin class _$UpdateDiscountCopyWith<$Res>
    implements $DiscountEventCopyWith<$Res> {
  factory _$UpdateDiscountCopyWith(
          _UpdateDiscount value, $Res Function(_UpdateDiscount) _then) =
      __$UpdateDiscountCopyWithImpl;
  @useResult
  $Res call(
      {int id, String name, String description, double value, String category});
}

/// @nodoc
class __$UpdateDiscountCopyWithImpl<$Res>
    implements _$UpdateDiscountCopyWith<$Res> {
  __$UpdateDiscountCopyWithImpl(this._self, this._then);

  final _UpdateDiscount _self;
  final $Res Function(_UpdateDiscount) _then;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? value = null,
    Object? category = null,
  }) {
    return _then(_UpdateDiscount(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _DeleteDiscount implements DiscountEvent {
  const _DeleteDiscount(this.id);

  final int id;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteDiscountCopyWith<_DeleteDiscount> get copyWith =>
      __$DeleteDiscountCopyWithImpl<_DeleteDiscount>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeleteDiscount &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'DiscountEvent.deleteDiscount(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$DeleteDiscountCopyWith<$Res>
    implements $DiscountEventCopyWith<$Res> {
  factory _$DeleteDiscountCopyWith(
          _DeleteDiscount value, $Res Function(_DeleteDiscount) _then) =
      __$DeleteDiscountCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$DeleteDiscountCopyWithImpl<$Res>
    implements _$DeleteDiscountCopyWith<$Res> {
  __$DeleteDiscountCopyWithImpl(this._self, this._then);

  final _DeleteDiscount _self;
  final $Res Function(_DeleteDiscount) _then;

  /// Create a copy of DiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_DeleteDiscount(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$DiscountState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DiscountState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DiscountState()';
  }
}

/// @nodoc
class $DiscountStateCopyWith<$Res> {
  $DiscountStateCopyWith(DiscountState _, $Res Function(DiscountState) __);
}

/// Adds pattern-matching-related methods to [DiscountState].
extension DiscountStatePatterns on DiscountState {
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
    TResult Function(_Success value)? success,
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
      case _Success() when success != null:
        return success(_that);
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
    required TResult Function(_Success value) success,
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
      case _Success():
        return success(_that);
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
    TResult? Function(_Success value)? success,
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
      case _Success() when success != null:
        return success(_that);
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
    TResult Function(List<Discount> discounts)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? success,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.discounts);
      case _Error() when error != null:
        return error(_that.message);
      case _Success() when success != null:
        return success(_that.message);
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
    required TResult Function(List<Discount> discounts) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) success,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(_that.discounts);
      case _Error():
        return error(_that.message);
      case _Success():
        return success(_that.message);
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
    TResult? Function(List<Discount> discounts)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? success,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.discounts);
      case _Error() when error != null:
        return error(_that.message);
      case _Success() when success != null:
        return success(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements DiscountState {
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
    return 'DiscountState.initial()';
  }
}

/// @nodoc

class _Loading implements DiscountState {
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
    return 'DiscountState.loading()';
  }
}

/// @nodoc

class _Loaded implements DiscountState {
  const _Loaded(final List<Discount> discounts) : _discounts = discounts;

  final List<Discount> _discounts;
  List<Discount> get discounts {
    if (_discounts is EqualUnmodifiableListView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discounts);
  }

  /// Create a copy of DiscountState
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
            const DeepCollectionEquality()
                .equals(other._discounts, _discounts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_discounts));

  @override
  String toString() {
    return 'DiscountState.loaded(discounts: $discounts)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $DiscountStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({List<Discount> discounts});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of DiscountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? discounts = null,
  }) {
    return _then(_Loaded(
      null == discounts
          ? _self._discounts
          : discounts // ignore: cast_nullable_to_non_nullable
              as List<Discount>,
    ));
  }
}

/// @nodoc

class _Error implements DiscountState {
  const _Error(this.message);

  final String message;

  /// Create a copy of DiscountState
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
    return 'DiscountState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $DiscountStateCopyWith<$Res> {
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

  /// Create a copy of DiscountState
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

class _Success implements DiscountState {
  const _Success(this.message);

  final String message;

  /// Create a copy of DiscountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DiscountState.success(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res>
    implements $DiscountStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) =
      __$SuccessCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

  /// Create a copy of DiscountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Success(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
