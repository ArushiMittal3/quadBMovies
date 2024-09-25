import 'package:flutter/material.dart';

class MovieDialogBox extends StatelessWidget {
  final Map movie;
  const MovieDialogBox({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: movie['image'] != null
                        ? Image.network(
                            movie['image']['medium'],
                            height: 250,
                            width: 180,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 250,
                            width: 180,
                            color: Colors.grey[700],
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.white70, size: 50),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  movie['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                      'No summary available',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
