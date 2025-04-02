
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/option_movie/controller/option_movie_controller.dart';
import 'package:mobi_phim/widgets/widgets.dart';

import '../../../data/country_data.dart';
import '../../../data/option_view_data.dart';
class OptionsBarWidget extends StatelessWidget {
  const OptionsBarWidget({
    required this.controller,
    super.key,
  });
  final OptionMovieController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  8.0),
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Hero(
              tag: TagString.CLOSE,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      side: const BorderSide(color: Colors.white, width: 1),
                      minimumSize: const Size(30, 30),
                    ),
                    onPressed: () => Get.back(),
                    child: const Icon(Icons.close,color: Colors.white,size: 15,)),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Hero(
                  tag: controller.tag,
                  child: TextButton(
                    onPressed: (){},
                    style:  ButtonStyle(
                        side: const WidgetStatePropertyAll(BorderSide(color: Colors.white, width: 1)),
                        // minimumSize: const WidgetStatePropertyAll(Size(40, 15)),
                        backgroundColor: WidgetStatePropertyAll(Colors.grey.withOpacity(0.4))
                    ),
                    child: Text(
                      controller.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10
                      ),
                    ),
                  ),
                ),
              ),
            ),
            controller.tag==DefaultString.YEAR ? const SizedBox() :
            SizedBox(
                child: Obx(() {
                  return Hero(
                    tag: listOption[4].optionName.toString(),
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

                          onSelected: (int result) => controller.onSelectYear(result),
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
            controller.tag ==DefaultString.COUNTRY ? const SizedBox() :
            SizedBox(
                child: Obx(() {
                  return Hero(
                    tag: listOption[5].optionName.toString(),
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
                          onSelected: (int result) => controller.onSelectCountry(result),
                          itemBuilder: (context) {
                            return List.generate(countryList.length, (index) {
                              return PopupMenuItem<int>(
                                value: index,
                                child: Text(countryList[index].name!,style: const TextStyle(color: Colors.white),),
                              );
                            });
                          },
                          child: Text(
                            controller.selectCountry.value.name!,
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
          ],
        ),
      ),
    );
  }
}

