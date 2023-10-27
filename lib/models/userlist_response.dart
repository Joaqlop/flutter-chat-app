import 'dart:convert';

import 'package:chat_app/models/models.dart';

UserListResponse userListResponseFromJson(String str) =>
    UserListResponse.fromJson(json.decode(str));

String userListResponseToJson(UserListResponse data) =>
    json.encode(data.toJson());

class UserListResponse {
  bool ok;
  List<User> userList;

  UserListResponse({
    required this.ok,
    required this.userList,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      UserListResponse(
        ok: json["ok"],
        userList:
            List<User>.from(json["userList"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
      };
}
