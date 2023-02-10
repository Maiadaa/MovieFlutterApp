import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:day8/model/PopularMoviesError.dart';
import 'package:day8/model/PopularMoviesSuccess.dart';
import 'package:http/http.dart' as http;
class PopularMoviesAPI{
  PopularMoviesAPI._();
  static final PopularMoviesAPI api=PopularMoviesAPI._();


  Future<dartz.Either<PopularMoviesError,PopularMoviesSuccess>> fetchPopularMovies() async {
    String url = 'https://api.themoviedb.org/3/movie/popular?api_key=a3c23773006a50f1f10d6518a879a484&language=en-US&page=1';
    http.Response response = await http.get(Uri.parse(url));
    int code = response.statusCode;
    var jsonData = jsonDecode(response.body);
    if(code == 200){
      //success
      return dartz.Right(PopularMoviesSuccess.fromJson(jsonData));
    }else{
      return dartz.Left(PopularMoviesError.fromJson(jsonData));
    }
  }
}