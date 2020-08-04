import 'package:novafilm/src/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {
  String _apikey = '60113ab20260ad4abed7c2cc45935ef3';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _endPoint = 'results';

  Future<List<Movie>> _processResponse(Uri uri, String endPoint) async {
    var response = await http.get(uri);
    // convierte la respuesta en un mapa
    var decodedData = json.decode(response.body);
    // lo añade en la lista de peliculas posicionandose en el objeto results
    final movies = new Movies.fromJsonList(decodedData[endPoint]);
    return movies.movieItems;
  }

  Future<List<Movie>> getMoviesInCinema() async {
    try {
      // Genera la url de la petición al servicio
      final uri = Uri.https(_baseUrl, '3/movie/now_playing',
          {'api_key': _apikey, 'language': _language});

      return await _processResponse(uri, _endPoint);
    } catch (error) {
      print(error);
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final uri = Uri.https(_baseUrl, '3/movie/popular',
          {'api_key': _apikey, 'language': _language});
      return await _processResponse(uri, _endPoint);
    } catch (error) {
      print(error);
    }
  }
}
