class DetailModel  {
  String? url;

  DetailModel({
    this.url,
  });

  factory DetailModel.initial() {
    return DetailModel(url: '',);
  }

}
