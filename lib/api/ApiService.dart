import 'package:dio/dio.dart';

import 'package:kaar/controller/login/dataclass/User.dart';

class ApiService {

  Future<Map<String, dynamic>?> login(String number, String password) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        'https://codecoyapps.com/karr/api/login',
        queryParameters: {
          'number': number,
          'password': password,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final status = responseData['status'] as bool;
        final message = responseData['message'] as String;

        if (status) {
          final userJson = responseData['user'] as Map<String, dynamic>;
          final user = User.fromJson(userJson);
          print('Login successful: $message');
          return {
            'status': status,
            'message': message,
            'user': user,
          };
        } else {
          // Handle the case where login failed
          print('Login failed: $message');
          return {
            'status': status,
            'message': message,
          };
        }
      } else {
        // Handle error status codes (e.g., show an error message)
        print('API request failed with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('API request error: $e');
      return null;
    }
  }
}