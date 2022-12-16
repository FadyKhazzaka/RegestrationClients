import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<String?> register(String phoneNumber) async {
    final request = await http.post(
        Uri.https("fixit-api.abiroot.dev", "/api/auth/register"),
        headers: {'Accept': 'application/json'},
        body: {'phone_number': phoneNumber});
    var requestJson = await json.decode(request.body)['meta'];
    String bearerToken = requestJson['access_token'];
    return bearerToken;
  }

//------------------------------------------------------------------------------

  Future<bool> verify(String receivedCode, String token) async {
    final response = await http.post(
      Uri.parse(
        'https://fixit-api.abiroot.dev/api/auth/mobile/verify?token=$receivedCode',
      ),
      headers: {'Accept': 'application/json', 'Authorization': "Bearer $token"},
    );
    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  }
}
