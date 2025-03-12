// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_cash_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyCashEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String date) fetchDailyCash,
    required TResult Function(String date, int openingBalance)
        setOpeningBalance,
    required TResult Function(String date, int amount, String note) addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String date)? fetchDailyCash,
    TResult? Function(String date, int openingBalance)? setOpeningBalance,
    TResult? Function(String date, int amount, String note)? addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String date)? fetchDailyCash,
    TResult Function(String date, int openingBalance)? setOpeningBalance,
    TResult Function(String date, int amount, String note)? addExpense,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchDailyCash value) fetchDailyCash,
    required TResult Function(_SetOpeningBalance value) setOpeningBalance,
    required TResult Function(_AddExpense value) addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchDailyCash value)? fetchDailyCash,
    TResult? Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult? Function(_AddExpense value)? addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchDailyCash value)? fetchDailyCash,
    TResult Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyCashEventCopyWith<$Res> {
  factory $DailyCashEventCopyWith(
          DailyCashEvent value, $Res Function(DailyCashEvent) then) =
      _$DailyCashEventCopyWithImpl<$Res, DailyCashEvent>;
}

/// @nodoc
class _$DailyCashEventCopyWithImpl<$Res, $Val extends DailyCashEvent>
    implements $DailyCashEventCopyWith<$Res> {
  _$DailyCashEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyCashEvent
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
    extends _$DailyCashEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'DailyCashEvent.started()';
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
    required TResult Function(String date) fetchDailyCash,
    required TResult Function(String date, int openingBalance)
        setOpeningBalance,
    required TResult Function(String date, int amount, String note) addExpense,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String date)? fetchDailyCash,
    TResult? Function(String date, int openingBalance)? setOpeningBalance,
    TResult? Function(String date, int amount, String note)? addExpense,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String date)? fetchDailyCash,
    TResult Function(String date, int openingBalance)? setOpeningBalance,
    TResult Function(String date, int amount, String note)? addExpense,
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
    required TResult Function(_FetchDailyCash value) fetchDailyCash,
    required TResult Function(_SetOpeningBalance value) setOpeningBalance,
    required TResult Function(_AddExpense value) addExpense,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchDailyCash value)? fetchDailyCash,
    TResult? Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult? Function(_AddExpense value)? addExpense,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchDailyCash value)? fetchDailyCash,
    TResult Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements DailyCashEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$FetchDailyCashImplCopyWith<$Res> {
  factory _$$FetchDailyCashImplCopyWith(_$FetchDailyCashImpl value,
          $Res Function(_$FetchDailyCashImpl) then) =
      __$$FetchDailyCashImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date});
}

/// @nodoc
class __$$FetchDailyCashImplCopyWithImpl<$Res>
    extends _$DailyCashEventCopyWithImpl<$Res, _$FetchDailyCashImpl>
    implements _$$FetchDailyCashImplCopyWith<$Res> {
  __$$FetchDailyCashImplCopyWithImpl(
      _$FetchDailyCashImpl _value, $Res Function(_$FetchDailyCashImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
  }) {
    return _then(_$FetchDailyCashImpl(
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchDailyCashImpl implements _FetchDailyCash {
  const _$FetchDailyCashImpl(this.date);

  @override
  final String date;

  @override
  String toString() {
    return 'DailyCashEvent.fetchDailyCash(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchDailyCashImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchDailyCashImplCopyWith<_$FetchDailyCashImpl> get copyWith =>
      __$$FetchDailyCashImplCopyWithImpl<_$FetchDailyCashImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String date) fetchDailyCash,
    required TResult Function(String date, int openingBalance)
        setOpeningBalance,
    required TResult Function(String date, int amount, String note) addExpense,
  }) {
    return fetchDailyCash(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String date)? fetchDailyCash,
    TResult? Function(String date, int openingBalance)? setOpeningBalance,
    TResult? Function(String date, int amount, String note)? addExpense,
  }) {
    return fetchDailyCash?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String date)? fetchDailyCash,
    TResult Function(String date, int openingBalance)? setOpeningBalance,
    TResult Function(String date, int amount, String note)? addExpense,
    required TResult orElse(),
  }) {
    if (fetchDailyCash != null) {
      return fetchDailyCash(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchDailyCash value) fetchDailyCash,
    required TResult Function(_SetOpeningBalance value) setOpeningBalance,
    required TResult Function(_AddExpense value) addExpense,
  }) {
    return fetchDailyCash(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchDailyCash value)? fetchDailyCash,
    TResult? Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult? Function(_AddExpense value)? addExpense,
  }) {
    return fetchDailyCash?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchDailyCash value)? fetchDailyCash,
    TResult Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) {
    if (fetchDailyCash != null) {
      return fetchDailyCash(this);
    }
    return orElse();
  }
}

