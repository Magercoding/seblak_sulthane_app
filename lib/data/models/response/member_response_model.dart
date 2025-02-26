import 'dart:convert';

class MemberResponseModel {
  final String status;
  final List<Member> data;

  MemberResponseModel({
    required this.status,
    required this.data,
  });

  factory MemberResponseModel.fromRawJson(String str) =>
      MemberResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemberResponseModel.fromJson(Map<String, dynamic> json) {
    var rawData = json["data"];
    List<Member> memberList = [];

    if (rawData != null) {
      if (rawData is List) {
        memberList = rawData.map((x) => Member.fromJson(x)).toList();
      } else if (rawData is Map<String, dynamic>) {
        memberList = [Member.fromJson(rawData)];
      }
    }

    return MemberResponseModel(
      status: json["status"] ?? "error",
      data: memberList,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Member {
  final int id;
  final String name;
  final String phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Member({
    required this.id,
    required this.name,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
