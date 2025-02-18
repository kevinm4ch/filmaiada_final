import 'package:filmaiada/models/movie.dart';
import 'package:filmaiada/screens/movie_info.dart';
import 'package:filmaiada/widgets/movie_duration.dart';
import 'package:flutter/material.dart';

class FavoriteMovie extends StatelessWidget {
  const FavoriteMovie({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => MovieInfoScreen(
              movie: movie,
            ),
          ),
        );
      },
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              child: SizedBox(
                height: 100,
                child: Image.network(movie.posterUrl, fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(movie.releaseYear),
                    const SizedBox(
                      width: 20.0,
                    ),
                    MovieDuration(duration: movie.duration)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(movie.averageRating.toStringAsFixed(1)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
