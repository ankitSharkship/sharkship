class LoginResponse {
  final String? tokenType;
  final String? accessToken;
  final String? user;
  final String? membership;
  final String? userId;
  final String? subUserId;
  final String? refreshToken;
  final String? expiresIn;
  final String? refreshExpiresIn;
  final List<String>? scope;
  final String? role;

  const LoginResponse({
    this.tokenType,
    this.accessToken,
    this.user,
    this.membership,
    this.userId,
    this.subUserId,
    this.refreshToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.scope,
    this.role,
  });
}
