
class PopularMoviesError  {
  int? statusCode;
  String? statusMessage;

  PopularMoviesError({this.statusCode, this.statusMessage});

  PopularMoviesError.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    return data;
  }
}