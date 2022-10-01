// ignore_for_file: file_names

class EmailException implements Exception {
  final String msg;
  const EmailException(this.msg);

  @override
  toString() => 'Invalid Email Exception: $msg';
}
