import 'dart:convert';

class Registration {
  final bool? success;
  final String? message;
  final String? errorMsg;
  final bool? isError;

  Registration({
    this.success,
    this.message,
    this.errorMsg,
    this.isError,
  });

  factory Registration.fromRawJson(String str) => Registration.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
