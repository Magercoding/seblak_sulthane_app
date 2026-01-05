// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MemberEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MemberEvent()';
  }
}

/// @nodoc
class $MemberEventCopyWith<$Res> {
  $MemberEventCopyWith(MemberEvent _, $Res Function(MemberEvent) __);
}

/// Adds pattern-matching-related methods to [MemberEvent].
extension MemberEventPatterns on MemberEvent {
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
    TResult Function(_GetMembers value)? getMembers,
    TResult Function(_SearchMembers value)? searchMembers,
    TResult Function(_GetMemberByPhone value)? getMemberByPhone,
    TResult Function(_AddMember value)? addMember,
    TResult Function(_UpdateMember value)? updateMember,
    TResult Function(_DeleteMember value)? deleteMember,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetMembers() when getMembers != null:
        return getMembers(_that);
      case _SearchMembers() when searchMembers != null:
        return searchMembers(_that);
      case _GetMemberByPhone() when getMemberByPhone != null:
        return getMemberByPhone(_that);
      case _AddMember() when addMember != null:
        return addMember(_that);
      case _UpdateMember() when updateMember != null:
        return updateMember(_that);
      case _DeleteMember() when deleteMember != null:
        return deleteMember(_that);
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
    required TResult Function(_GetMembers value) getMembers,
    required TResult Function(_SearchMembers value) searchMembers,
    required TResult Function(_GetMemberByPhone value) getMemberByPhone,
    required TResult Function(_AddMember value) addMember,
    required TResult Function(_UpdateMember value) updateMember,
    required TResult Function(_DeleteMember value) deleteMember,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started(_that);
      case _GetMembers():
        return getMembers(_that);
      case _SearchMembers():
        return searchMembers(_that);
      case _GetMemberByPhone():
        return getMemberByPhone(_that);
      case _AddMember():
        return addMember(_that);
      case _UpdateMember():
        return updateMember(_that);
      case _DeleteMember():
        return deleteMember(_that);
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
    TResult? Function(_GetMembers value)? getMembers,
    TResult? Function(_SearchMembers value)? searchMembers,
    TResult? Function(_GetMemberByPhone value)? getMemberByPhone,
    TResult? Function(_AddMember value)? addMember,
    TResult? Function(_UpdateMember value)? updateMember,
    TResult? Function(_DeleteMember value)? deleteMember,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started(_that);
      case _GetMembers() when getMembers != null:
        return getMembers(_that);
      case _SearchMembers() when searchMembers != null:
        return searchMembers(_that);
      case _GetMemberByPhone() when getMemberByPhone != null:
        return getMemberByPhone(_that);
      case _AddMember() when addMember != null:
        return addMember(_that);
      case _UpdateMember() when updateMember != null:
        return updateMember(_that);
      case _DeleteMember() when deleteMember != null:
        return deleteMember(_that);
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
    TResult Function()? getMembers,
    TResult Function(String query)? searchMembers,
    TResult Function(String phone)? getMemberByPhone,
    TResult Function(String name, String phone)? addMember,
    TResult Function(int id, String name, String phone)? updateMember,
    TResult Function(int id)? deleteMember,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetMembers() when getMembers != null:
        return getMembers();
      case _SearchMembers() when searchMembers != null:
        return searchMembers(_that.query);
      case _GetMemberByPhone() when getMemberByPhone != null:
        return getMemberByPhone(_that.phone);
      case _AddMember() when addMember != null:
        return addMember(_that.name, _that.phone);
      case _UpdateMember() when updateMember != null:
        return updateMember(_that.id, _that.name, _that.phone);
      case _DeleteMember() when deleteMember != null:
        return deleteMember(_that.id);
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
    required TResult Function() getMembers,
    required TResult Function(String query) searchMembers,
    required TResult Function(String phone) getMemberByPhone,
    required TResult Function(String name, String phone) addMember,
    required TResult Function(int id, String name, String phone) updateMember,
    required TResult Function(int id) deleteMember,
  }) {
    final _that = this;
    switch (_that) {
      case _Started():
        return started();
      case _GetMembers():
        return getMembers();
      case _SearchMembers():
        return searchMembers(_that.query);
      case _GetMemberByPhone():
        return getMemberByPhone(_that.phone);
      case _AddMember():
        return addMember(_that.name, _that.phone);
      case _UpdateMember():
        return updateMember(_that.id, _that.name, _that.phone);
      case _DeleteMember():
        return deleteMember(_that.id);
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
    TResult? Function()? getMembers,
    TResult? Function(String query)? searchMembers,
    TResult? Function(String phone)? getMemberByPhone,
    TResult? Function(String name, String phone)? addMember,
    TResult? Function(int id, String name, String phone)? updateMember,
    TResult? Function(int id)? deleteMember,
  }) {
    final _that = this;
    switch (_that) {
      case _Started() when started != null:
        return started();
      case _GetMembers() when getMembers != null:
        return getMembers();
      case _SearchMembers() when searchMembers != null:
        return searchMembers(_that.query);
      case _GetMemberByPhone() when getMemberByPhone != null:
        return getMemberByPhone(_that.phone);
      case _AddMember() when addMember != null:
        return addMember(_that.name, _that.phone);
      case _UpdateMember() when updateMember != null:
        return updateMember(_that.id, _that.name, _that.phone);
      case _DeleteMember() when deleteMember != null:
        return deleteMember(_that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Started implements MemberEvent {
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
    return 'MemberEvent.started()';
  }
}

/// @nodoc

class _GetMembers implements MemberEvent {
  const _GetMembers();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetMembers);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MemberEvent.getMembers()';
  }
}

