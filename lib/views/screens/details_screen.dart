import 'package:flutter/material.dart';
import 'package:quadb/views/widgets/buttons/action_button.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;
  const DetailsScreen({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Text(
          movie['name'],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: movie['image']?['original'] != null
                        ? AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              movie['image']['original'],
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          )
                        : Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.white70,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      movie['name'],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black54,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900]?.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                          'No summary available',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionButton(
                  icon: Icons.play_arrow,
                  label: 'Play',
                  onTap: () {
                    // Add functionality for playing the movie
                  },
                ),
                ActionButton(
                  icon: Icons.favorite_border,
                  label: 'Favorite',
                  onTap: () {
                    // Add functionality for adding to favorites
                  },
                ),
                ActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: () {
                    // Add functionality for sharing the movie
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
    );
  }
}
