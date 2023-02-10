import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:day8/model/MovieDetailsError.dart';
import 'package:day8/model/MovieDetailsSuccess.dart';
import 'package:http/http.dart' as http;
class MovieDetailsAPI{
  MovieDetailsAPI._();
  static final MovieDetailsAPI api=MovieDetailsAPI._();


  Future<dartz.Either<MovieDetailsError, MovieDetailsSuccess>> fetchMovieDetail(int movieId) async {
    String url = 'https://api.themoviedb.org/3/movie/${movieId}?api_key=a3c23773006a50f1f10d6518a879a484&language=en-US';
    http.Response response = await http.get(Uri.parse(url));
    int code = response.statusCode;
    var jsonData = jsonDecode(response.body);
    if(code == 200){
      //success
      return dartz.Right(MovieDetailsSuccess.fromJson(jsonData));
    }else{
      return dartz.Left(MovieDetailsError.fromJson(jsonData));
    }
  }
}