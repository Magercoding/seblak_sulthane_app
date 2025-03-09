class UserModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? twoFactorSecret;
  final String? twoFactorRecoveryCodes;
  final String? twoFactorConfirmedAt;
  final String createdAt;
  final String updatedAt;
  final String role;
  final int outletId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.outletId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      twoFactorSecret: json['two_factor_secret'] as String?,
      twoFactorRecoveryCodes: json['two_factor_recovery_codes'] as String?,
      twoFactorConfirmedAt: json['two_factor_confirmed_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      role: json['role'] as String,
      outletId: json['outlet_id'] as int,
    );
  }

  // Add fromMap method that takes a Map<String, dynamic>
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      emailVerifiedAt: map['email_verified_at'] as String?,
      twoFactorSecret: map['two_factor_secret'] as String?,
      twoFactorRecoveryCodes: map['two_factor_recovery_codes'] as String?,
      twoFactorConfirmedAt: map['two_factor_confirmed_at'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      role: map['role'] as String,
      outletId: map['outlet_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'two_factor_secret': twoFactorSecret,
      'two_factor_recovery_codes': twoFactorRecoveryCodes,
      'two_factor_confirmed_at': twoFactorConfirmedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role,
      'outlet_id': outletId,
    };
  }

  // Add toMap method for consistency
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'two_factor_secret': twoFactorSecret,
      'two_factor_recovery_codes': twoFactorRecoveryCodes,
      'two_factor_confirmed_at': twoFactorConfirmedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role,
      'outlet_id': outletId,
    };
  }
}
