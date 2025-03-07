import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobi_phim/constant/app_interger.dart';

abstract class AppColors {
  static final Color white = Color(0xffffffff);
  static final Color black = Color(0x00000000);
  static final Color DEFAULT_APPBAR_COLOR=Color(0xFF141E30);
  static final List<Color> DEFAULT_BACKGROUND_COLORS=[ const Color(0xFF141E30), // Xanh đen đậm
                                                      const Color(0xFF243B55), // Xanh than
                                                      const Color(0xFF2B2E4A), // Tím than
                                                      const Color(0xFF1B1B2F), // Đen xanh đậm
                                                      const Color(0xFF121212), // Đen thuần
                                                      const Color(0xFF0F0F0F), // Đen xám
                                                      const Color(0xFF232526), // Xám khói
                                                    ];
  static List<Color> TEXT_ANIMATION_COLORS(HSLColor color,{int length=4}) => List.generate(length, (index) {
    double lightness =color.lightness * (1 - (index * 0.25)); // Giảm 15% mỗi bước
    return color.withLightness(lightness.clamp(0.0, 1.0)).toColor();
  },);
  static List<Color> LINEAR_BACKGROUND_COLORS(HSLColor color,{int length=AppNumber.DEFAULT_NUMBER_OF_COLOR}) => List.generate(length, (index) {
    double lightness = color.lightness * (1 - (index * 0.17)); // Giảm 15% mỗi bước
    return color.withLightness(lightness.clamp(0.0, 1.0)).toColor();
  },);
}
