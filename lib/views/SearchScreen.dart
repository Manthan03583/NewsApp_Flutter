import 'package:flutter/material.dart';
import 'package:newsapp/controllers/newsController.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/customListTile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Newscontroller _newscontroller = Newscontroller();
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<News>> _searchNews(String query) async {
    if (query.isEmpty) {
      return [];
    } else {
      return _newscontroller.searchNews(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[500],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onSubmitted: (query) {
                  setState(() {
                    _searchNews(query);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter search query',
                  filled: true,
                  fillColor: Colors.deepPurple[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<News>>(
                  future: _searchNews(_searchController.text),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<News>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final List<News> newsList = snapshot.data!;
                      return ListView.builder(
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final news = newsList[index];
                          return CustomListTile(news: news);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
