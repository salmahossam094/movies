import 'package:movies/model/home_tab_models/PopularModel.dart';

class NewRelease {
  NewRelease(
      {this.dates,
      this.page,
      this.results,
      this.totalPages,
      this.totalResults,
      this.statusMessage,
      this.statusCode});

  NewRelease.fromJson(dynamic json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    statusMessage = json['statusMessage'];
    statusCode = json['statusCode'];
  }

  Dates? dates;
  num? page;
  List<Results>? results;
  num? totalPages;
  num? totalResults;
  num? statusCode;
  String? statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dates != null) {
      map['dates'] = dates?.toJson();
    }
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}

/// adult : false
/// backdrop_path : "/cSYLX73WskxCgvpN3MtRkYUSj1T.jpg"
/// genre_ids : [16,35,10751,14,10749]
/// id : 976573
/// original_language : "en"
/// original_title : "Elemental"
/// overview : "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common."
/// popularity : 1299.999
/// poster_path : "/8riWcADI1ekEiBguVB9vkilhiQm.jpg"
/// release_date : "2023-06-14"
/// title : "Elemental"
/// video : false
/// vote_average : 7.5
/// vote_count : 261

// class NewRResults {
//   NewRResults({
//     this.adult,
//     this.backdropPath,
//     this.genreIds,
//     this.id,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });
//
//   NewRResults.fromJson(dynamic json) {
//     adult = json['adult'];
//     backdropPath = json['backdrop_path'];
//     genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
//     id = json['id'];
//     originalLanguage = json['original_language'];
//     originalTitle = json['original_title'];
//     overview = json['overview'];
//     popularity = json['popularity'];
//     posterPath = json['poster_path'];
//     releaseDate = json['release_date'];
//     title = json['title'];
//     video = json['video'];
//     voteAverage = json['vote_average'];
//     voteCount = json['vote_count'];
//   }
//
//   bool? adult;
//   String? backdropPath;
//   List<num>? genreIds;
//   num? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   num? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;
//   bool? video;
//   num? voteAverage;
//   num? voteCount;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['adult'] = adult;
//     map['backdrop_path'] = backdropPath;
//     map['genre_ids'] = genreIds;
//     map['id'] = id;
//     map['original_language'] = originalLanguage;
//     map['original_title'] = originalTitle;
//     map['overview'] = overview;
//     map['popularity'] = popularity;
//     map['poster_path'] = posterPath;
//     map['release_date'] = releaseDate;
//     map['title'] = title;
//     map['video'] = video;
//     map['vote_average'] = voteAverage;
//     map['vote_count'] = voteCount;
//     return map;
//   }
// }

/// maximum : "2023-07-23"
/// minimum : "2023-07-08"

class Dates {
  Dates({
    this.maximum,
    this.minimum,
  });

  Dates.fromJson(dynamic json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  String? maximum;
  String? minimum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum'] = maximum;
    map['minimum'] = minimum;
    return map;
  }
}