/// @nodoc

class _SearchMembers implements MemberEvent {
  const _SearchMembers(this.query);

  final String query;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchMembersCopyWith<_SearchMembers> get copyWith =>
      __$SearchMembersCopyWithImpl<_SearchMembers>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchMembers &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'MemberEvent.searchMembers(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$SearchMembersCopyWith<$Res>
    implements $MemberEventCopyWith<$Res> {
  factory _$SearchMembersCopyWith(
          _SearchMembers value, $Res Function(_SearchMembers) _then) =
      __$SearchMembersCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$SearchMembersCopyWithImpl<$Res>
    implements _$SearchMembersCopyWith<$Res> {
  __$SearchMembersCopyWithImpl(this._self, this._then);

  final _SearchMembers _self;
  final $Res Function(_SearchMembers) _then;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_SearchMembers(
      null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _GetMemberByPhone implements MemberEvent {
  const _GetMemberByPhone(this.phone);

  final String phone;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetMemberByPhoneCopyWith<_GetMemberByPhone> get copyWith =>
      __$GetMemberByPhoneCopyWithImpl<_GetMemberByPhone>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetMemberByPhone &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @override
  String toString() {
    return 'MemberEvent.getMemberByPhone(phone: $phone)';
  }
}

/// @nodoc
abstract mixin class _$GetMemberByPhoneCopyWith<$Res>
    implements $MemberEventCopyWith<$Res> {
  factory _$GetMemberByPhoneCopyWith(
          _GetMemberByPhone value, $Res Function(_GetMemberByPhone) _then) =
      __$GetMemberByPhoneCopyWithImpl;
  @useResult
  $Res call({String phone});
}

/// @nodoc
class __$GetMemberByPhoneCopyWithImpl<$Res>
    implements _$GetMemberByPhoneCopyWith<$Res> {
  __$GetMemberByPhoneCopyWithImpl(this._self, this._then);

  final _GetMemberByPhone _self;
  final $Res Function(_GetMemberByPhone) _then;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phone = null,
  }) {
    return _then(_GetMemberByPhone(
      null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _AddMember implements MemberEvent {
  const _AddMember({required this.name, required this.phone});

  final String name;
  final String phone;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddMemberCopyWith<_AddMember> get copyWith =>
      __$AddMemberCopyWithImpl<_AddMember>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddMember &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, phone);

  @override
  String toString() {
    return 'MemberEvent.addMember(name: $name, phone: $phone)';
  }
}

/// @nodoc
abstract mixin class _$AddMemberCopyWith<$Res>
    implements $MemberEventCopyWith<$Res> {
  factory _$AddMemberCopyWith(
          _AddMember value, $Res Function(_AddMember) _then) =
      __$AddMemberCopyWithImpl;
  @useResult
  $Res call({String name, String phone});
}

/// @nodoc
class __$AddMemberCopyWithImpl<$Res> implements _$AddMemberCopyWith<$Res> {
  __$AddMemberCopyWithImpl(this._self, this._then);

  final _AddMember _self;
  final $Res Function(_AddMember) _then;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? phone = null,
  }) {
    return _then(_AddMember(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _UpdateMember implements MemberEvent {
  const _UpdateMember(
      {required this.id, required this.name, required this.phone});

  final int id;
  final String name;
  final String phone;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateMemberCopyWith<_UpdateMember> get copyWith =>
      __$UpdateMemberCopyWithImpl<_UpdateMember>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone);

  @override
  String toString() {
    return 'MemberEvent.updateMember(id: $id, name: $name, phone: $phone)';
  }
}

/// @nodoc
abstract mixin class _$UpdateMemberCopyWith<$Res>
    implements $MemberEventCopyWith<$Res> {
  factory _$UpdateMemberCopyWith(
          _UpdateMember value, $Res Function(_UpdateMember) _then) =
      __$UpdateMemberCopyWithImpl;
  @useResult
  $Res call({int id, String name, String phone});
}

/// @nodoc
class __$UpdateMemberCopyWithImpl<$Res>
    implements _$UpdateMemberCopyWith<$Res> {
  __$UpdateMemberCopyWithImpl(this._self, this._then);

  final _UpdateMember _self;
  final $Res Function(_UpdateMember) _then;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
  }) {
    return _then(_UpdateMember(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _DeleteMember implements MemberEvent {
  const _DeleteMember(this.id);

  final int id;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteMemberCopyWith<_DeleteMember> get copyWith =>
      __$DeleteMemberCopyWithImpl<_DeleteMember>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeleteMember &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'MemberEvent.deleteMember(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$DeleteMemberCopyWith<$Res>
    implements $MemberEventCopyWith<$Res> {
  factory _$DeleteMemberCopyWith(
          _DeleteMember value, $Res Function(_DeleteMember) _then) =
      __$DeleteMemberCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$DeleteMemberCopyWithImpl<$Res>
    implements _$DeleteMemberCopyWith<$Res> {
  __$DeleteMemberCopyWithImpl(this._self, this._then);

  final _DeleteMember _self;
  final $Res Function(_DeleteMember) _then;

  /// Create a copy of MemberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_DeleteMember(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$MemberState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MemberState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MemberState()';
  }
}

/// @nodoc
class $MemberStateCopyWith<$Res> {
  $MemberStateCopyWith(MemberState _, $Res Function(MemberState) __);
}

/// Adds pattern-matching-related methods to [MemberState].
extension MemberStatePatterns on MemberState {
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
    TResult Function(List<Member> members)? loaded,
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
        return loaded(_that.members);
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
    required TResult Function(List<Member> members) loaded,
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
        return loaded(_that.members);
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
    TResult? Function(List<Member> members)? loaded,
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
        return loaded(_that.members);
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

class _Initial implements MemberState {
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
    return 'MemberState.initial()';
  }
}

/// @nodoc

class _Loading implements MemberState {
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
    return 'MemberState.loading()';
  }
}

/// @nodoc

class _Loaded implements MemberState {
  const _Loaded(final List<Member> members) : _members = members;

  final List<Member> _members;
  List<Member> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Create a copy of MemberState
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
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_members));

  @override
  String toString() {
    return 'MemberState.loaded(members: $members)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $MemberStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({List<Member> members});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of MemberState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? members = null,
  }) {
    return _then(_Loaded(
      null == members
          ? _self._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
    ));
  }
}

/// @nodoc

class _Error implements MemberState {
  const _Error(this.message);

  final String message;

  /// Create a copy of MemberState
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
    return 'MemberState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $MemberStateCopyWith<$Res> {
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

  /// Create a copy of MemberState
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

class _Success implements MemberState {
  const _Success(this.message);

  final String message;

  /// Create a copy of MemberState
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
    return 'MemberState.success(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res>
    implements $MemberStateCopyWith<$Res> {
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

  /// Create a copy of MemberState
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
