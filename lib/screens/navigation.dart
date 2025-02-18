import 'package:filmaiada/screens/movies.dart';
import 'package:filmaiada/screens/watch_list.dart';
import 'package:filmaiada/utils/routes.dart';
import 'package:filmaiada/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class AppNavigationScreen extends StatefulWidget {
  const AppNavigationScreen({super.key});

  @override
  State<AppNavigationScreen> createState() => _AppNavigationScreenState();
}

class _AppNavigationScreenState extends State<AppNavigationScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmaiada'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.movieForm);
            },
            label: const Text('Novo Filme'),
            icon: const Icon(Icons.movie_edit),
          )
        ],
      ),
      drawer: const MainDrawer(),
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.movie),
            label: 'Filmes',
          ),
          NavigationDestination(icon: Icon(Icons.reorder), label: 'Minha Lista')
        ],
      ),
      body: [
        const MoviesScreen(),
        const WatchListScreen(),
      ][currentPageIndex],
    );
  }
}
