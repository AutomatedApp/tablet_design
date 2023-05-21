

import 'package:ssh2/ssh2.dart';

class SshHelper {
  final String host;
  final String username;
  final String password;

  SshHelper({required this.host, required this.username, required this.password});

  Future<SSHClient> connect() async {
    final client = SSHClient(
      host: host,
      port: 22,
      username: username,
      passwordOrKey: password,
    );
    await client.connect();
    return client;
  }
}