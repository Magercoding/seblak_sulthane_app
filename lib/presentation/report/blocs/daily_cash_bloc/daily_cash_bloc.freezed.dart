// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_cash_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyCashEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DailyCashEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DailyCashEvent()';
  }
}

/// @nodoc
class $DailyCashEventCopyWith<$Res> {
  $DailyCashEventCopyWith(DailyCashEvent _, $Res Function(DailyCashEvent) __);
}

/// Adds pattern-matching-related methods to [DailyCashEvent].
extension DailyCashEventPatterns on DailyCashEvent {
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
    TResult Function(_FetchDailyCash value)? fetchDailyCash,
    TResult Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult Function(_AddExpense value)? addExpense,
    TResult Function(_OpenShift value)? openShift,
    TResult Function(_CloseShift value)? closeShift,
    TResult Function(_FetchActiveShifts value)? fetchActiveShifts,
    TResult Function(_FetchShiftById value)? fetchShiftById,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _FetchDailyCash() when fetchDailyCash != null:
        return fetchDailyCash(_that);
      case _SetOpeningBalance() when setOpeningBalance != null:
        return setOpeningBalance(_that);
      case _AddExpense() when addExpense != null:
        return addExpense(_that);
      case _OpenShift() when openShift != null:
        return openShift(_that);
      case _CloseShift() when closeShift != null:
        return closeShift(_that);
      case _FetchActiveShifts() when fetchActiveShifts != null:
        return fetchActiveShifts(_that);
      case _FetchShiftById() when fetchShiftById != null:
        return fetchShiftById(_that);
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
    required TResult Function(_FetchDailyCash value) fetchDailyCash,
    required TResult Function(_SetOpeningBalance value) setOpeningBalance,
    required TResult Function(_AddExpense value) addExpense,
    required TResult Function(_OpenShift value) openShift,
    required TResult Function(_CloseShift value) closeShift,
    required TResult Function(_FetchActiveShifts value) fetchActiveShifts,
    required TResult Function(_FetchShiftById value) fetchShiftById,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _FetchDailyCash():
        return fetchDailyCash(_that);
      case _SetOpeningBalance():
        return setOpeningBalance(_that);
      case _AddExpense():
        return addExpense(_that);
      case _OpenShift():
        return openShift(_that);
      case _CloseShift():
        return closeShift(_that);
      case _FetchActiveShifts():
        return fetchActiveShifts(_that);
      case _FetchShiftById():
        return fetchShiftById(_that);
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
    TResult? Function(_FetchDailyCash value)? fetchDailyCash,
    TResult? Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult? Function(_AddExpense value)? addExpense,
    TResult? Function(_OpenShift value)? openShift,
    TResult? Function(_CloseShift value)? closeShift,
    TResult? Function(_FetchActiveShifts value)? fetchActiveShifts,
    TResult? Function(_FetchShiftById value)? fetchShiftById,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _FetchDailyCash() when fetchDailyCash != null:
        return fetchDailyCash(_that);
      case _SetOpeningBalance() when setOpeningBalance != null:
        return setOpeningBalance(_that);
      case _AddExpense() when addExpense != null:
        return addExpense(_that);
      case _OpenShift() when openShift != null:
        return openShift(_that);
      case _CloseShift() when closeShift != null:
        return closeShift(_that);
      case _FetchActiveShifts() when fetchActiveShifts != null:
        return fetchActiveShifts(_that);
      case _FetchShiftById() when fetchShiftById != null:
        return fetchShiftById(_that);
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
    TResult Function(String date)? fetchDailyCash,
    TResult Function(String date, int openingBalance)? setOpeningBalance,
    TResult Function(String date, int amount, String note)? addExpense,
    TResult Function(String date, int openingBalance, String? shiftName)?
        openShift,
    TResult Function(int shiftId)? closeShift,
    TResult Function()? fetchActiveShifts,
    TResult Function(int shiftId)? fetchShiftById,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _FetchDailyCash() when fetchDailyCash != null:
        return fetchDailyCash(_that.date);
      case _SetOpeningBalance() when setOpeningBalance != null:
        return setOpeningBalance(_that.date, _that.openingBalance);
      case _AddExpense() when addExpense != null:
        return addExpense(_that.date, _that.amount, _that.note);
      case _OpenShift() when openShift != null:
        return openShift(_that.date, _that.openingBalance, _that.shiftName);
      case _CloseShift() when closeShift != null:
        return closeShift(_that.shiftId);
      case _FetchActiveShifts() when fetchActiveShifts != null:
        return fetchActiveShifts();
      case _FetchShiftById() when fetchShiftById != null:
        return fetchShiftById(_that.shiftId);
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
    required TResult Function(String date) fetchDailyCash,
    required TResult Function(String date, int openingBalance)
        setOpeningBalance,
    required TResult Function(String date, int amount, String note) addExpense,
    required TResult Function(
            String date, int openingBalance, String? shiftName)
        openShift,
    required TResult Function(int shiftId) closeShift,
    required TResult Function() fetchActiveShifts,
    required TResult Function(int shiftId) fetchShiftById,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _FetchDailyCash():
        return fetchDailyCash(_that.date);
      case _SetOpeningBalance():
        return setOpeningBalance(_that.date, _that.openingBalance);
      case _AddExpense():
        return addExpense(_that.date, _that.amount, _that.note);
      case _OpenShift():
        return openShift(_that.date, _that.openingBalance, _that.shiftName);
      case _CloseShift():
        return closeShift(_that.shiftId);
      case _FetchActiveShifts():
        return fetchActiveShifts();
      case _FetchShiftById():
        return fetchShiftById(_that.shiftId);
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
    TResult? Function(String date)? fetchDailyCash,
    TResult? Function(String date, int openingBalance)? setOpeningBalance,
    TResult? Function(String date, int amount, String note)? addExpense,
    TResult? Function(String date, int openingBalance, String? shiftName)?
        openShift,
    TResult? Function(int shiftId)? closeShift,
    TResult? Function()? fetchActiveShifts,
    TResult? Function(int shiftId)? fetchShiftById,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _FetchDailyCash() when fetchDailyCash != null:
        return fetchDailyCash(_that.date);
      case _SetOpeningBalance() when setOpeningBalance != null:
        return setOpeningBalance(_that.date, _that.openingBalance);
      case _AddExpense() when addExpense != null:
        return addExpense(_that.date, _that.amount, _that.note);
      case _OpenShift() when openShift != null:
        return openShift(_that.date, _that.openingBalance, _that.shiftName);
      case _CloseShift() when closeShift != null:
        return closeShift(_that.shiftId);
      case _FetchActiveShifts() when fetchActiveShifts != null:
        return fetchActiveShifts();
      case _FetchShiftById() when fetchShiftById != null:
        return fetchShiftById(_that.shiftId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements DailyCashEvent {
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
    return 'DailyCashEvent.started()';
  }
}

/// @nodoc

class _FetchDailyCash implements DailyCashEvent {
  const _FetchDailyCash(this.date);

