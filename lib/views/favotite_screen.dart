import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/customListTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<News> favoriteNews = [];

  @override
  void initState() {
    super.initState();
    getFavoriteNews();
  }

  Future<void> getFavoriteNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteNewsJson = prefs.getStringList('favoriteNews');
    if (favoriteNewsJson != null) {
      setState(() {
        favoriteNews = favoriteNewsJson
            .map((json) => News.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  void deleteFavoriteNews(int index) async {
    setState(() {
      favoriteNews.removeAt(index);
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> favoriteNewsJson =
        favoriteNews.map((news) => json.encode(news.toJson())).toList();
    await prefs.setStringList('favoriteNews', favoriteNewsJson);
  }

  void clearAllFavorites() async {
    setState(() {
      favoriteNews.clear();
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favoriteNews');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text(
          'Favorite News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: favoriteNews.isEmpty
          ? const Center(child: Text('No favorite news yet'))
          : ListView.builder(
              itemCount: favoriteNews.length,
              itemBuilder: (context, index) {
                final news = favoriteNews[index];
                return CustomListTile(news:news);},
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearAllFavorites,
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
