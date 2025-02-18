import 'dart:math';

class Movie {
  int? id;
  final String title;
  final String releaseYear;
  final String posterUrl;
  final int duration;
  final String director;
  final List<String> movieStars;
  final double averageRating;
  final String synopsis;

  static double getAverageRating(){
    final random = Random();
  
    double randomValue = 5 + random.nextDouble() * (9 - 5);

    return double.parse(randomValue.toStringAsFixed(1));
  
  
  }

  Movie(
      {this.id,
      required this.title,
      required this.releaseYear,
      required this.posterUrl,
      required this.duration,
      required this.director,
      required this.movieStars,
      required this.averageRating,
      required this.synopsis
    });


  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        releaseYear: json["releaseYear"],
        posterUrl: json["posterUrl"],
        duration: json["duration"],
        director: json["director"],
        movieStars: json["movieStars"] == null? []: List<String>.from(json["movieStars"].map((x) => x)),
        averageRating: json["averageRating"]?.toDouble(),
        synopsis: json["synopsis"]
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "releaseYear": releaseYear,
        "posterUrl": posterUrl,
        "duration": duration,
        "director": director,
        "movieStars": List<dynamic>.from(movieStars.map((x) => x)),
        "averageRating": averageRating,
        "synopsis": synopsis
    };
}

