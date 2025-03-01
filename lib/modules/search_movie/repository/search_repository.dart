
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/search_movie/model/search_model.dart';

import '../provider/search_provider.dart';


class SearchRepository {
  final SearchProvider searchProvider;

  SearchRepository({required this.searchProvider});

  Future<BaseResponse?> loadData(SearchModel searchModel) =>
      searchProvider.loadData(searchModel);
}
