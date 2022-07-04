
import 'package:bloc_demo/model/MovieModel.dart';
import 'package:flutter/material.dart';

import '../bloc/MoviesListBloc.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc..getMovies();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text(
              "Top Rated Movies".toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(child: StreamBuilder<MovieResponse>(
              stream: moviesBloc.subject.stream,
              builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.error != null &&
                      snapshot.data!.error.length > 0) {
                    return Text("on data error ${snapshot.data?.error}");
                  }
                  return _buildMoviesWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("on data error ${snapshot.hasError}");
                } else {
                  return _buildLoadingWidget();
                }
              }))
        ],
      ),
    );
  }

  Widget _buildMoviesWidget(MovieResponse? data) {
    List<Movie> movies = data?.movies ?? [];
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: const <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      movies[index].poster == null
                          ? Container(
                        decoration: new BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 60.0,
                            )
                          ],
                        ),
                      )
                          : Container(
                          height: 250.0,
                          decoration: new BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        movies[index].poster)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            movies[index].rating.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }
}
