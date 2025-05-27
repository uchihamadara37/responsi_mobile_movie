import 'dart:convert';
import 'package:food_resto_2_mantap/models/movie_model.dart';
import 'package:http/http.dart' as http;
// import 'package:food_resto_2_mantap/models/user_model.dart';

class ApiService {
  // Ganti dengan URL base API Anda
  static const String _baseUrl =
      'https://681388b3129f6313e2119693.mockapi.io/api/v1';

  // Header umum untuk request JSON
  Map<String, String> get _headers => {'Content-Type': 'application/json'};

  // Register User
  Future<List<Movie>> getMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      print("Response body movies: ${response.body}");
      final List<dynamic> data = jsonDecode(response.body);
      print("Data movies: $data");
      return data.map<Movie>((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load user. Status code: ${response.statusCode}',
      );
    }
  }

  Future<Movie> getMovieById(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(
        jsonDecode(response.body)['data'] ?? jsonDecode(response.body)['data'],
      ); // Sesuaikan
    } else {
      throw Exception(
        'Failed to load user. Status code: ${response.statusCode}',
      );
    }
  }

  // Get All Movie

  // Login User
  // Future<User> loginUser(String username, String password) async {
  // API login biasanya memerlukan username dan password di body
  // Endpoint login tidak ada di dokumentasi Anda, saya asumsikan /users bisa digunakan untuk verifikasi
  // atau ada endpoint login tersembunyi.
  // Jika tidak ada endpoint login khusus, kita harus GET semua user dan cek manual (TIDAK AMAN & TIDAK EFISIEN)
  // ATAU, API Anda mungkin memiliki cara login yang berbeda.
  // Untuk contoh ini, saya akan mencoba GET user berdasarkan username jika API mendukung query.
  // Jika API Anda memiliki endpoint login khusus (misal /login), gunakan itu.

  // **ASUMSI KASAR:** Karena tidak ada endpoint login, kita coba fetch semua user
  // dan cari yang cocok. INI SANGAT TIDAK DIREKOMENDASIKAN UNTUK PRODUKSI.
  // Idealnya, API harus menyediakan endpoint /login yang aman.
  // Jika API Anda punya /login, ganti implementasi ini.

  //   final response = await http.get(
  //     Uri.parse('$_baseUrl/users'), // GET semua user
  //     headers: _headers,
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> usersJson = jsonDecode(response.body)['data'] ?? jsonDecode(response.body); // Sesuaikan jika struktur response berbeda
  //     List<User> users = usersJson.map((json) => User.fromJson(json)).toList();

  //     // Cari user berdasarkan username. Password check seharusnya terjadi di backend.
  //     // API login yang benar akan menerima username & password, lalu backend yang memverifikasi.
  //     try {
  //       User foundUser = users.firstWhere(
  //         (user) => user.username == username,
  //         // Jika tidak ditemukan, akan throw StateError
  //       );
  //       // **PENTING:** Verifikasi password seharusnya dilakukan oleh API.
  //       // Karena API Anda tidak memiliki endpoint login, kita tidak bisa mengirim password untuk diverifikasi.
  //       // Ini adalah celah keamanan besar. Anda HARUS memiliki endpoint login di API.
  //       // Untuk tujuan demonstrasi, kita anggap jika username ditemukan, login berhasil.
  //       // Anda perlu menyimpan ID user yang login.
  //       print('Login successful for user: ${foundUser.username}, ID: ${foundUser.id}');
  //       return foundUser;
  //     } catch (e) {
  //       throw Exception('Invalid username or password (user not found).');
  //     }
  //   } else {
  //     throw Exception('Failed to fetch users for login. Status code: ${response.statusCode}');
  //   }
  // }

  // // Get User by ID
  // Future<User> getUserById(int userId) async {
  //   final response = await http.get(
  //     Uri.parse('$_baseUrl/users/$userId'),
  //     headers: _headers,
  //   );

  //   if (response.statusCode == 200) {
  //     return User.fromJson(jsonDecode(response.body)['data'] ?? jsonDecode(response.body)); // Sesuaikan
  //   } else {
  //     throw Exception('Failed to load user. Status code: ${response.statusCode}');
  //   }
  // }

  // // Update User
  // Future<User> updateUser(int userId, String newUsername, {String? newPassword, String? newEmail}) async {
  //   final Map<String, dynamic> body = {
  //     'username': newUsername,
  //   };
  //   if (newPassword != null && newPassword.isNotEmpty) {
  //     body['password'] = newPassword; // Jika API memperbolehkan update password
  //   }
  //   if (newEmail != null) {
  //     body['email'] = newEmail;
  //   }

  //   final response = await http.put(
  //     Uri.parse('$_baseUrl/edit-user/$userId'),
  //     headers: _headers,
  //     body: jsonEncode(body),
  //   );

  //   if (response.statusCode == 200) {
  //     // Asumsikan API mengembalikan data user yang sudah diupdate
  //     return User.fromJson(jsonDecode(response.body)['data'] ?? jsonDecode(response.body)); // Sesuaikan
  //   } else {
  //     String errorMessage = 'Failed to update user. Status code: ${response.statusCode}';
  //      try {
  //       final errorData = jsonDecode(response.body);
  //       if (errorData['message'] != null) {
  //         errorMessage = errorData['message'];
  //       } else if (errorData['error'] != null) {
  //          errorMessage = errorData['error'];
  //       }
  //     } catch (e) {}
  //     throw Exception(errorMessage);
  //   }
  // }

  // // Delete User
  // Future<void> deleteUser(int userId) async {
  //   final response = await http.delete(
  //     Uri.parse('$_baseUrl/delete-user/$userId'),
  //     headers: _headers,
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 204) { // 204 No Content juga OK
  //     return; // Sukses
  //   } else {
  //     String errorMessage = 'Failed to delete user. Status code: ${response.statusCode}';
  //     try {
  //       final errorData = jsonDecode(response.body);
  //       if (errorData['message'] != null) {
  //         errorMessage = errorData['message'];
  //       } else if (errorData['error'] != null) {
  //          errorMessage = errorData['error'];
  //       }
  //     } catch (e) {}
  //     throw Exception(errorMessage);
  //   }
  // }
}
