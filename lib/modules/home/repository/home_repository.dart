
import 'package:mobi_phim/core/base_response.dart';
import 'package:mobi_phim/modules/home/model/home_model.dart';
import 'package:mobi_phim/modules/home/provider/home_provider.dart';


class HomeRepository {
  final HomeProvider homeProvider;

  HomeRepository({required this.homeProvider});

  Future<BaseResponse?> loadData(HomeModel homeModel) =>
      homeProvider.loadData(homeModel);
}
