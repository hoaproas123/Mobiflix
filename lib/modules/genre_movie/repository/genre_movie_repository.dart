
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/genre_movie/model/genre_movie_model.dart';
import '../provider/genre_movie_provider.dart';


class GenreMovieRepository {
  final GenreMovieProvider genreMovieProvider;

  GenreMovieRepository({required this.genreMovieProvider});

  Future<BaseResponse?> loadData(GenreMovieModel genreMovieModel) =>
      genreMovieProvider.loadData(genreMovieModel);
}
