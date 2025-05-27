import 'package:flutter/material.dart';
import 'package:food_resto_2_mantap/providers/movie_provider.dart';
// import 'package:food_resto_2_mantap/helpers/shared_pref_helper.dart';
// import 'package:food_resto_2_mantap/screens/auth/login_screen.dart';
import 'package:food_resto_2_mantap/screens/main_app/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Penting untuk SharedPreferences
  // bool isLoggedIn = await SharedPrefHelper.getUserId() != null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isLoggedIn;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider()..fetchMovies(),
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
