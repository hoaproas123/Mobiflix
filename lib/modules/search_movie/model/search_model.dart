class SearchModel  {
  String? url;

  SearchModel({
    this.url,
  });

  factory SearchModel.initial() {
    return SearchModel(url: '',);
  }

}
