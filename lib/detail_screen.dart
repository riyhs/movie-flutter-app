import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_app/model/image.dart';
import 'package:movie_flutter_app/model/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Detail Movie',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.backdrop}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    size: 48,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
              child: Text(
                movie.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Text(
                movie.release,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var i = 1; i < 6; i++)

                              if (i <= movie.vote / 2)
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 22,
                                )
                              else
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                  size: 22,
                                )
                          ])),
                  Text(
                    '(${movie.vote / 2})',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Text(
                'Overview',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
              child: Text(
                movie.overview,
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Text(
                'Images',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: FutureBuilder(
                future: MovieImage.getMovieImages(movie.id.toString()),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 150,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0)
                            return Container(
                              constraints:
                                  BoxConstraints(minWidth: 200, minHeight: 150),
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500/${snapshot.data![index].backdrop}',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline,
                                    size: 48,
                                  ),
                                ),
                              ),
                            );

                          return Container(
                            constraints:
                                BoxConstraints(minWidth: 200, minHeight: 150),
                            padding: const EdgeInsets.only(right: 16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index].backdrop}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error_outline,
                                  size: 48,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Text('Error');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
