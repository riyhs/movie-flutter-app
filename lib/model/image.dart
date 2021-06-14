import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieImage{
  String backdrop;

  MovieImage({required this.backdrop});

  factory MovieImage.createImage(Map<String, dynamic> object) {
    return MovieImage(backdrop: object['file_path']);
  }

  static Future<List<MovieImage>> getMovieImages(String id) async {
    String token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWRhYTY4M2I1MzU4OTg2NjM1NjNkMmYzYmM0ZDVlNiIsInN1YiI6IjVmZjNmZTNhYjNmNmY1MDAzZmIwYmZhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gonsVrp-r_okFn7rxz6irGQj2IhOPAPqnjpkM2C4dhI";

    var apiResult = await http.get(
        Uri.https('api.themoviedb.org', '3/movie/$id/images'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listImage = (jsonObject as Map<String, dynamic>)['backdrops'];

    List<MovieImage> images = [];
    for(int i = 0; i < listImage.length; i++) {
      images.add(MovieImage.createImage(listImage[i]));
      if(i >= 15) break;
    }

    return images;
  }
}