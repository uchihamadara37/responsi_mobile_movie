import 'package:flutter/foundation.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';

//state management
class MovieProvider with ChangeNotifier {
  //ini tu bisa nyimpen data sementara di state, with change notifier artinya dia bisa ngasih tau kalo datanya ada perubahan
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  Movie? _selectedMovie;
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners(); // ini function bawaan changetnotifier, buat ngasih tau kalo data berubah

    try {
      _movies = await _apiService.getMovies();
    } catch (e) {
      print('Error fetching users: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Movie?> fetchMovieById(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedMovie = await _apiService.getMovieById(id);
    } catch (e) {
      print('Error fetching movie by ID: $e');
      _selectedMovie = null; // Set to null if there's an error
    }

    _isLoading = false;
    notifyListeners();
    return _selectedMovie;
  }


  // Future<void> addUser(User user) async {
  //   try {
  //     await _apiService.addUser(user);
  //     try {
  //       await fetchUsers();
  //     } catch (e) {
  //       print('Error refreshing user list: $e');
  //     }
  //   } catch (e) {
  //     print('Error adding user: $e');
  //     rethrow; // Hanya melempar ulang jika addUser itu sendiri gagal
  //   }
  // }

  // Future<void> deleteUser(String id) async {
  //   try {
  //     await _apiService.deleteUser(id);
  //     try {
  //       await fetchUsers();
  //     } catch (e) {
  //       print('Error refreshing user list: $e');
  //     }
  //   } catch (e) {
  //     print('Error deleting user: $e');
  //     rethrow;
  //   }
  // }

  // Future<void> editUser(String id, User user) async {
  //   try {
  //     await _apiService.editUser(id, user);
  //     try {
  //       await fetchUsers();
  //     } catch (e) {
  //       print('Error refreshing user list: $e');
  //     }
  //   } catch (e) {
  //     print('Error editing user: $e');
  //     rethrow;
  //   }
  // }
}
