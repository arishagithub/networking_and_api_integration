// lib/post_provider.dart
import 'package:flutter/material.dart';
import 'post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        _posts = jsonResponse.map((data) => Post.fromJson(data)).toList();
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to load posts';
      }
    } catch (e) {
      _errorMessage = 'Failed to load posts';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
