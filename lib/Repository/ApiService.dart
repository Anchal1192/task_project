// post_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/PostDataModel.dart';


class PostRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
