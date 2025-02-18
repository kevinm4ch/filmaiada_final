import 'package:filmaiada/models/movie.dart';
import 'package:filmaiada/widgets/botao_favorito.dart';
import 'package:filmaiada/widgets/movie_duration.dart';
import 'package:flutter/material.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: [
          ToggleWatchListButton(movieId: widget.movie.id.toString())
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(widget.movie.posterUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.movie.title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(widget.movie.averageRating.toString()),
                const SizedBox(width: 20),
                const Icon(Icons.access_time),
                MovieDuration(duration: widget.movie.duration),
                const SizedBox(width: 20),
                Text(widget.movie.releaseYear),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [Text(
                widget.movie.synopsis,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    'Diretor: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.movie.director)
                ],
              ),
              const SizedBox(height: 20.0,),
              const Row(
                children: [
                  Text(
                    'Elenco:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              ...widget.movie.movieStars.map((e) => Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.star_border),
                    Text(' $e', textAlign: TextAlign.start,),
                  ],
                ),
              )),],),
            )
          ],
        ),
      ),
    );
  }
}
