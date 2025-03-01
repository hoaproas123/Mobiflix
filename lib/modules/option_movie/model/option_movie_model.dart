class OptionMovieModel  {
  String? url;

  OptionMovieModel({
    this.url,
  });

  factory OptionMovieModel.initial() {
    return OptionMovieModel(url: '',);
  }

}
