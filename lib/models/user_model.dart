class User {
  // ID bisa String atau int tergantung API, sesuaikan jika perlu
  // Jika API mengembalikan ID sebagai string (misalnya UUID), ganti tipe data di sini dan di SharedPreferences.
  // Untuk contoh ini, saya asumsikan API mengembalikan ID sebagai int setelah registrasi/login.
  // Jika API tidak mengembalikan ID saat login, Anda mungkin perlu melakukan GET /users/:username setelah login.
  // Atau, jika API mengembalikan ID sebagai string, maka SharedPrefHelper juga harus menyimpan string.
  // Saya akan mengasumsikan API mengembalikan 'id' (int), 'username'.
  int? id; // ID dari API (bisa juga String)
  String username;
  String? email; // Contoh field tambahan jika ada dari API
  // Password biasanya tidak disimpan di model setelah fetch dari API, hanya untuk register/login

  User({
    this.id,
    required this.username,
    this.email,
  });

  // Factory constructor untuk membuat User dari JSON API
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // Pastikan key 'id' dan 'username' sesuai dengan respons API Anda
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      username: json['username'],
      email: json['email'], // Jika ada
    );
  }
  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      // Pastikan key 'id' dan 'username' sesuai dengan respons API Anda
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      username: json['username'],
      email: json['email'], // Jika ada
    );
  }

  // Method untuk mengubah User menjadi JSON untuk dikirim ke API (misalnya saat update)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id; // Tergantung apakah API memerlukan ID di body saat update
    }
    data['username'] = username;
    if (email != null) {
      data['email'] = email;
    }
    // Password biasanya dikirim terpisah atau hanya saat register/login
    return data;
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id; // Tergantung apakah API memerlukan ID di body saat update
    }
    data['username'] = username;
    if (email != null) {
      data['email'] = email;
    }
    // Password biasanya dikirim terpisah atau hanya saat register/login
    return data;
  }
}