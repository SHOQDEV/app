
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future loginCustomer( response, String email, String password) async {
    await storage.write( key: 'accessToken', value: response.data['token']);

    await storage.write( key: 'email', value: email);
    await storage.write( key: 'password', value: password);
    return;
  }

  Future registerPassword( String password ) async {
    await storage.write( key: 'password', value: password);
    return;
  }

  Future logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    return;
  }

  Future<String> readAccessToken() async {
    return await storage.read(key: 'accessToken') ?? '';
  }

  Future<String> readCredentialNit() async {
    return await storage.read(key: 'nit') ?? '';
  }
  Future<String> readCredentialUser() async {
    return await storage.read(key: 'email') ?? '';
  }
  Future<String> readCredentialPassword() async {
    return await storage.read(key: 'password') ?? '';
  }
}
