import 'package:bcrypt/bcrypt.dart';

void main() {
  const password = "my_secure_password";

  final hash = BCrypt.hashpw(
    password,
    BCrypt.gensalt(),
  );

  print(hash);

  print(BCrypt.checkpw(password, hash));
}