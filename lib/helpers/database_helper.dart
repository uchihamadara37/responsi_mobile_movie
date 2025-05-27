import 'package:food_resto_2_mantap/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:food_resto_2_mantap/models/user_model.dart';
// import 'package:food_resto_2_mantap/models/food_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }
  

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'movie_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute('''
    //   CREATE TABLE users (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     username TEXT UNIQUE NOT NULL,
    //     password TEXT NOT NULL
    //   )
    // ''');
    // required this.id,
    // required this.title,
    // required this.imgUrl,
    // required this.rating,
    // required this.duration,
    // required this.genre,

    await db.execute('''
      CREATE TABLE movie (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        igmUrl TEXT NOT NULL,
        rating TEXT NOT NULL,
        duration TEXT NOT NULL
        genre 
      )
    ''');

    await db.execute('''
      CREATE TABLE genres (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        genre TEXT NOT NULL,
        movie_id INTEGER NOT NULL,
        FOREIGN KEY (movie_id) REFERENCES movie (id) ON DELETE CASCADE,
        UNIQUE (movie_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movie_id INTEGER NOT NULL,
        FOREIGN KEY (movie_id) REFERENCES movie (id) ON DELETE CASCADE,
        UNIQUE (movie_id)
      )
    ''');
  }

  // // User operations
  // Future<int> registerUser(User user) async {
  //   final db = await database;
  //   try {
  //     return await db.insert('users', user.toMap());
  //   } catch (e) {
  //     // Handle unique constraint violation for username
  //     if (e.toString().contains('UNIQUE constraint failed')) {
  //       throw Exception('Username already exists');
  //     }
  //     rethrow;
  //   }
  // }

  // Future<User?> loginUser(String username, String password) async {
  //   final db = await database;
  //   var res = await db.query(
  //     'users',
  //     where: 'username = ? AND password = ?',
  //     whereArgs: [username, password],
  //   );
  //   if (res.isNotEmpty) {
  //     return User.fromMap(res.first);
  //   }
  //   return null;
  // }

  // Future<User?> getUserById(int id) async {
  //   final db = await database;
  //   var res = await db.query('users', where: 'id = ?', whereArgs: [id]);
  //   if (res.isNotEmpty) {
  //     return User.fromMap(res.first);
  //   }
  //   return null;
  // }


  // // Food operations
  // Future<int> insertFood(Food food) async {
  //   final db = await database;
  //   return await db.insert('foods', food.toMap());
  // }

  // Future<List<Food>> getAllFoods() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('foods');
  //   return List.generate(maps.length, (i) {
  //     return Food.fromMap(maps[i]);
  //   });
  // }

  // Future<int> updateFood(Food food) async {
  //   final db = await database;
  //   return await db.update(
  //     'foods',
  //     food.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [food.id],
  //   );
  // }

  // Future<int> deleteFood(int id) async {
  //   final db = await database;
  //   return await db.delete(
  //     'foods',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  // // Favorite operations
  // Future<int> addFavorite(int userId, int foodId) async {
  //   final db = await database;
  //   try {
  //       return await db.insert('favorites', {'user_id': userId, 'food_id': foodId});
  //   } catch (e) {
  //       // Handle unique constraint if already favorited
  //       if (e.toString().contains('UNIQUE constraint failed')) {
  //           // Optionally, inform the user it's already a favorite or just ignore
  //           print('Already favorited');
  //           return 0; // Or some indicator that it wasn't newly inserted
  //       }
  //       rethrow;
  //   }
  // }

  // Future<int> removeFavorite(int userId, int foodId) async {
  //   final db = await database;
  //   return await db.delete(
  //     'favorites',
  //     where: 'user_id = ? AND food_id = ?',
  //     whereArgs: [userId, foodId],
  //   );
  // }

  // Future<List<Food>> getFavoriteFoods(int userId) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.rawQuery('''
  //     SELECT f.* FROM foods f
  //     INNER JOIN favorites fav ON f.id = fav.food_id
  //     WHERE fav.user_id = ?
  //   ''', [userId]);
  //   return List.generate(maps.length, (i) {
  //     return Food.fromMap(maps[i]);
  //   });
  // }

  // Future<bool> isFavorite(int userId, int foodId) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'favorites',
  //     where: 'user_id = ? AND food_id = ?',
  //     whereArgs: [userId, foodId],
  //   );
  //   return maps.isNotEmpty;
  // }
}