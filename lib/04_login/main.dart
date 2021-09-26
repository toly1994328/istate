import 'authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'app.dart';
import 'user_repository/user_repository.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
