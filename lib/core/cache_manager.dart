import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCacheManager extends CacheManager {
  static const key = "customCache";

  static MyCacheManager instance = MyCacheManager._();

  MyCacheManager._()
      : super(
    Config(
      key,
      stalePeriod: Duration(days: 1), // Xóa ảnh cũ sau 7 ngày
      maxNrOfCacheObjects: 100, // Tối đa lưu 50 ảnh
      // maxSize: 100 * 1024 * 1024, // Giới hạn cache 100MB
    ),
  );
}