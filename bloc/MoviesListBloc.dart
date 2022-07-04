import 'package:bloc_demo/data/MovieRepository.dart';
import 'package:bloc_demo/model/MovieModel.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc{
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();


  getMovies() async {
    MovieResponse response = await _movieRepository.getMovies();
    _subject.sink.add(response);
  }


  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}

final moviesBloc = MoviesListBloc();
