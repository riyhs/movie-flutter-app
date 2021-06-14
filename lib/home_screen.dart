import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_flutter_app/detail_screen.dart';
import 'package:movie_flutter_app/explore_screen.dart';
import 'package:movie_flutter_app/model/movie.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Movie App',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ExploreScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.search),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 265,
              child: FutureBuilder<List<dynamic>>(
                future: Movie.getTopRatedMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0)
                          return Container(
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailScreen(
                                          movie: snapshot.data![index]);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        'https://image.tmdb.org/t/p/w500/${snapshot.data![index].backdrop}',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error_outline,
                                              size: 48,
                                            ),
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16.0, bottom: 4.0),
                                                child: Text(
                                                  snapshot.data![index].title,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  for (var i = 1; i < 6; i++)
                                                    if (i <=
                                                        (snapshot.data![index]
                                                            .vote /
                                                            2))
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                        size: 18,
                                                      )
                                                    else
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.grey,
                                                        size: 18,
                                                      )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                        return Container(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailScreen(
                                        movie: snapshot.data![index]);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      'https://image.tmdb.org/t/p/w500/${snapshot.data![index].backdrop}',
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.error_outline,
                                            size: 48,
                                          ),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0, bottom: 4.0),
                                              child: Text(
                                                snapshot.data![index].title,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                for (var i = 1; i < 6; i++)
                                                  if (i <=
                                                      (snapshot.data![index]
                                                          .vote /
                                                          2))
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 18,
                                                    )
                                                  else
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.grey,
                                                      size: 18,
                                                    )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 12.0, bottom: 12.0),
              child: Text(
                'Popular Movies',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: FutureBuilder<List<dynamic>>(
                future: Movie.getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailScreen(movie: snapshot.data![index]);
                            }));
                          },
                          child: Container(
                            height: 180,
                            child: Center(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: 8.0,
                                      right: 16.0,
                                      bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 110),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500/${snapshot.data![index].poster}',
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error_outline,
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, right: 16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].title,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 16.0),
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .overview,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      for (var i = 1;
                                                          i < 6;
                                                          i++)
                                                        if (i <
                                                            (snapshot
                                                                    .data![
                                                                        index]
                                                                    .vote /
                                                                2))
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: 18,
                                                          )
                                                        else
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.grey,
                                                            size: 18,
                                                          )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
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
