import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_app/detail_screen.dart';
import 'package:movie_flutter_app/model/movie.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() {
    return _ExploreScreenState();
  }
}

class _ExploreScreenState extends State<ExploreScreen> {
  var _controller = TextEditingController();
  var showList = false;

  late Future<List<dynamic>> movies;

  void searchMovie() {
    setState(() {
      movies = getMovies();
      showList = true;
    });
  }

  Future<List<dynamic>> getMovies() async {
    return Movie.searchMovies(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Explore Movie',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Cari Judul Film',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          searchMovie();
                          showList = true;
                        })),
                onSubmitted: (String text) {
                  searchMovie();
                  showList = true;
                  print(text);
                },
              ),
            ),
            if (showList)
              FutureBuilder(
                future: movies,
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                                        constraints: BoxConstraints(
                                            maxWidth: 110, minWidth: 110),
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
                                                        if (i <=
                                                            snapshot
                                                                    .data![
                                                                        index]
                                                                    .vote /
                                                                2)
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
                      child: Text('loading'),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
