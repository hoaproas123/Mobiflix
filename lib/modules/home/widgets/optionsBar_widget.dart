
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:mobi_phim/widgets/widgets.dart';
class OptionsBarWidget extends StatelessWidget {
  const OptionsBarWidget({
    required this.controller,
    super.key,
  });
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 30,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [
                const SizedBox(
                  child: Hero(tag: TagString.CLOSE, child: SizedBox()),
                ),
              ] + List.generate(controller.listOptionView.length, (index) {
                return controller.listOptionView[index].type=='TextButton' ?
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Hero(
                      tag: controller.listOptionView[index].optionName.toString(),
                      child: TextButton(
                        onPressed: () => controller.onOptionButtonPress(index),
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 1),
                          // minimumSize: const Size(40, 15)
                        ),
                        child: Text(
                          controller.listOptionView[index].optionName.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    :
                const SizedBox();
              },)
                  +[
                    SizedBox(
                        child: Obx(() {
                          return Hero(
                            tag: controller.listOptionView[4].optionName.toString(),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Nền trong suốt
                                borderRadius: BorderRadius.circular(15), // Bo tròn góc
                                border: Border.all(
                                  color: Colors.white, // Viền màu trắng
                                  width: 1, // Độ dày của viền
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: PopupMenuButton<int>(
                                  constraints: const BoxConstraints(
                                    maxWidth: 100, // Chiều rộng tối đa
                                    maxHeight: 300,
                                  ),
                                  offset: const Offset(-30,0),
                                  position: PopupMenuPosition.over,
                                  color: Colors.transparent.withOpacity(0.8),

                                  onSelected: (int result) =>controller.onSelectYear(result,controller.listOptionView[4].optionName.toString()),
                                  itemBuilder: (context) {
                                    return List.generate(controller.listYear.length, (index) {
                                      return PopupMenuItem<int>(
                                        value: index,
                                        child: Text(controller.listYear[index].toString(),style: const TextStyle(color: Colors.white),),
                                      );
                                    });
                                  },
                                  child: Text(
                                    controller.selectYear.value,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },)
                    ),
                    WidgetSize.sizedBoxWidth_5,
                    SizedBox(
                        child: Obx(() {
                          return Hero(
                            tag: controller.listOptionView[5].optionName.toString(),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Nền trong suốt
                                borderRadius: BorderRadius.circular(15), // Bo tròn góc
                                border: Border.all(
                                  color: Colors.white, // Viền màu trắng
                                  width: 1, // Độ dày của viền
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: PopupMenuButton<int>(
                                  constraints: const BoxConstraints(
                                    maxWidth: 150, // Chiều rộng tối đa
                                    maxHeight: 300,
                                  ),
                                  offset: const Offset(-50,0),
                                  position: PopupMenuPosition.over,
                                  color: Colors.transparent.withOpacity(0.8),
                                  onSelected: (int result) => controller.onSelectCountry(result,controller.listOptionView[5].optionName.toString()),
                                  itemBuilder: (context) {
                                    return List.generate(controller.listCountry.length, (index) {
                                      return PopupMenuItem<int>(
                                        value: index,
                                        child: Text(controller.listCountry[index].name!,style: const TextStyle(color: Colors.white),),
                                      );
                                    });
                                  },
                                  child: Text(
                                    controller.selectCountry.value,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },)
                    ),
                  ]
          ),
        ),
      ),
    );
  }
}

