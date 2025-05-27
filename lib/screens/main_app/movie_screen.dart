import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_resto_2_mantap/helpers/database_helper.dart';
// import 'package:food_resto_2_mantap/models/food_model.dart';
import 'package:food_resto_2_mantap/models/movie_model.dart';
import 'package:food_resto_2_mantap/providers/movie_provider.dart';
import 'package:food_resto_2_mantap/screens/main_app/movie_detail_page.dart';
import 'package:food_resto_2_mantap/services/api_service.dart';
// import 'package:food_resto_2_mantap/screens/main_app/add_edit_food_screen.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  List<Movie> favoriteMovie = [];

  MoviesScreen({super.key, required this.favoriteMovie});

  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<MoviesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Movie> _movies = [];
  Map<int, bool> _favoriteStatus = {}; // foodId -> isFavorite

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    // final movies = await Provider.of<MovieProvider>(context, listen: false).movies;
    final movies = await ApiService().getMovies();
    print("Movies loaded: ${movies.length}");
    final favStatus = <int, bool>{};
    // for (var movie in movies) {
    // favStatus[movie.id!] = await _dbHelper.isFavorite(movie.id!);
    // }
    setState(() {
      _movies = movies;
      _favoriteStatus = favStatus;
    });
  }

  // void _navigateToAddEditScreen([Food? food]) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AddEditFoodScreen(food: food),
  //     ),
  //   );
  //   if (result == true) { // true indicates a change was made
  //     _loadFoods(); // Reload foods if a food was added or edited
  //   }
  // }

  // Future<void> _deleteFood(int foodId) async {
  //   // Show confirmation dialog
  //   bool? confirmDelete = await showDialog<bool>(
  //       context: context,
  //       builder: (BuildContext context) {
  //           return AlertDialog(
  //               title: const Text('Confirm Delete'),
  //               content: const Text('Are you sure you want to delete this food item? This will also remove it from all users\' favorites.'),
  //               actions: <Widget>[
  //                   TextButton(
  //                       child: const Text('Cancel'),
  //                       onPressed: () {
  //                           Navigator.of(context).pop(false);
  //                       },
  //                   ),
  //                   TextButton(
  //                       child: const Text('Delete'),
  //                       onPressed: () {
  //                           Navigator.of(context).pop(true);
  //                       },
  //                   ),
  //               ],
  //           );
  //       },
  //   );

  //   if (confirmDelete == true) {
  //       await _dbHelper.deleteFood(foodId);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Food deleted successfully')),
  //       );
  //       _loadFoods(); // Refresh the list
  //   }
  // }

  Future<void> _toggleFavorite(Movie movie) async {
    // if (movie.id == null) return;

    bool isCurrentlyFavorite = _favoriteStatus[movie.id] ?? false;
    if (isCurrentlyFavorite) {
      // await _dbHelper.removeFavorite(movie.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.title} removed from favorites')),
      );
    } else {
      // await _dbHelper.addFavorite( movie.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${movie.title} added to favorites')),
      );
    }
    // Update favorite status for this movie item
    setState(() {
      _favoriteStatus[movie.id] = !isCurrentlyFavorite;
    });
  }

  Widget _buildMovieItem(Movie movie) {
    bool isFavorite = _favoriteStatus[movie.id] ?? false;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(movie: movie),
            ),
          ),
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.imgUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Details
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
              // Actions
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(movie),
                    tooltip: isFavorite
                        ? 'Remove from Favorites'
                        : 'Add to Favorites',
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.edit, color: Colors.blue),
                  //   onPressed: () => _navigateToAddEditScreen(movie),
                  //   tooltip: 'Edit movie',
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.delete, color: Colors.redAccent),
                  //   onPressed: () => _deletemovie(movie.id!),
                  //   tooltip: 'Delete Food',
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _movies.isEmpty
          ? const Center(
              child: Text(
                'No movie items yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final food = _movies[index];
                return _buildMovieItem(food);
              },
            ),

      // Consumer<MovieProvider>(
      //   // ini adalah pasangan dari ChangeNotifier, fungsinya adalah mendengarkan perubahan yang ada di UserProvider
      //   builder: (context, movieProvider, child) {
      //     if (movieProvider.isLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }

      //     if (movieProvider.movies.isEmpty) {
      //       return const Center(child: Text('No movies found'));
      //     }

      //     return ListView.builder(
      //       itemCount: movieProvider.movies.length,
      //       itemBuilder: (context, index) {
      //         final movie = movieProvider.movies[index];
      //         return Dismissible(
      //           key: Key(movie.id?.toString() ?? ''),
      //           direction: DismissDirection.horizontal,
      //           background: Container(
      //             color: Colors.blue,
      //             alignment: Alignment.centerLeft,
      //             padding: const EdgeInsets.only(left: 20),
      //             child: const Icon(Icons.edit, color: Colors.white),
      //           ),
      //           secondaryBackground: Container(
      //             color: Colors.red,
      //             alignment: Alignment.centerRight,
      //             padding: const EdgeInsets.only(right: 20),
      //             child: const Icon(
      //               Icons.delete,
      //               color: Colors.white,
      //             ),
      //           ),
      //           confirmDismiss: (direction) async {
      //           },
      //           onDismissed: (direction) async {
      //           },
      //           child: ListTile(
      //             title: Text(movie.title),
      //             subtitle: Text(movie.duration),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),

      // akhir dari body
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // _navigateToAddEditScreen()
        },
        tooltip: 'Add Food',
        child: const Icon(Icons.add),
      ),
    );
  }
}
