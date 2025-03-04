import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlinkingBorderController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController borderController;
  late Animation<double> borderAnimation;

  @override
  void onInit() {
    borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Tốc độ nhấp nháy
    )..repeat(reverse: true); // Lặp lại hiệu ứng

    borderAnimation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(parent: borderController, curve: Curves.easeInOut),
    );

    super.onInit();
  }

  @override
  void onClose() {
    borderController.dispose();
    super.onClose();
  }
}

class CardHighLightLoading extends StatelessWidget {
  final BlinkingBorderController controller = Get.put(BlinkingBorderController());

  CardHighLightLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.borderAnimation,
      builder: (context, child) {
        return Container(
            width: 280,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(controller.borderAnimation.value), // Viền nhấp nháy
                width: 1,
              ),
                borderRadius: BorderRadius.circular(15)
            ),
        );
      },);

  }
}
class CardItemLoading extends StatelessWidget {
  final BlinkingBorderController controller = Get.put(BlinkingBorderController());

  CardItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.borderAnimation,
      builder: (context, child) {
        return Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(controller.borderAnimation.value), // Viền nhấp nháy
              width: 1,
            ),
          borderRadius: BorderRadius.circular(15)
          ),
        );
      },);

  }
}
class VideoLoading extends StatelessWidget {
  final BlinkingBorderController controller = Get.put(BlinkingBorderController());

  VideoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.borderAnimation,
      builder: (context, child) {
        return Container(
          height: context.height,
          width: context.width,
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: Colors.white.withOpacity(controller.borderAnimation.value)),
        );
      },);

  }
}