abstract class _FetchDailyCash implements DailyCashEvent {
  const factory _FetchDailyCash(final String date) = _$FetchDailyCashImpl;

  String get date;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchDailyCashImplCopyWith<_$FetchDailyCashImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetOpeningBalanceImplCopyWith<$Res> {
  factory _$$SetOpeningBalanceImplCopyWith(_$SetOpeningBalanceImpl value,
          $Res Function(_$SetOpeningBalanceImpl) then) =
      __$$SetOpeningBalanceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date, int openingBalance});
}

/// @nodoc
class __$$SetOpeningBalanceImplCopyWithImpl<$Res>
    extends _$DailyCashEventCopyWithImpl<$Res, _$SetOpeningBalanceImpl>
    implements _$$SetOpeningBalanceImplCopyWith<$Res> {
  __$$SetOpeningBalanceImplCopyWithImpl(_$SetOpeningBalanceImpl _value,
      $Res Function(_$SetOpeningBalanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? openingBalance = null,
  }) {
    return _then(_$SetOpeningBalanceImpl(
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SetOpeningBalanceImpl implements _SetOpeningBalance {
  const _$SetOpeningBalanceImpl(this.date, this.openingBalance);

  @override
  final String date;
  @override
  final int openingBalance;

  @override
  String toString() {
    return 'DailyCashEvent.setOpeningBalance(date: $date, openingBalance: $openingBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetOpeningBalanceImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, openingBalance);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetOpeningBalanceImplCopyWith<_$SetOpeningBalanceImpl> get copyWith =>
      __$$SetOpeningBalanceImplCopyWithImpl<_$SetOpeningBalanceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String date) fetchDailyCash,
    required TResult Function(String date, int openingBalance)
        setOpeningBalance,
    required TResult Function(String date, int amount, String note) addExpense,
  }) {
    return setOpeningBalance(date, openingBalance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String date)? fetchDailyCash,
    TResult? Function(String date, int openingBalance)? setOpeningBalance,
    TResult? Function(String date, int amount, String note)? addExpense,
  }) {
    return setOpeningBalance?.call(date, openingBalance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String date)? fetchDailyCash,
    TResult Function(String date, int openingBalance)? setOpeningBalance,
    TResult Function(String date, int amount, String note)? addExpense,
    required TResult orElse(),
  }) {
    if (setOpeningBalance != null) {
      return setOpeningBalance(date, openingBalance);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchDailyCash value) fetchDailyCash,
    required TResult Function(_SetOpeningBalance value) setOpeningBalance,
    required TResult Function(_AddExpense value) addExpense,
  }) {
    return setOpeningBalance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchDailyCash value)? fetchDailyCash,
    TResult? Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult? Function(_AddExpense value)? addExpense,
  }) {
    return setOpeningBalance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchDailyCash value)? fetchDailyCash,
    TResult Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) {
    if (setOpeningBalance != null) {
      return setOpeningBalance(this);
    }
    return orElse();
  }
}

abstract class _SetOpeningBalance implements DailyCashEvent {
  const factory _SetOpeningBalance(
      final String date, final int openingBalance) = _$SetOpeningBalanceImpl;

  String get date;
  int get openingBalance;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetOpeningBalanceImplCopyWith<_$SetOpeningBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddExpenseImplCopyWith<$Res> {
  factory _$$AddExpenseImplCopyWith(
          _$AddExpenseImpl value, $Res Function(_$AddExpenseImpl) then) =
      __$$AddExpenseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date, int amount, String note});
}

