import 'package:filmaiada/models/movie.dart';
import 'package:filmaiada/screens/movie_info.dart';
import 'package:filmaiada/widgets/movie_duration.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        borderOnForeground: true,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 430,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => MovieInfoScreen(movie: movie)));
                  },
                  child: Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(movie.averageRating.toStringAsFixed(1)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    MovieDuration(duration: movie.duration),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: Text(movie.synopsis, textAlign: TextAlign.justify, overflow: movie.title.split(' ').length > 5 ? TextOverflow.ellipsis : TextOverflow.clip,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
