import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobi_phim/data/country_data.dart';
import 'package:mobi_phim/data/option_view_data.dart';
import 'package:mobi_phim/models/movies_model.dart';
import 'package:mobi_phim/modules/option_movie/controller/option_movie_controller.dart';
import 'package:mobi_phim/widgets/highlight_movie_widget.dart';
import 'package:mobi_phim/widgets/list_movie_widget.dart';


class OptionMovieView extends GetView<OptionMovieController> {
  const OptionMovieView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => AppBar(
          backgroundColor: controller.backgroundColor.value == Colors.white ?  const Color(0xFF141E30) :controller.backgroundColor.value,
          elevation: 0,
          leading: const BackButton(color: Colors.white,style: ButtonStyle(iconSize: WidgetStatePropertyAll(30)),),
          title: Text(
            controller.tag,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){
                String addYearQuery=controller.selectYear.value=='Năm' ? '':'&year=${controller.selectYear.value}';
                String addCountryQuery=controller.selectCountry.value.slug=='Quốc Gia' ? '' : '&country=${controller.selectCountry.value.slug}';
                String addQuery= addYearQuery + addCountryQuery;
                Get.toNamed('/home/search',arguments: [controller.backgroundColor.value,controller.hsl.value,addQuery]);
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),),
      ),

      body: Obx(() {
        return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: controller.backgroundColor.value == Colors.white ?
                [
                  const Color(0xFF141E30), // Xanh đen đậm
                  const Color(0xFF243B55), // Xanh than
                  const Color(0xFF2B2E4A), // Tím than
                  const Color(0xFF1B1B2F), // Đen xanh đậm
                  const Color(0xFF121212), // Đen thuần
                  const Color(0xFF0F0F0F), // Đen xám
                  const Color(0xFF232526), // Xám khói
                ]
                    :
                List.generate(6, (index) {
                  double lightness = controller.hsl.value.lightness * (1 - (index * 0.17)); // Giảm 15% mỗi bước
                  return controller.hsl.value.withLightness(lightness.clamp(0.0, 1.0)).toColor();
                }),
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Builder(
                builder: (context) {
                  return ListView(
                      children: [
                        const SizedBox(height: 15,),
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Hero(
                                tag: 'close',
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      side: const BorderSide(color: Colors.white, width: 1),
                                      minimumSize: const Size(30, 30),
                                    ),
                                    onPressed: (){
                                      Get.back();
                                    },
                                    child: const Icon(Icons.close,color: Colors.white,size: 15,)),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Hero(
                                    tag: controller.tag,
                                    child: TextButton(
                                      onPressed: (){},
                                      style: TextButton.styleFrom(
                                          side: const BorderSide(color: Colors.white, width: 1),
                                          minimumSize: const Size(40, 15)
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
                              controller.tag=='Năm' ? const SizedBox() :
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
                                        
                                          onSelected: (int result) {
                                            controller.onSelectYear(result);
                                          },
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
                              const SizedBox(width: 5,),
                              controller.tag =='Quốc Gia' ? const SizedBox() :
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
                                          onSelected: (int result) {
                                            controller.onSelectCountry(result);
                                          },
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
                        HighlightMovieWidget(controller: controller,url: false,),
                        GetBuilder<OptionMovieController>(builder: (controller) {
                          return Column(
                            children: [
                              controller.tag =='Năm' || controller.selectYear.value!='Năm' || controller.selectCountry.value.name!='Quốc Gia' ? const SizedBox() :
                              controller.tag =='Quốc Gia' ? ListMovieWidget(title: "Phim ${controller.title} Mới Cập Nhật",controller: controller,url: false,isHome:false) :
                              ListMovieWidget(title: "${controller.tag} Mới Cập Nhật",controller: controller,url: false,isHome: false,),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.listMovieModel.length,
                                itemBuilder: (context, index) {
                                  MoviesModel moviesModel=controller.listMovieModel[index];
                                  int? len=moviesModel.pagination?.totalPages;
                                  return len == 0 ? const SizedBox() : ListMovieWidget(title: (moviesModel.title)??"",index: index,controller: controller,isHome: false,);
                                },),
                            ],
                          );
                        },)
                      ]
                  );
                }
            )
        );
      },)
    );
  }
}