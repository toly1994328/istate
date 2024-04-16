class GithubUser {
  const GithubUser({
    required this.login,
    required this.avatarUrl,
  });

  final String login;
  final String avatarUrl;

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }
}
