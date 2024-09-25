import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quadb/services/api_service.dart';
import 'package:quadb/views/widgets/movie_dialog_box.dart';
import 'package:quadb/views/screens/search_screen.dart';
import 'package:quadb/views/screens/details_screen.dart';
import 'package:quadb/views/widgets/cards/movie_card.dart';
import 'package:quadb/views/widgets/slide_show.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List movies = [];
  int _currentIndex = 0;
  Timer? _timer;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchMovies();
    startSlideshow();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startSlideshow() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (movies.isNotEmpty) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % movies.length;
        });
      }
    });
  }

  // Function to show popup
  void showMoviePopup(BuildContext context, Map<String, dynamic> movie) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MovieDialogBox(movie: movie);
      },
    );
  }

  Future<void> fetchMovies() async {
    try {
      final fetchedMovies = await apiService.fetchMovies();
      setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset(
              'assets/splash_image.png',
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          'QuadBMovies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SlideShow(movies: movies, currentIndex: _currentIndex),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      var movie = movies[index]['show'];
                      return MovieCard(
                        imageUrl: movie['image']?['medium'],
                        title: movie['name'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(movie: movie),
                            ),
                          );
                        },
                        onLongPressStart: () {
                          showMoviePopup(context, movie);
                        },
                        onLongPressEnd: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
