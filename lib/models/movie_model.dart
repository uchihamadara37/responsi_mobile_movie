class Movie {
  // ID bisa String atau int tergantung API, sesuaikan jika perlu
  // Jika API mengembalikan ID sebagai string (misalnya UUID), ganti tipe data di sini dan di SharedPreferences.
  // Untuk contoh ini, saya asumsikan API mengembalikan ID sebagai int setelah registrasi/login.
  // Jika API tidak mengembalikan ID saat login, Anda mungkin perlu melakukan GET /users/:username setelah login.
  // Atau, jika API mengembalikan ID sebagai string, maka SharedPrefHelper juga harus menyimpan string.
  // Saya akan mengasumsikan API mengembalikan 'id' (int), 'username'.
  int id; // ID dari API (bisa juga String)
  String title;
  String imgUrl; 
  String rating;
  Set<String> genre = {};
  String duration; 

  Movie({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.rating,
    required this.duration,
    required this.genre,
  });

  // Factory constructor untuk membuat User dari JSON API
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      // Pastikan key 'id' dan 'username' sesuai dengan respons API Anda
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      title: json['title'],
      imgUrl: json['imgUrl'], // Jika ada
      rating: json['rating'], 
      duration: json['duration'],
      genre: Set<String>.from(json['genre'] ?? []), // Menggunakan Set untuk genre
    );
  }
  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
      // Pastikan key 'id' dan 'username' sesuai dengan respons API Anda
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      title: json['title'],
      imgUrl: json['imgUrl'], // Jika ada
      rating: json['rating'], 
      duration: json['duration'],
      genre: Set<String>.from(json['genre'] ?? []), // Menggunakan Set untuk genre
    );
  }

  // Method untuk mengubah User menjadi JSON untuk dikirim ke API (misalnya saat update)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['id'] = id; // Tergantung apakah API memerlukan ID di body saat update
    data['title'] = title;
    data['imgUrl'] = imgUrl;
    data['rating'] = rating;
    data['duration'] = duration;
    data['genre'] = genre.toList(); // Mengubah Set ke List untuk JSO
    return data;
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['id'] = id; // Tergantung apakah API memerlukan ID di body saat update
    data['title'] = title;
    data['imgUrl'] = imgUrl;
    data['rating'] = rating;
    data['duration'] = duration;
    data['genre'] = genre.toList(); // Mengubah Set ke List untuk JSO
    return data;
  }
}