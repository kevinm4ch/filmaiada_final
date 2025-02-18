import 'package:filmaiada/providers/auth_provider.dart';
import 'package:filmaiada/screens/login_screen.dart';
import 'package:filmaiada/screens/movie_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:filmaiada/providers/movies_provider.dart';
import 'package:filmaiada/screens/about_us.dart';
import 'package:filmaiada/screens/movies.dart';
import 'package:filmaiada/screens/navigation.dart';
import 'package:filmaiada/screens/watch_list.dart';
import 'package:filmaiada/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(  
    apiKey: "AIzaSyAIDR-cKt_Rbap8WE-eZ7Z9pWYTtJ2arUQ",
    authDomain: "filmaiada-33122.firebaseapp.com",
    databaseURL: "https://filmaiada-33122-default-rtdb.firebaseio.com",
    projectId: "filmaiada-33122",
    storageBucket: "filmaiada-33122.firebasestorage.app",
    messagingSenderId: "757075726048",
    appId: "1:757075726048:web:3854ef9b7b7f4ade4b4a85")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Lista de Filmes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (ctx) => const LoginScreen(),
          AppRoutes.home: (ctx) => const AppNavigationScreen(),
          AppRoutes.movies: (ctx) => const MoviesScreen(),
          AppRoutes.watchList: (ctx) => const WatchListScreen(),
          AppRoutes.movieForm: (ctx) => const MovieFormScreen(),
          AppRoutes.aboutUs: (ctx) => const AboutUsScreen(),
        },
      ),
    );
  }
}
