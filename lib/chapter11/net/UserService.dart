import '../entiy/ApiResponse.dart';
import '../entiy/User.dart';
import 'HttpUtil.dart';

class UserService {
  final HttpUtil _http = HttpUtil();

  Future<ApiResponse<User>> fetchUser(int userId) {
    return _http.get<User>(
      '/users/$userId',
      fromJsonT: (json) => User.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<String>> createUser(Map<String, dynamic> userData) {
    return _http.post<String>(
      '/users',
      data: userData,
      fromJsonT: (json) => json as String, // 假设服务器返回一个字符串
    );
  }
}
