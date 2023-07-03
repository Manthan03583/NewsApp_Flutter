import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key, required this.newsDetails});
  final News newsDetails;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  bool isFavorite = false; // Track the favorite state

  void toggleFavorite() async {
  setState(() {
    isFavorite = !isFavorite;
  });

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (isFavorite) {
    // Add news to favorites
    final List<String>? favoriteNews = prefs.getStringList('favoriteNews');
    if (favoriteNews != null) {
      favoriteNews.add(json.encode(widget.newsDetails.toJson()));
      await prefs.setStringList('favoriteNews', favoriteNews);
    } else {
      await prefs.setStringList('favoriteNews', [json.encode(widget.newsDetails.toJson())]);
    }
  } else {
    // Remove news from favorites
    final List<String>? favoriteNews = prefs.getStringList('favoriteNews');
    if (favoriteNews != null) {
      favoriteNews.remove(json.encode(widget.newsDetails.toJson()));
      await prefs.setStringList('favoriteNews', favoriteNews);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[500],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.newsDetails.imageURL,
                    width: double.maxFinite,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: toggleFavorite,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                widget.newsDetails.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.newsDetails.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Source: ${widget.newsDetails.source}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
