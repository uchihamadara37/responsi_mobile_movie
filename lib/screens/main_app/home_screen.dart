import 'package:flutter/material.dart';
import 'package:food_resto_2_mantap/models/movie_model.dart';
// import 'package:food_resto_2_mantap/helpers/shared_pref_helper.dart';
// import 'package:food_resto_2_mantap/screens/auth/login_screen.dart';
import 'package:food_resto_2_mantap/screens/main_app/movie_screen.dart';
import 'package:food_resto_2_mantap/screens/main_app/favorites_screen.dart';
// import 'package:food_resto_2_mantap/screens/auth/profile_screen.dart'; // Import ProfileScreen

class HomeScreen extends StatefulWidget {
  // List<Movie> favoriteMovie;

  const HomeScreen({super.key, });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  // int? _currentUserId;
  // String? _currentUsername; // Untuk menampilkan nama pengguna

  List<Widget> _screens = []; // Inisialisasi kosong dulu
  List<Movie> _favoriteMovie = [];

  @override
  void initState() {
    super.initState();
    // _loadCurrentUser();
    _screens = [ // Inisialisasi screens setelah userId didapat
        MoviesScreen(_favoriteMovie),
        FavoritesScreen(_favoriteMovie),
        // Tambahkan ProfileScreen jika ingin sebagai tab, atau akses dari AppBar
      ];
  }

  // Future<void> _loadCurrentUser() async {
  //   final userId = await SharedPrefHelper.getUserId();
  //   final username = await SharedPrefHelper.getUsername(); // Ambil username

    
  //   setState(() {
  //     _currentUserId = userId;
  //     _currentUsername = username;
  //     _screens = [ // Inisialisasi screens setelah userId didapat
  //       FoodsScreen(currentUserId: _currentUserId!),
  //       FavoritesScreen(currentUserId: _currentUserId!),
  //       // Tambahkan ProfileScreen jika ingin sebagai tab, atau akses dari AppBar
  //     ];
  //   });
  // }

  // void _navigateToLogin() {
  //   if (mounted) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //       (route) => false,
  //     );
  //   }
  // }

  void _onTabTapped(int index) {
    // Jika ProfileScreen adalah bagian dari BottomNavigationBar
    // if (index == 2 && _currentUserId != null) { // Asumsi Profile adalah tab ke-3
    //   Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(userId: _currentUserId!)));
    //   return; // Jangan ubah _currentIndex jika navigasi ke halaman baru
    // }
    setState(() {
      _currentIndex = index;
    });
  }

  // void _logout() async {
  //   await SharedPrefHelper.clearSession();
  //   _navigateToLogin();
  // }

  // void _navigateToProfile() {
  //   if (_currentUserId != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => ProfileScreen(userId: _currentUserId!)),
  //     ).then((value) {
  //       // Optional: refresh data user jika ada perubahan di profile screen
  //       _loadCurrentUser();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if (_currentUserId == null) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    String title = 'Movie App';
    if (_currentIndex == 0) title = 'Movie list';
    if (_currentIndex == 1) title = 'My Favorites Movies';
    // if (_currentIndex == 2) title = 'Profile'; // Jika Profile adalah tab

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // if (_currentUsername != null) // Tampilkan nama pengguna jika ada
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: Center(child: Text('Hi, $_currentUsername')),
          //   ),
          // IconButton(
          //   icon: const Icon(Icons.person_outline), // Icon untuk Profile
          //   onPressed: _navigateToProfile,
          //   tooltip: 'Profile',
          // ),
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: _logout,
          //   tooltip: 'Logout',
          // ),
        ],
      ),
      body: _screens.isEmpty
          ? const Center(child: Text("Loading screens..."))
          : _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_outlined),
            label: 'Favorites',
          ),
          // Jika ProfileScreen adalah tab:
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          // ),
        ],
      ),
    );
  }
}