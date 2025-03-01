import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobi_phim/modules/detail_movie/bindings/detail_binding.dart';
import 'package:mobi_phim/modules/detail_movie/view/detail_movie_view.dart';
import 'package:mobi_phim/modules/genre_movie/bindings/genre_movie_binding.dart';
import 'package:mobi_phim/modules/genre_movie/view/genre_movie_view.dart';
import 'package:mobi_phim/modules/home/bindings/home_binding.dart';
import 'package:mobi_phim/modules/home/view/home_view.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/modules/option_movie/bindings/option_movie_binding.dart';
import 'package:mobi_phim/modules/option_movie/view/option_movie_view.dart';
import 'package:mobi_phim/modules/play_movie/bindings/play_movie_binding.dart';
import 'package:mobi_phim/modules/play_movie/view/play_movie_view.dart';
import 'package:mobi_phim/modules/search_movie/bindings/search_binding.dart';
import 'package:mobi_phim/modules/search_movie/view/search_view.dart';
import 'package:mobi_phim/modules/splash/view/splash_screen.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: '.env.prod');
  } else {
    await dotenv.load(fileName: '.env.dev');
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: '/home',//màn hình mặc định khi chạy app, được dẫn bằng name router

    locale: const Locale('pt', 'BR'),
    getPages: [
    //   GetPage(name: '/login', page: () => LogInView()
    //       ,binding: LogInBinding()
    //   ),

      //Simple GetPage
      GetPage(
        name: '/splash',
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => const HomeView(),
        binding: HomeBinding(),
        children: [
          GetPage(
              name: '/search',
              page: () =>const SearchView(),
              binding: SearchBinding(),
              transition: Transition.rightToLeft,
          ),
          GetPage(
            name: '/detailMovie',
            page: () => const DetailMovieView(),
            binding: DetailBinding(),
            transition: Transition.rightToLeft,
            children: [
              GetPage(
                  name: '/playMovie',
                  page: () => const PlayMovieView(),
                  binding: PlayMovieBinding(),
                  transition: Transition.rightToLeft
              )
            ]
          ),
          GetPage(
              name: '/optionMovie',
              page: () => const OptionMovieView(),
              binding: OptionMovieBinding(),
              transition: Transition.noTransition,
              transitionDuration: const Duration(milliseconds: 500)

          ),
          GetPage(
              name: '/genreMovie',
              page: () => const GenreMovieView(),
              binding: GenreMovieBinding(),
              transition: Transition.noTransition,
              transitionDuration: const Duration(milliseconds: 500)
          ),
        ]
      ),

    ],
  ));
}

