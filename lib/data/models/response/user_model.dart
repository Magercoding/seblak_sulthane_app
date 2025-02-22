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
      emailVerifiedAt: json['email_verified_at'] as String?, // Nullable
      twoFactorSecret: json['two_factor_secret'] as String?, // Nullable
      twoFactorRecoveryCodes:
          json['two_factor_recovery_codes'] as String?, // Nullable
      twoFactorConfirmedAt:
          json['two_factor_confirmed_at'] as String?, // Nullable
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      role: json['role'] as String,
      outletId: json['outlet_id'] as int,
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
}
