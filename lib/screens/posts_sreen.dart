import 'package:flutter/material.dart';
import '../services/api_services.dart'; // Импортируем сервис для API

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<dynamic> _data = [];
  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final posts = await ApiService.fetchPosts();
      setState(() {
        _data = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error, size: 50, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        'Нет данных для отображения',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_data[index]['title']),
                      subtitle: Text(_data[index]['body']),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        tooltip: 'Получить посты',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
