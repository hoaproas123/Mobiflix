abstract class DomainProvider {
  static const String newUpdateMovie = "/danh-sach/phim-moi-cap-nhat";
  static const String newUpdateMovieV2 = "/danh-sach/phim-moi-cap-nhat-v2";
  static const String detailMovie = "/phim/";
  static const String tvSeries = "/v1/api/danh-sach/phim-bo";
  static const String movies = "/v1/api/danh-sach/phim-le";
  static const String cartoonMovies = "/v1/api/danh-sach/hoat-hinh";
  static const String tvShows = "/v1/api/danh-sach/tv-shows";
  static const String moviesByYear = "/v1/api/nam/";
  static const String moviesByCountry = "/v1/api/quoc-gia/";
  static const String moviesByGenre = "/v1/api/";
  static const String listGenre = "/the-loai";
  static const String imgUrl = "https://phimimg.com/";
  static const String search = "/v1/api/tim-kiem?keyword=";
  static const String limit20 = "&limit=20";
  static const String limit40 = "&limit=40";
  static const String limit60 = "&limit=60";
  static const String limit80 = "&limit=80";
  static const String limit100 = "&limit=100";
}

abstract class PlusProvider {
  static const String LIST = "list";

}
