import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  static Future<String> getServerKeyToken() async {
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        // Add Generate new private key
      }),
      scopes,
    );

    final accessServerKey = client.credentials.accessToken.data;
    print("\n${accessServerKey}\n");
    return accessServerKey;
  }
}
