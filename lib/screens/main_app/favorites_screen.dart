import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_resto_2_mantap/helpers/database_helper.dart';
import 'package:food_resto_2_mantap/models/food_model.dart';
import 'package:food_resto_2_mantap/models/movie_model.dart';

class FavoritesScreen extends StatefulWidget {
  List<Movie> favoriteMovies;

  FavoritesScreen({super.key, required this.favoriteMovies});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async {
    // final foods = await _dbHelper.getFavoriteFoods();
    setState(() {
      _favoriteMovies = widget.favoriteMovies;
    });
  }

  Future<void> _removeFromFavorites(Movie movie) async {
    //  if (movie.id == null) return;
    bool? confirmRemove = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Favorite'),
          content: Text(
            'Are you sure you want to remove ${movie.title} from your favorites?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Remove'),
              onPressed: () {
                widget.favoriteMovies.remove(movie);
                _loadFavoriteMovies();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmRemove == true) {
      // await _dbHelper.removeFavorite( movie.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.title} removed from favorites')),
      );
      _loadFavoriteMovies(); // Refresh the list
    }
  }

  Widget _buildFavoriteFoodItem(Movie movie) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(movie.imgUrl),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Genre: \$${movie.toMap()['genre'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 15, color: Colors.green[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rating: ${movie.rating}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    'Duration: ${movie.duration}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () => _removeFromFavorites(movie),
              tooltip: 'Remove from Favorites',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _favoriteMovies.isEmpty
          ? const Center(
              child: Text(
                'You have no favorite foods yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _favoriteMovies.length,
              itemBuilder: (context, index) {
                final food = _favoriteMovies[index];
                return _buildFavoriteFoodItem(food);
              },
            ),
    );
  }
}
