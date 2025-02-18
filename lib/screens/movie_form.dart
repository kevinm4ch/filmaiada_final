import 'package:filmaiada/models/movie.dart';
import 'package:filmaiada/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieFormScreen extends StatefulWidget {
  const MovieFormScreen({super.key});

  @override
  State<MovieFormScreen> createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  late List<int> _years;
  int? _releaseYear;

  final _posterUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();
  final _durationController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _movieStarsController = TextEditingController();

  String networkImage = '';
  String posterErrorMessage = 'Informe a url';

  final _formKey = GlobalKey<FormState>();

  
  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    _years = List.generate(currentYear - 1900 + 1, (index) => 1900 + index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Filme'),
      ),
      body: getBody(),
    );
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void validatePosterUrl(url) {
      
    if (isValidImageUrl(url)) {
      setState(() {
        networkImage = _posterUrlController.text;
        
      });
      
    }else{
      setState(() {
        posterErrorMessage = 'Insira uma url válida';
        
      });
    }
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
      return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Url do pôster'),
                        controller: _posterUrlController,
                        onFieldSubmitted: (value) {
                          validatePosterUrl(value);
                        },
                        validator: (poster) {
                          if (poster == null || poster.isEmpty) {
                            return 'Pôster é obrigatório';
                          } else if (!isValidImageUrl(poster)) {
                            return 'Insira uma url válida';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 150,
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: networkImage.isEmpty
                          ? Text(posterErrorMessage)
                          : Image.network(
                              networkImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  controller: _titleController,
                  validator: (title) {
                    if (title == null || title.isEmpty) {
                      return 'Título é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Diretor'),
                  controller: _directorController,
                  validator: (director) {
                    if (director == null || director.isEmpty) {
                      return 'Diretor é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Duração (min)'),
                  controller: _durationController,
                  validator: (duration) {
                    final regex = RegExp(r'^\d+$');
                    if (duration == null || duration.isEmpty) {
                      return 'Duração é obrigatória';
                    } else if (!regex.hasMatch(duration)) {
                      return 'Insira somente números';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Sinopse'),
                  controller: _synopsisController,
                  maxLines: 3,
                  validator: (synopsis) {
                    if (synopsis == null || synopsis.isEmpty) {
                      return 'Sinopse é obrigatória';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Atores principais'),
                  controller: _movieStarsController,
                  validator: (stars) {
                    final regex = RegExp(r'^[a-zA-Z\s,]+$');

                    if (stars == null || stars.isEmpty) {
                      return 'Insira no mínimo um ator principal';
                    } else if (!regex.hasMatch(stars)) {
                      return 'Insira os nomes dos atores separados por vígula';
                    }

                    return null;
                  },
                  maxLines: 3,
                ),
                DropdownButtonFormField<int>(
                  value: _releaseYear,
                  hint: const Text("Ano de Lançamento"),
                  items: _years.map((year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _releaseYear = value;
                    });
                  },
                  validator: (releaseYear) {
                    if (releaseYear == null) {
                      return 'Selecione o ano de lançamento';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await moviesProvider.addMovie(Movie(
                            title: _titleController.text,
                            releaseYear: _releaseYear.toString(),
                            posterUrl: _posterUrlController.text,
                            duration:
                                int.tryParse(_durationController.text) ?? 0,
                            director: _directorController.text,
                            movieStars: _movieStarsController.text.split(','),
                            averageRating: Movie.getAverageRating(),
                            synopsis: _synopsisController.text));
                      }
                    },
                    child: const Text('Adicionar'))
              ],
            )),
      );
    }
  }
}
