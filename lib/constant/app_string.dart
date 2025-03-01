abstract class AppString {
  static const String APP_NAME = "Mobiflix";
  static const String PLAY_BUTTON = "Phát";
  static const String NEXT_EPISODE_BUTTON = "Tập Tiếp Theo";
  static const String LIST_EPISODE_BUTTON = "Các Tập";
  static const String SEARCH_HINT_TITLE = "Tìm kiếm phim, tác phẩm...";
}

abstract class DefaultString {
  static const String YEAR = 'Năm';
  static const String COUNTRY = 'Quốc Gia';
  static const String NULL = '';
}

abstract class AppReponseString {
  static const String STATUS_SUCCESS = "success";
  static const String STATUS_TRUE = "true";
}
abstract class CommonString {
  static const String ERROR = "Lỗi!";
  static const String ERROR_DATA_MESSAGE = "Lỗi dữ liệu";
  static const String ERROR_URL_MESSAGE = "Lỗi đường dẫn";
  static const String CANCEL = "Cancel";
}

abstract class MoviePaginationString {
  static const String CURRENT_PAGE = "currentPage";
  static const String TOTAL_PAGE = "totalPages";

}

abstract class MovieString {
  static const String NEW_UPDATE_TITLE = "Phim Mới Cập Nhật";
  static const String MOVIE = "Movie";
  static const String TV_SERIES = "TV Series";
  static const String STATUS_COMPLETED = "completed";
  static const String SHOW_COMPLETED_STATUS = "Hoàn Thành";
  static const String ACTORS_TITLE = "Diễn viên";
  static const String GENRE_TITLE = "Thể loại";
  static const String DIRECTOR_TITLE = "Đạo diễn";
  static const String COUNTRY_TITLE = "Quốc gia";
  static const String DURATION_TITLE = "Thời lượng";
  static const String LIST_EPISODE_TITLE = "Các Tập";
  static const String RELATED_CONTENT_TITLE = "Nội dung tương tự";
  static String NEW_UPDATE_TITLE_COUNTRY (String countryName) => "Phim ${countryName} Mới Cập Nhật";
  static String NEW_UPDATE_TITLE_OPTION (String optionName) => "${optionName} Mới Cập Nhật";

}
abstract class TagString {
  static const String CLOSE = "close";
}