  final String date;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FetchDailyCashCopyWith<_FetchDailyCash> get copyWith =>
      __$FetchDailyCashCopyWithImpl<_FetchDailyCash>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FetchDailyCash &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  @override
  String toString() {
    return 'DailyCashEvent.fetchDailyCash(date: $date)';
  }
}

/// @nodoc
abstract mixin class _$FetchDailyCashCopyWith<$Res>
    implements $DailyCashEventCopyWith<$Res> {
  factory _$FetchDailyCashCopyWith(
          _FetchDailyCash value, $Res Function(_FetchDailyCash) _then) =
      __$FetchDailyCashCopyWithImpl;
  @useResult
  $Res call({String date});
}

/// @nodoc
class __$FetchDailyCashCopyWithImpl<$Res>
    implements _$FetchDailyCashCopyWith<$Res> {
  __$FetchDailyCashCopyWithImpl(this._self, this._then);

  final _FetchDailyCash _self;
  final $Res Function(_FetchDailyCash) _then;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
  }) {
    return _then(_FetchDailyCash(
      null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SetOpeningBalance implements DailyCashEvent {
  const _SetOpeningBalance(this.date, this.openingBalance);

  final String date;
  final int openingBalance;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SetOpeningBalanceCopyWith<_SetOpeningBalance> get copyWith =>
      __$SetOpeningBalanceCopyWithImpl<_SetOpeningBalance>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SetOpeningBalance &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, openingBalance);

  @override
  String toString() {
    return 'DailyCashEvent.setOpeningBalance(date: $date, openingBalance: $openingBalance)';
  }
}

/// @nodoc
abstract mixin class _$SetOpeningBalanceCopyWith<$Res>
    implements $DailyCashEventCopyWith<$Res> {
  factory _$SetOpeningBalanceCopyWith(
          _SetOpeningBalance value, $Res Function(_SetOpeningBalance) _then) =
      __$SetOpeningBalanceCopyWithImpl;
  @useResult
  $Res call({String date, int openingBalance});
}

/// @nodoc
class __$SetOpeningBalanceCopyWithImpl<$Res>
    implements _$SetOpeningBalanceCopyWith<$Res> {
  __$SetOpeningBalanceCopyWithImpl(this._self, this._then);

  final _SetOpeningBalance _self;
  final $Res Function(_SetOpeningBalance) _then;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? openingBalance = null,
  }) {
    return _then(_SetOpeningBalance(
      null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == openingBalance
          ? _self.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _AddExpense implements DailyCashEvent {
  const _AddExpense(this.date, this.amount, this.note);

  final String date;
  final int amount;
  final String note;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddExpenseCopyWith<_AddExpense> get copyWith =>
      __$AddExpenseCopyWithImpl<_AddExpense>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddExpense &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, amount, note);

  @override
  String toString() {
    return 'DailyCashEvent.addExpense(date: $date, amount: $amount, note: $note)';
  }
}

/// @nodoc
abstract mixin class _$AddExpenseCopyWith<$Res>
    implements $DailyCashEventCopyWith<$Res> {
  factory _$AddExpenseCopyWith(
          _AddExpense value, $Res Function(_AddExpense) _then) =
      __$AddExpenseCopyWithImpl;
  @useResult
  $Res call({String date, int amount, String note});
}

/// @nodoc
class __$AddExpenseCopyWithImpl<$Res> implements _$AddExpenseCopyWith<$Res> {
  __$AddExpenseCopyWithImpl(this._self, this._then);

  final _AddExpense _self;
  final $Res Function(_AddExpense) _then;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? amount = null,
    Object? note = null,
  }) {
    return _then(_AddExpense(
      null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      null == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _OpenShift implements DailyCashEvent {
  const _OpenShift(this.date, this.openingBalance, {this.shiftName});

  final String date;
  final int openingBalance;
  final String? shiftName;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OpenShiftCopyWith<_OpenShift> get copyWith =>
      __$OpenShiftCopyWithImpl<_OpenShift>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OpenShift &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.shiftName, shiftName) ||
                other.shiftName == shiftName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, openingBalance, shiftName);

  @override
  String toString() {
    return 'DailyCashEvent.openShift(date: $date, openingBalance: $openingBalance, shiftName: $shiftName)';
  }
}

/// @nodoc
abstract mixin class _$OpenShiftCopyWith<$Res>
    implements $DailyCashEventCopyWith<$Res> {
  factory _$OpenShiftCopyWith(
          _OpenShift value, $Res Function(_OpenShift) _then) =
      __$OpenShiftCopyWithImpl;
  @useResult
  $Res call({String date, int openingBalance, String? shiftName});
}

/// @nodoc
class __$OpenShiftCopyWithImpl<$Res> implements _$OpenShiftCopyWith<$Res> {
  __$OpenShiftCopyWithImpl(this._self, this._then);

  final _OpenShift _self;
  final $Res Function(_OpenShift) _then;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? openingBalance = null,
    Object? shiftName = freezed,
  }) {
    return _then(_OpenShift(
      null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == openingBalance
          ? _self.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as int,
      shiftName: freezed == shiftName
          ? _self.shiftName
          : shiftName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _CloseShift implements DailyCashEvent {
  const _CloseShift(this.shiftId);

  final int shiftId;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CloseShiftCopyWith<_CloseShift> get copyWith =>
      __$CloseShiftCopyWithImpl<_CloseShift>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CloseShift &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shiftId);

  @override
  String toString() {
    return 'DailyCashEvent.closeShift(shiftId: $shiftId)';
  }
}

/// @nodoc
abstract mixin class _$CloseShiftCopyWith<$Res>
    implements $DailyCashEventCopyWith<$Res> {
  factory _$CloseShiftCopyWith(
          _CloseShift value, $Res Function(_CloseShift) _then) =
      __$CloseShiftCopyWithImpl;
  @useResult
  $Res call({int shiftId});
}

/// @nodoc
class __$CloseShiftCopyWithImpl<$Res> implements _$CloseShiftCopyWith<$Res> {
  __$CloseShiftCopyWithImpl(this._self, this._then);

  final _CloseShift _self;
  final $Res Function(_CloseShift) _then;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
  }) {
    return _then(_CloseShift(
      null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _FetchActiveShifts implements DailyCashEvent {
  const _FetchActiveShifts();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FetchActiveShifts);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DailyCashEvent.fetchActiveShifts()';
  }
}

/// @nodoc

class _FetchShiftById implements DailyCashEvent {
  const _FetchShiftById(this.shiftId);

  final int shiftId;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FetchShiftByIdCopyWith<_FetchShiftById> get copyWith =>
      __$FetchShiftByIdCopyWithImpl<_FetchShiftById>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FetchShiftById &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shiftId);

  @override
  String toString() {
    return 'DailyCashEvent.fetchShiftById(shiftId: $shiftId)';
  }
}

/// @nodoc
abstract mixin class _$FetchShiftByIdCopyWith<$Res>
    implements $DailyCashEventCopyWith<$Res> {
  factory _$FetchShiftByIdCopyWith(
          _FetchShiftById value, $Res Function(_FetchShiftById) _then) =
      __$FetchShiftByIdCopyWithImpl;
  @useResult
  $Res call({int shiftId});
}

/// @nodoc
class __$FetchShiftByIdCopyWithImpl<$Res>
    implements _$FetchShiftByIdCopyWith<$Res> {
  __$FetchShiftByIdCopyWithImpl(this._self, this._then);

  final _FetchShiftById _self;
  final $Res Function(_FetchShiftById) _then;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shiftId = null,
  }) {
    return _then(_FetchShiftById(
      null == shiftId
          ? _self.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$DailyCashState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DailyCashState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DailyCashState()';
  }
}

/// @nodoc
class $DailyCashStateCopyWith<$Res> {
  $DailyCashStateCopyWith(DailyCashState _, $Res Function(DailyCashState) __);
}

/// Adds pattern-matching-related methods to [DailyCashState].
extension DailyCashStatePatterns on DailyCashState {
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
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    TResult Function(_ShiftOpened value)? shiftOpened,
    TResult Function(_ShiftClosed value)? shiftClosed,
    TResult Function(_ShiftsLoaded value)? shiftsLoaded,
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
      case _OpeningBalanceSet() when openingBalanceSet != null:
        return openingBalanceSet(_that);
      case _ExpenseAdded() when expenseAdded != null:
        return expenseAdded(_that);
      case _ShiftOpened() when shiftOpened != null:
        return shiftOpened(_that);
      case _ShiftClosed() when shiftClosed != null:
        return shiftClosed(_that);
      case _ShiftsLoaded() when shiftsLoaded != null:
        return shiftsLoaded(_that);
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
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
    required TResult Function(_ShiftOpened value) shiftOpened,
    required TResult Function(_ShiftClosed value) shiftClosed,
    required TResult Function(_ShiftsLoaded value) shiftsLoaded,
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
      case _OpeningBalanceSet():
        return openingBalanceSet(_that);
      case _ExpenseAdded():
        return expenseAdded(_that);
      case _ShiftOpened():
        return shiftOpened(_that);
      case _ShiftClosed():
        return shiftClosed(_that);
      case _ShiftsLoaded():
        return shiftsLoaded(_that);
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
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
    TResult? Function(_ShiftOpened value)? shiftOpened,
    TResult? Function(_ShiftClosed value)? shiftClosed,
    TResult? Function(_ShiftsLoaded value)? shiftsLoaded,
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
      case _OpeningBalanceSet() when openingBalanceSet != null:
        return openingBalanceSet(_that);
      case _ExpenseAdded() when expenseAdded != null:
        return expenseAdded(_that);
      case _ShiftOpened() when shiftOpened != null:
        return shiftOpened(_that);
      case _ShiftClosed() when shiftClosed != null:
        return shiftClosed(_that);
      case _ShiftsLoaded() when shiftsLoaded != null:
        return shiftsLoaded(_that);
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
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
    TResult Function(DailyCashModel dailyCash)? shiftOpened,
    TResult Function(DailyCashModel dailyCash)? shiftClosed,
    TResult Function(List<DailyCashModel> shifts, int? activeShiftId)?
        shiftsLoaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.dailyCash);
      case _Error() when error != null:
        return error(_that.message);
      case _OpeningBalanceSet() when openingBalanceSet != null:
        return openingBalanceSet(_that.dailyCash);
      case _ExpenseAdded() when expenseAdded != null:
        return expenseAdded(_that.dailyCash);
      case _ShiftOpened() when shiftOpened != null:
        return shiftOpened(_that.dailyCash);
      case _ShiftClosed() when shiftClosed != null:
        return shiftClosed(_that.dailyCash);
      case _ShiftsLoaded() when shiftsLoaded != null:
        return shiftsLoaded(_that.shifts, _that.activeShiftId);
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
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
    required TResult Function(DailyCashModel dailyCash) shiftOpened,
    required TResult Function(DailyCashModel dailyCash) shiftClosed,
    required TResult Function(List<DailyCashModel> shifts, int? activeShiftId)
        shiftsLoaded,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(_that.dailyCash);
      case _Error():
        return error(_that.message);
      case _OpeningBalanceSet():
        return openingBalanceSet(_that.dailyCash);
      case _ExpenseAdded():
        return expenseAdded(_that.dailyCash);
      case _ShiftOpened():
        return shiftOpened(_that.dailyCash);
      case _ShiftClosed():
        return shiftClosed(_that.dailyCash);
      case _ShiftsLoaded():
        return shiftsLoaded(_that.shifts, _that.activeShiftId);
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
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
    TResult? Function(DailyCashModel dailyCash)? shiftOpened,
    TResult? Function(DailyCashModel dailyCash)? shiftClosed,
    TResult? Function(List<DailyCashModel> shifts, int? activeShiftId)?
        shiftsLoaded,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.dailyCash);
      case _Error() when error != null:
        return error(_that.message);
      case _OpeningBalanceSet() when openingBalanceSet != null:
        return openingBalanceSet(_that.dailyCash);
      case _ExpenseAdded() when expenseAdded != null:
        return expenseAdded(_that.dailyCash);
      case _ShiftOpened() when shiftOpened != null:
        return shiftOpened(_that.dailyCash);
      case _ShiftClosed() when shiftClosed != null:
        return shiftClosed(_that.dailyCash);
      case _ShiftsLoaded() when shiftsLoaded != null:
        return shiftsLoaded(_that.shifts, _that.activeShiftId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements DailyCashState {
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
    return 'DailyCashState.initial()';
  }
}

/// @nodoc

class _Loading implements DailyCashState {
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
    return 'DailyCashState.loading()';
  }
}

/// @nodoc

class _Loaded implements DailyCashState {
  const _Loaded(this.dailyCash);

  final DailyCashModel dailyCash;

  /// Create a copy of DailyCashState
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
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  @override
  String toString() {
    return 'DailyCashState.loaded(dailyCash: $dailyCash)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_Loaded(
      null == dailyCash
          ? _self.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _Error implements DailyCashState {
  const _Error(this.message);

  final String message;

  /// Create a copy of DailyCashState
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
    return 'DailyCashState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
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

  /// Create a copy of DailyCashState
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

class _OpeningBalanceSet implements DailyCashState {
  const _OpeningBalanceSet(this.dailyCash);

  final DailyCashModel dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OpeningBalanceSetCopyWith<_OpeningBalanceSet> get copyWith =>
      __$OpeningBalanceSetCopyWithImpl<_OpeningBalanceSet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OpeningBalanceSet &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  @override
  String toString() {
    return 'DailyCashState.openingBalanceSet(dailyCash: $dailyCash)';
  }
}

/// @nodoc
abstract mixin class _$OpeningBalanceSetCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
  factory _$OpeningBalanceSetCopyWith(
          _OpeningBalanceSet value, $Res Function(_OpeningBalanceSet) _then) =
      __$OpeningBalanceSetCopyWithImpl;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$OpeningBalanceSetCopyWithImpl<$Res>
    implements _$OpeningBalanceSetCopyWith<$Res> {
  __$OpeningBalanceSetCopyWithImpl(this._self, this._then);

  final _OpeningBalanceSet _self;
  final $Res Function(_OpeningBalanceSet) _then;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_OpeningBalanceSet(
      null == dailyCash
          ? _self.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _ExpenseAdded implements DailyCashState {
  const _ExpenseAdded(this.dailyCash);

  final DailyCashModel dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExpenseAddedCopyWith<_ExpenseAdded> get copyWith =>
      __$ExpenseAddedCopyWithImpl<_ExpenseAdded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpenseAdded &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  @override
  String toString() {
    return 'DailyCashState.expenseAdded(dailyCash: $dailyCash)';
  }
}

/// @nodoc
abstract mixin class _$ExpenseAddedCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
  factory _$ExpenseAddedCopyWith(
          _ExpenseAdded value, $Res Function(_ExpenseAdded) _then) =
      __$ExpenseAddedCopyWithImpl;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$ExpenseAddedCopyWithImpl<$Res>
    implements _$ExpenseAddedCopyWith<$Res> {
  __$ExpenseAddedCopyWithImpl(this._self, this._then);

  final _ExpenseAdded _self;
  final $Res Function(_ExpenseAdded) _then;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_ExpenseAdded(
      null == dailyCash
          ? _self.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _ShiftOpened implements DailyCashState {
  const _ShiftOpened(this.dailyCash);

  final DailyCashModel dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftOpenedCopyWith<_ShiftOpened> get copyWith =>
      __$ShiftOpenedCopyWithImpl<_ShiftOpened>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftOpened &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  @override
  String toString() {
    return 'DailyCashState.shiftOpened(dailyCash: $dailyCash)';
  }
}

/// @nodoc
abstract mixin class _$ShiftOpenedCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
  factory _$ShiftOpenedCopyWith(
          _ShiftOpened value, $Res Function(_ShiftOpened) _then) =
      __$ShiftOpenedCopyWithImpl;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$ShiftOpenedCopyWithImpl<$Res> implements _$ShiftOpenedCopyWith<$Res> {
  __$ShiftOpenedCopyWithImpl(this._self, this._then);

  final _ShiftOpened _self;
  final $Res Function(_ShiftOpened) _then;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_ShiftOpened(
      null == dailyCash
          ? _self.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _ShiftClosed implements DailyCashState {
  const _ShiftClosed(this.dailyCash);

  final DailyCashModel dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftClosedCopyWith<_ShiftClosed> get copyWith =>
      __$ShiftClosedCopyWithImpl<_ShiftClosed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftClosed &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  @override
  String toString() {
    return 'DailyCashState.shiftClosed(dailyCash: $dailyCash)';
  }
}

/// @nodoc
abstract mixin class _$ShiftClosedCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
  factory _$ShiftClosedCopyWith(
          _ShiftClosed value, $Res Function(_ShiftClosed) _then) =
      __$ShiftClosedCopyWithImpl;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$ShiftClosedCopyWithImpl<$Res> implements _$ShiftClosedCopyWith<$Res> {
  __$ShiftClosedCopyWithImpl(this._self, this._then);

  final _ShiftClosed _self;
  final $Res Function(_ShiftClosed) _then;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_ShiftClosed(
      null == dailyCash
          ? _self.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _ShiftsLoaded implements DailyCashState {
  const _ShiftsLoaded(final List<DailyCashModel> shifts, {this.activeShiftId})
      : _shifts = shifts;

  final List<DailyCashModel> _shifts;
  List<DailyCashModel> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  final int? activeShiftId;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ShiftsLoadedCopyWith<_ShiftsLoaded> get copyWith =>
      __$ShiftsLoadedCopyWithImpl<_ShiftsLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShiftsLoaded &&
            const DeepCollectionEquality().equals(other._shifts, _shifts) &&
            (identical(other.activeShiftId, activeShiftId) ||
                other.activeShiftId == activeShiftId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_shifts), activeShiftId);

  @override
  String toString() {
    return 'DailyCashState.shiftsLoaded(shifts: $shifts, activeShiftId: $activeShiftId)';
  }
}

/// @nodoc
abstract mixin class _$ShiftsLoadedCopyWith<$Res>
    implements $DailyCashStateCopyWith<$Res> {
  factory _$ShiftsLoadedCopyWith(
          _ShiftsLoaded value, $Res Function(_ShiftsLoaded) _then) =
      __$ShiftsLoadedCopyWithImpl;
  @useResult
  $Res call({List<DailyCashModel> shifts, int? activeShiftId});
}

/// @nodoc
class __$ShiftsLoadedCopyWithImpl<$Res>
    implements _$ShiftsLoadedCopyWith<$Res> {
  __$ShiftsLoadedCopyWithImpl(this._self, this._then);

  final _ShiftsLoaded _self;
  final $Res Function(_ShiftsLoaded) _then;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shifts = null,
    Object? activeShiftId = freezed,
  }) {
    return _then(_ShiftsLoaded(
      null == shifts
          ? _self._shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<DailyCashModel>,
      activeShiftId: freezed == activeShiftId
          ? _self.activeShiftId
          : activeShiftId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
