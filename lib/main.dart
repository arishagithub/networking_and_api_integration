// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          } else {
            return ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.posts[index].title),
                  subtitle: Text(provider.posts[index].body),
                );
              },
            );
          }
        },
      ),
    );
  }
}
