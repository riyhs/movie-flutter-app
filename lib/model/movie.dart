import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  int id;
  String overview;
  String backdrop;
  String poster;
  String title;
  String release;
  dynamic vote;

  Movie({
    required this.id,
    required this.overview,
    required this.backdrop,
    required this.poster,
    required this.title,
    required this.release,
    required this.vote,
  });

  factory Movie.createMovie(Map<String, dynamic> object) {
    return Movie(
      id: object['id'],
      overview: object['overview'],
      backdrop: object['backdrop_path'],
      poster: object['poster_path'],
      title: object['title'],
      release: object['release_date'],
      vote: object['vote_average'],
    );
  }

  static Future<List<Movie>> getTopRatedMovies() async {
    String token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWRhYTY4M2I1MzU4OTg2NjM1NjNkMmYzYmM0ZDVlNiIsInN1YiI6IjVmZjNmZTNhYjNmNmY1MDAzZmIwYmZhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gonsVrp-r_okFn7rxz6irGQj2IhOPAPqnjpkM2C4dhI";

    var apiResult = await http.get(
        Uri.https('api.themoviedb.org', '3/movie/top_rated'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listMovie = (jsonObject as Map<String, dynamic>)['results'];

    List<Movie> movies = [];
    for(int i = 0; i < listMovie.length; i++) {
      movies.add(Movie.createMovie(listMovie[i]));
    }

    return movies;
  }

  static Future<List<Movie>> getPopularMovies() async {
    String token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWRhYTY4M2I1MzU4OTg2NjM1NjNkMmYzYmM0ZDVlNiIsInN1YiI6IjVmZjNmZTNhYjNmNmY1MDAzZmIwYmZhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gonsVrp-r_okFn7rxz6irGQj2IhOPAPqnjpkM2C4dhI";

    var apiResult = await http.get(
        Uri.https('api.themoviedb.org', '3/movie/popular'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listMovie = (jsonObject as Map<String, dynamic>)['results'];

    List<Movie> movies = [];
    for(int i = 0; i < listMovie.length; i++) {
      movies.add(Movie.createMovie(listMovie[i]));
    }

    return movies;
  }

  static Future<List<Movie>> searchMovies(String query) async {
    String token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWRhYTY4M2I1MzU4OTg2NjM1NjNkMmYzYmM0ZDVlNiIsInN1YiI6IjVmZjNmZTNhYjNmNmY1MDAzZmIwYmZhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gonsVrp-r_okFn7rxz6irGQj2IhOPAPqnjpkM2C4dhI";

    final param = {'query': query};

    var apiResult = await http.get(
        Uri.https('api.themoviedb.org', '3/search/movie', param),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listMovie = (jsonObject as Map<String, dynamic>)['results'];

    List<Movie> movies = [];
    for(int i = 0; i < listMovie.length; i++) {
      movies.add(Movie.createMovie(listMovie[i]));
    }

    print(movies.length);

    return movies;
  }
}