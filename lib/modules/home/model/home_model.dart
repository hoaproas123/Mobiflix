class HomeModel  {
  String? url;

  HomeModel({
    this.url,
  });

  factory HomeModel.initial() {
    return HomeModel(url: '',);
  }

}