/// @nodoc
class __$$AddExpenseImplCopyWithImpl<$Res>
    extends _$DailyCashEventCopyWithImpl<$Res, _$AddExpenseImpl>
    implements _$$AddExpenseImplCopyWith<$Res> {
  __$$AddExpenseImplCopyWithImpl(
      _$AddExpenseImpl _value, $Res Function(_$AddExpenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
    Object? note = null,
  }) {
    return _then(_$AddExpenseImpl(
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddExpenseImpl implements _AddExpense {
  const _$AddExpenseImpl(this.date, this.amount, this.note);

  @override
  final String date;
  @override
  final int amount;
  @override
  final String note;

  @override
  String toString() {
    return 'DailyCashEvent.addExpense(date: $date, amount: $amount, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddExpenseImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, amount, note);

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddExpenseImplCopyWith<_$AddExpenseImpl> get copyWith =>
      __$$AddExpenseImplCopyWithImpl<_$AddExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String date) fetchDailyCash,
    required TResult Function(String date, int openingBalance)
        setOpeningBalance,
    required TResult Function(String date, int amount, String note) addExpense,
  }) {
    return addExpense(date, amount, note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String date)? fetchDailyCash,
    TResult? Function(String date, int openingBalance)? setOpeningBalance,
    TResult? Function(String date, int amount, String note)? addExpense,
  }) {
    return addExpense?.call(date, amount, note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String date)? fetchDailyCash,
    TResult Function(String date, int openingBalance)? setOpeningBalance,
    TResult Function(String date, int amount, String note)? addExpense,
    required TResult orElse(),
  }) {
    if (addExpense != null) {
      return addExpense(date, amount, note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FetchDailyCash value) fetchDailyCash,
    required TResult Function(_SetOpeningBalance value) setOpeningBalance,
    required TResult Function(_AddExpense value) addExpense,
  }) {
    return addExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FetchDailyCash value)? fetchDailyCash,
    TResult? Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult? Function(_AddExpense value)? addExpense,
  }) {
    return addExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FetchDailyCash value)? fetchDailyCash,
    TResult Function(_SetOpeningBalance value)? setOpeningBalance,
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) {
    if (addExpense != null) {
      return addExpense(this);
    }
    return orElse();
  }
}

abstract class _AddExpense implements DailyCashEvent {
  const factory _AddExpense(
          final String date, final int amount, final String note) =
      _$AddExpenseImpl;

  String get date;
  int get amount;
  String get note;

  /// Create a copy of DailyCashEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddExpenseImplCopyWith<_$AddExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyCashState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyCashStateCopyWith<$Res> {
  factory $DailyCashStateCopyWith(
          DailyCashState value, $Res Function(DailyCashState) then) =
      _$DailyCashStateCopyWithImpl<$Res, DailyCashState>;
}

