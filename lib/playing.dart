import 'dart:convert';

class Playing {
  List<Result> results;
  int? page;
  int? totalResults;
  Dates? dates;
  int? totalPages;

  Playing({
    required this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  factory Playing.fromRawJson(String str) => Playing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Playing.fromJson(Map<String, dynamic> json) => Playing(
    results: List<Result>.from(
        json["results"].map((x) => Result.fromJson(x))),
    page: json["page"],
    totalResults: json["total_results"],
    dates: Dates.fromJson(json["dates"]),
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    "page": page,
    "total_results": totalResults,
    "dates": dates?.toJson(),
    "total_pages": totalPages,
  };
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum":
    "${maximum?.year.toString().padLeft(4, '0')}-${maximum?.month.toString().padLeft(2, '0')}-${maximum?.day.toString().padLeft(2, '0')}",
    "minimum":
    "${minimum?.year.toString().padLeft(4, '0')}-${minimum?.month.toString().padLeft(2, '0')}-${minimum?.day.toString().padLeft(2, '0')}",
  };
}

class Result {
  int? voteCount;
  int? id;
  bool? video;
  double? voteAverage;
  String? title;
  double? popularity;
  String? posterPath;
  String? originalTitle;
  List<int> genreIds;
  String? backdropPath;
  bool? adult;
  String? overview;
  DateTime? releaseDate;

  Result({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalTitle,
    required this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    voteCount: json["vote_count"],
    id: json["id"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    title: json["title"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    originalTitle: json["original_title"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    backdropPath: json["backdrop_path"],
    adult: json["adult"],
    overview: json["overview"],
    releaseDate: DateTime.parse(json["release_date"]),
  );

  Map<String, dynamic> toJson() => {
    "vote_count": voteCount,
    "id": id,
    "video": video,
    "vote_average": voteAverage,
    "title": title,
    "popularity": popularity,
    "poster_path": posterPath,
    "original_title": originalTitle,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "backdrop_path": backdropPath,
    "adult": adult,
    "overview": overview,
    "release_date":
    "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
  };
}

