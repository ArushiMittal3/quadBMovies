import 'package:flutter/material.dart';
import 'package:quadb/views/screens/details_screen.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({
    super.key,
    required this.movies,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final List movies;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          var movie = movies[_currentIndex]['show'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(movie: movie),
            ),
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: movies[_currentIndex]['show']['image'] != null
                    ? Image.network(
                        movies[_currentIndex]['show']['image']['medium'],
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.white70,
                          size: 50,
                        ),
                      ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                movies[_currentIndex]['show']['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
