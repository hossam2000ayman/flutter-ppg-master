// ignore_for_file: file_names

class PasswordException implements Exception {
  final String msg;
  const PasswordException(this.msg);

  @override
  String toString() => 'password Exception $msg';
}
