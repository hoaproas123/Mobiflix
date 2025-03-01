
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/detail_movie/model/detail_model.dart';
import 'package:mobi_phim/modules/detail_movie/provider/detail_provider.dart';


class DetailRepository {
  final DetailProvider detailProvider;

  DetailRepository({required this.detailProvider});

  Future<BaseResponse?> loadData(DetailModel detailModel) =>
      detailProvider.loadData(detailModel);
}
