
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/option_movie/model/option_movie_model.dart';

import '../provider/option_movie_provider.dart';


class OptionMovieRepository {
  final OptionMovieProvider optionMovieProvider;

  OptionMovieRepository({required this.optionMovieProvider});

  Future<BaseResponse?> loadData(OptionMovieModel optionMovieModel) =>
      optionMovieProvider.loadData(optionMovieModel);
}
