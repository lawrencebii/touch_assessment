import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  String occupation;
  String bio;
  int v;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.occupation,
    required this.bio,
    required this.v,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? occupation,
    String? bio,
    int? v,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        occupation: occupation ?? this.occupation,
        bio: bio ?? this.bio,
        v: v ?? this.v,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        occupation: json["occupation"],
        bio: json["bio"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "occupation": occupation,
        "bio": bio,
        "__v": v,
      };
}
