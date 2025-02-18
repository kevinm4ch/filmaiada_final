import 'dart:convert';

import 'package:filmaiada/models/movie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; 

class MoviesProvider with ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.ref();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _error;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int? get lastId => _movies[_movies.length - 1].id;

  get state => this;
  static MoviesProvider of(BuildContext context) {
    return Provider.of<MoviesProvider>(context, listen: false);
  }

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.https(
          'filmaiada-33122-default-rtdb.firebaseio.com', 'movies.json');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _movies = data.isNotEmpty? data.map((json) => Movie.fromJson(json)).toList(): [];
      } else {
        _error = 'Falha ao carregar filmes';
      }
    } catch (e) {
      _error = "Erro ao carregar os filmes:\n$e";
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMovie(Movie movie) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_movies.isEmpty) {
        await fetchMovies();
      }

      final int lastId = _movies.last.id!;
      
      movie.id = lastId + 1;

      // final url = Uri.https('filmaiada-33122-default-rtdb.firebaseio.com', "movies/${movie.id!}.json");

      //essa é a melhor maneira de deixar o banco mais organizado, tenti fazer por post mais ele cria umas chaves doidas
      await databaseReference
          .child("movies")
          .child(lastId.toString())
          .set(movie.toJson());

      //Aqui eu altero o estado pra  
      _movies.add(movie);

      //final response = await http.post(url, body: jsonEncode(movie.toJson()));

      // if (response.statusCode == 200) {
      //   final List<dynamic> data = jsonDecode(response.body);
      //   _movies = data.map((json) => Movie.fromJson(json)).toList();
      // } else {
      //   _error = 'Falha ao adicionar o filme';
      // }
    } catch (e) {
      _error = "Erro ao adicionar o filme:\n$e";
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
