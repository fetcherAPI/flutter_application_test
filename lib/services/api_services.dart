import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<List<dynamic>> fetchPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      return response.data;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }
}
