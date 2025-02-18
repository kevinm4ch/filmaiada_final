
import 'package:filmaiada/providers/movies_provider.dart';
import 'package:filmaiada/widgets/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetchMovies();
    super.initState();
  }

  final _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);

    if (moviesProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (moviesProvider.error != null) {
      return Center(
        child: Text(moviesProvider.error!),
      );
    } else {
      return SafeArea(
        child: PageView(
          controller: _pageController,
          children:
              moviesProvider.movies.map((m) => MoviePage(movie: m)).toList(),
        ),
      );
    }
  }
}
