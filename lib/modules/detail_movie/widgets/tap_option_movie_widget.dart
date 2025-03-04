
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/modules/detail_movie/controller/detail_controller.dart';
import 'package:mobi_phim/routes/app_pages.dart';

class BuildTabOption extends StatelessWidget {
  const BuildTabOption({
    super.key,
    required this.controller,
    required this.heightEpisodes,
    required this.listEpisodes,
  });

  final DetailController controller;
  final double heightEpisodes;
  final List<EpisodesMovieModel>? listEpisodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => TabBar(
          controller: controller.tabController,
          labelColor: controller.hslText.value.withLightness(0.4).toColor(),
          unselectedLabelColor: Colors.white,
          dividerColor: Colors.white,
          indicatorColor: controller.hslText.value.withLightness(0.4).toColor(),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: MovieString.LIST_EPISODE_TITLE),
            Tab(text: MovieString.RELATED_CONTENT_TITLE),
          ],
        ),),
        SizedBox(
          height: AppNumber.DEFAULT_HEIGHT_OF_FATHER_TABBAR +heightEpisodes,
          child: TabBarView(
            controller: controller.tabController, // Điều khiển nội dung tab
            children: [
              Container(
                alignment: listEpisodes![0].server_data!.length <=5 ? Alignment.centerLeft : Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: TabBar(
                        controller: controller.tabEpisodeController,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white,
                        dividerColor: Colors.black,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: List.generate(listEpisodes!.length, (index) {
                          return Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: controller.hslText.value.withLightness(0.2+index*0.2).toColor(),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Tab(text: listEpisodes![index].server_name));
                        },)
                      ),
                    ),
                    SizedBox(
                      height: AppNumber.DEFAULT_HEIGHT_OF_CHILD_TABBAR +heightEpisodes,
                      child: TabBarView(
                        controller: controller.tabEpisodeController, // Điều khiển nội dung tab
                        children: List.generate(listEpisodes!.length, (server) {
                          return Wrap(
                            spacing: 5,

                            children: List.generate(listEpisodes![server].server_data!.length, (episode) {
                              return TextButton(
                                onPressed: (){
                                  controller.saveEpisode(server,episode);
                                  Get.toNamed(Routes.PLAY_MOVIE,arguments: [server,episode,controller.slug,listEpisodes]);
                                },
                                style: ButtonStyle(
                                    padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                                    shape: WidgetStatePropertyAll(RoundedRectangleBorder( // Hình dạng button
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.2)),
                                    backgroundColor: WidgetStatePropertyAll(controller.hslText.value.withLightness(0.2+server*0.2).toColor()),
                                    elevation: const WidgetStatePropertyAll(10),
                                    minimumSize: const WidgetStatePropertyAll(Size(60,35))

                                ),
                                child: Text(
                                  listEpisodes![server].server_data![episode].name!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.width/30
                                  ),
                                ),
                              );
                            },),
                          );
                        },),
                      ),
                    ),
                  ]
                ),
              ),
              const Center(child: Text('Favorites Screen')),
            ],
          ),
        ),
      ],
    );
  }
}
