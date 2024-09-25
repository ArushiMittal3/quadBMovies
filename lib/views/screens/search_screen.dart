import 'package:flutter/material.dart';
import 'package:quadb/services/api_service.dart';
import 'package:quadb/views/widgets/cards/search_item.dart';
import 'package:quadb/views/screens/details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  final ApiService apiService = ApiService();

  Future<void> searchMovies(String query) async {
    setState(() {
      isSearching = true;
    });
    try {
      final results = await apiService.searchMovies(query);
      setState(() {
        searchResults = results;
        isSearching = false;
      });
    } catch (e) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      //handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onSubmitted: (query) => searchMovies(query),
          decoration: InputDecoration(
            hintText: 'Search for a movie',
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        color: Colors.black87,
        child: isSearching
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              )
            : searchResults.isEmpty && searchController.text.isNotEmpty
                ? const Center(
                    child: Text(
                      'No movies found',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  )
                : searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          'Search for movies',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          var movie = searchResults[index]['show'];
                          return SearchItem(
                            imageUrl: movie['image']?['medium'],
                            title: movie['name'],
                            summary: movie['summary']
                                    ?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                                'No summary available',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(movie: movie),
                                ),
                              );
                            },
                          );
                        },
                      ),
      ),
    );
  }
}
