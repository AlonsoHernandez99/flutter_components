import 'dart:async';
import 'dart:convert';

import 'package:movies_app/src/models/actor_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider {
  String _apiKey = "9b1b07c13f36aacfa16098cb35048573";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  int _popularPage = 0;
  List<Movie> _popularMovies = [];
  bool _loading = false;

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposedStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> getInTheathers() async {
    final uri = Uri.https(_url, "3/movie/now_playing",
        {'api_key': _apiKey, 'language': _language});

    return await _castResponse(uri);
  }

  Future<List<Movie>> getPopular() async {
    if (_loading) return [];

    _loading = true;
    _popularPage++;

    final uri = Uri.https(_url, "3/movie/popular", {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final response = await _castResponse(uri);
    _popularMovies.addAll(response);
    popularSink(_popularMovies);

    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final uri = Uri.https(_url, "3/movie/$movieId/credits",
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(uri);
    final decodedData = json.decode(response.body);
    final cast = new Cast.fromJsonList(decodedData["cast"]);

    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final uri = Uri.https(_url, "3/search/movie",
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _castResponse(uri);
  }

  Future<List<Movie>> _castResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }
}