/// @nodoc
class _$DailyCashStateCopyWithImpl<$Res, $Val extends DailyCashState>
    implements $DailyCashStateCopyWith<$Res> {
  _$DailyCashStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyCashState
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
    extends _$DailyCashStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'DailyCashState.initial()';
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
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
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
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements DailyCashState {
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
    extends _$DailyCashStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'DailyCashState.loading()';
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
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
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
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements DailyCashState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$DailyCashStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_$LoadedImpl(
      null == dailyCash
          ? _value.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.dailyCash);

  @override
  final DailyCashModel dailyCash;

  @override
  String toString() {
    return 'DailyCashState.loaded(dailyCash: $dailyCash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  /// Create a copy of DailyCashState
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
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) {
    return loaded(dailyCash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) {
    return loaded?.call(dailyCash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(dailyCash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements DailyCashState {
  const factory _Loaded(final DailyCashModel dailyCash) = _$LoadedImpl;

  DailyCashModel get dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$DailyCashStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashState
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
    return 'DailyCashState.error(message: $message)';
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

  /// Create a copy of DailyCashState
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
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
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
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DailyCashState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpeningBalanceSetImplCopyWith<$Res> {
  factory _$$OpeningBalanceSetImplCopyWith(_$OpeningBalanceSetImpl value,
          $Res Function(_$OpeningBalanceSetImpl) then) =
      __$$OpeningBalanceSetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$$OpeningBalanceSetImplCopyWithImpl<$Res>
    extends _$DailyCashStateCopyWithImpl<$Res, _$OpeningBalanceSetImpl>
    implements _$$OpeningBalanceSetImplCopyWith<$Res> {
  __$$OpeningBalanceSetImplCopyWithImpl(_$OpeningBalanceSetImpl _value,
      $Res Function(_$OpeningBalanceSetImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_$OpeningBalanceSetImpl(
      null == dailyCash
          ? _value.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _$OpeningBalanceSetImpl implements _OpeningBalanceSet {
  const _$OpeningBalanceSetImpl(this.dailyCash);

  @override
  final DailyCashModel dailyCash;

  @override
  String toString() {
    return 'DailyCashState.openingBalanceSet(dailyCash: $dailyCash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpeningBalanceSetImpl &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpeningBalanceSetImplCopyWith<_$OpeningBalanceSetImpl> get copyWith =>
      __$$OpeningBalanceSetImplCopyWithImpl<_$OpeningBalanceSetImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) {
    return openingBalanceSet(dailyCash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) {
    return openingBalanceSet?.call(dailyCash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
    required TResult orElse(),
  }) {
    if (openingBalanceSet != null) {
      return openingBalanceSet(dailyCash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) {
    return openingBalanceSet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) {
    return openingBalanceSet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) {
    if (openingBalanceSet != null) {
      return openingBalanceSet(this);
    }
    return orElse();
  }
}

abstract class _OpeningBalanceSet implements DailyCashState {
  const factory _OpeningBalanceSet(final DailyCashModel dailyCash) =
      _$OpeningBalanceSetImpl;

  DailyCashModel get dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpeningBalanceSetImplCopyWith<_$OpeningBalanceSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExpenseAddedImplCopyWith<$Res> {
  factory _$$ExpenseAddedImplCopyWith(
          _$ExpenseAddedImpl value, $Res Function(_$ExpenseAddedImpl) then) =
      __$$ExpenseAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DailyCashModel dailyCash});
}

/// @nodoc
class __$$ExpenseAddedImplCopyWithImpl<$Res>
    extends _$DailyCashStateCopyWithImpl<$Res, _$ExpenseAddedImpl>
    implements _$$ExpenseAddedImplCopyWith<$Res> {
  __$$ExpenseAddedImplCopyWithImpl(
      _$ExpenseAddedImpl _value, $Res Function(_$ExpenseAddedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyCash = null,
  }) {
    return _then(_$ExpenseAddedImpl(
      null == dailyCash
          ? _value.dailyCash
          : dailyCash // ignore: cast_nullable_to_non_nullable
              as DailyCashModel,
    ));
  }
}

/// @nodoc

class _$ExpenseAddedImpl implements _ExpenseAdded {
  const _$ExpenseAddedImpl(this.dailyCash);

  @override
  final DailyCashModel dailyCash;

  @override
  String toString() {
    return 'DailyCashState.expenseAdded(dailyCash: $dailyCash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseAddedImpl &&
            (identical(other.dailyCash, dailyCash) ||
                other.dailyCash == dailyCash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyCash);

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseAddedImplCopyWith<_$ExpenseAddedImpl> get copyWith =>
      __$$ExpenseAddedImplCopyWithImpl<_$ExpenseAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailyCashModel dailyCash) loaded,
    required TResult Function(String message) error,
    required TResult Function(DailyCashModel dailyCash) openingBalanceSet,
    required TResult Function(DailyCashModel dailyCash) expenseAdded,
  }) {
    return expenseAdded(dailyCash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailyCashModel dailyCash)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult? Function(DailyCashModel dailyCash)? expenseAdded,
  }) {
    return expenseAdded?.call(dailyCash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailyCashModel dailyCash)? loaded,
    TResult Function(String message)? error,
    TResult Function(DailyCashModel dailyCash)? openingBalanceSet,
    TResult Function(DailyCashModel dailyCash)? expenseAdded,
    required TResult orElse(),
  }) {
    if (expenseAdded != null) {
      return expenseAdded(dailyCash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OpeningBalanceSet value) openingBalanceSet,
    required TResult Function(_ExpenseAdded value) expenseAdded,
  }) {
    return expenseAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult? Function(_ExpenseAdded value)? expenseAdded,
  }) {
    return expenseAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OpeningBalanceSet value)? openingBalanceSet,
    TResult Function(_ExpenseAdded value)? expenseAdded,
    required TResult orElse(),
  }) {
    if (expenseAdded != null) {
      return expenseAdded(this);
    }
    return orElse();
  }
}

abstract class _ExpenseAdded implements DailyCashState {
  const factory _ExpenseAdded(final DailyCashModel dailyCash) =
      _$ExpenseAddedImpl;

  DailyCashModel get dailyCash;

  /// Create a copy of DailyCashState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseAddedImplCopyWith<_$ExpenseAddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
