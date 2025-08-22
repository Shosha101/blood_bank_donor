class LoginResponse {
  final String? message;
  final int? userId;
  final String? token;

  const LoginResponse({
    this.message,
    this.userId,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    print('Deserializing LoginResponse: $json');
    return LoginResponse(
      message: json['message'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'token': token,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginResponse &&
        other.message == message &&
        other.userId == userId &&
        other.token == token;
  }

  @override
  int get hashCode => Object.hash(message, userId, token);

  @override
  String toString() {
    return 'LoginResponse(message: $message, userId: $userId)';
  }

  LoginResponse copyWith({
    String? message,
    int? userId,
    String? token,
  }) {
    return LoginResponse(
      message: message ?? this.message,
      userId: userId ?? this.userId,
      token: token ?? this.token,
    );
  }
}