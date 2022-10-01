// ignore_for_file: file_names

class ServerException implements Exception {
  final String msg;
  const ServerException(this.msg);

  @override
  String toString() => 'Api server Exception $msg';
}
