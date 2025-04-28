import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_colors.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/models/user_model.dart';
import 'package:mobi_phim/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _controllerMove;
  late Animation<double> _animationMove;
  final int letterCount = 8; // MOBIFLIX có 8 chữ cái
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Animation chạy trong 8 giây
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controllerMove = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation chạy trong 8 giây
    )..forward();

    _animationMove = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controllerMove, curve: Curves.easeIn),
    );
    Future.delayed(const Duration(seconds: AppNumber.NUMBER_OF_DURATION_WAIT_SPLASH_SCREEN_SECONDS),() async {
      Get.offAndToNamed(Routes.LOGIN);
    },);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: context.height,
        width: context.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.DEFAULT_BACKGROUND_COLORS,
            begin: Alignment.topCenter,  // Bắt đầu từ trên
            end: Alignment.bottomCenter, // Kết thúc ở dưới
          ),
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: MobiflixPainter(progress: _animation.value, letterCount: letterCount,moveProgress: _animationMove.value),
              size: const Size(400, 100),
            );
          },
        ),
      ),
    );
  }
}

class MobiflixPainter extends CustomPainter {
  final double progress;
  final int letterCount;
  final double moveProgress;

  MobiflixPainter({required this.progress, required this.letterCount,required this.moveProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 15 // Giảm độ dày nét vẽ
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    List<Path> letterPaths = [];

    // Chữ "M"
    Path mPath = Path();
    mPath.moveTo(-27, 60);
    mPath.lineTo(-13, 0);
    mPath.lineTo(-3, 60);
    mPath.moveTo(-3, 60);
    mPath.lineTo(9, 0);
    mPath.lineTo(21, 60);
    letterPaths.add(mPath);


    // Chữ "O"
    Path oPath = Path();
    oPath.addOval(Rect.fromCircle(center: const Offset(67, 35), radius: 30));
    letterPaths.add(oPath);

    // Chữ "B"
    Path bPath = Path();
    bPath.moveTo(120, 10);
    bPath.lineTo(120, 63);
    bPath.moveTo(120, 10);
    bPath.arcToPoint(const Offset(142, 28), radius: const Radius.circular(9), clockwise: true);
    bPath.moveTo(137, 28);
    bPath.arcToPoint(const Offset(142, 63), radius: const Radius.circular(9), clockwise: true);
    letterPaths.add(bPath);

    // Chữ "I"
    Path iPath1 = Path();
    iPath1.moveTo(175, 3);
    iPath1.lineTo(175, 63);
    letterPaths.add(iPath1);

    // Chữ "F"
    Path fPath = Path();
    fPath.moveTo(198, 3);
    fPath.lineTo(198, 63);
    fPath.moveTo(198, 3);
    fPath.lineTo(211, 3);
    fPath.moveTo(198, 33);
    fPath.lineTo(211, 33);
    letterPaths.add(fPath);

    // Chữ "L"
    Path lPath = Path();
    lPath.moveTo(235, 3);
    lPath.lineTo(235, 63);
    lPath.moveTo(235, 63);
    lPath.lineTo(248, 63);
    letterPaths.add(lPath);

    // Chữ "I"
    Path iPath2 = Path();
    iPath2.moveTo(268, 3);
    iPath2.lineTo(268, 63);
    letterPaths.add(iPath2);

    // Chữ "X"
    Path xPath = Path();
    xPath.moveTo(292, 3);
    xPath.lineTo(318, 63);
    xPath.moveTo(318, 3);
    xPath.lineTo(292, 63);
    letterPaths.add(xPath);

    double segmentProgress = progress * letterCount;
    int currentLetter = segmentProgress.floor();
    double partialProgress = segmentProgress - currentLetter;

    double offsetX = size.width -50 +100*currentLetter;

    for (int i = 0; i < currentLetter; i++) {
      canvas.save();
      canvas.translate(50 , 0); // Giảm khoảng cách giữa chữ đi 10 đơn vị
      canvas.drawPath(letterPaths[i], paint);
      canvas.restore();
    }

    if (currentLetter < letterCount) {
      PathMetrics metrics = letterPaths[currentLetter].computeMetrics();
      Path animatedPath = Path();
      for (var metric in metrics) {
        animatedPath.addPath(metric.extractPath(0, metric.length * partialProgress), Offset.zero);
      }
      canvas.save();
      canvas.translate(offsetX*moveProgress+50, 0); // Giảm khoảng cách 10 đơn vị
      canvas.drawPath(animatedPath, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}