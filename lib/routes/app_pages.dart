import 'package:get/get.dart';
import 'package:mobi_phim/modules/detail_movie/bindings/detail_binding.dart';
import 'package:mobi_phim/modules/detail_movie/view/detail_movie_view.dart';
import 'package:mobi_phim/modules/genre_movie/bindings/genre_movie_binding.dart';
import 'package:mobi_phim/modules/genre_movie/view/genre_movie_view.dart';
import 'package:mobi_phim/modules/home/bindings/home_binding.dart';
import 'package:mobi_phim/modules/home/view/home_view.dart';
import 'package:mobi_phim/modules/option_movie/bindings/option_movie_binding.dart';
import 'package:mobi_phim/modules/option_movie/view/option_movie_view.dart';
import 'package:mobi_phim/modules/play_movie/bindings/play_movie_binding.dart';
import 'package:mobi_phim/modules/play_movie/view/play_movie_view.dart';
import 'package:mobi_phim/modules/search_movie/bindings/search_binding.dart';
import 'package:mobi_phim/modules/search_movie/view/search_view.dart';
import 'package:mobi_phim/modules/splash/view/splash_screen.dart';




part 'app_routes.dart';

class AppPages {
  static const INITIAL = _Paths.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MOVIE,
      page: () =>const SearchView(),
      binding: SearchBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAIL_MOVIE,
      page: () => const DetailMovieView(),
      binding: DetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
        name: _Paths.PLAY_MOVIE,
        page: () => const PlayMovieView(),
        binding: PlayMovieBinding(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: _Paths.OPTION_MOVIE,
        page: () => const OptionMovieView(),
        binding: OptionMovieBinding(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 500)

    ),
    GetPage(
        name: _Paths.GENRE_MOVIE,
        page: () => const GenreMovieView(),
        binding: GenreMovieBinding(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 500)
    ),
  ];
}
