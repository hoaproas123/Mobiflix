import 'package:mobi_phim/models/option_view_model.dart';
import 'package:mobi_phim/services/domain_service.dart';

List<OptionViewModel> listOption = [
  OptionViewModel(optionName: 'Phim Bộ',url: DomainProvider.tvSeries,type: 'TextButton'),
  OptionViewModel(optionName: 'Phim Lẻ',url: DomainProvider.movies,type: 'TextButton'),
  OptionViewModel(optionName: 'Hoạt Hình',url: DomainProvider.cartoonMovies,type: 'TextButton'),
  OptionViewModel(optionName: 'TV Show',url: DomainProvider.tvShows,type: 'TextButton'),
  OptionViewModel(optionName: 'Năm',url: DomainProvider.moviesByYear,type: 'PopupMenuButton'),
  OptionViewModel(optionName: 'Quốc Gia',url: DomainProvider.moviesByCountry,type: 'PopupMenuButton'),

];