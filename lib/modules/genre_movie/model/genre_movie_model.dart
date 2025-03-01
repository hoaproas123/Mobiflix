class GenreMovieModel  {
  String? url;

  GenreMovieModel({
    this.url,
  });

  factory GenreMovieModel.initial() {
    return GenreMovieModel(url: '',);
  }

}
