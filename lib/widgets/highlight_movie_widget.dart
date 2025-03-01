
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/core/cache_manager.dart';
import 'package:mobi_phim/models/episodes_movie.dart';
import 'package:mobi_phim/services/domain_service.dart';
import 'package:mobi_phim/widgets/loading_screen_widget.dart';
class HighlightMovieWidget extends StatelessWidget {
  const HighlightMovieWidget({
    required this.controller,
    this.url=true,

    super.key,
  });
  final controller;
  final bool url;
  @override
  Widget build(BuildContext context) {
    return controller.firstMovieItem==null ?
    Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 280,
          height: 400,
          child: Card(
              elevation: 50,
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              child: CardHighLightLoading()
          ),
        ),
      ),
    )
        :
      Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 400,
                child: FadeIn(
                  duration: const Duration(seconds: 1),
                  child: Card(
                    elevation: 50,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: controller.firstMovieItem==null ?
                    const SizedBox()
                    :
                    CachedNetworkImage(
                      imageUrl: url == true ? controller.firstMovieItem?.poster_url ?? "" : DomainProvider.imgUrl + controller.firstMovieItem!.poster_url!,
                      cacheManager: MyCacheManager.instance,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>CardHighLightLoading(),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                      imageBuilder: (context, imageProvider) => Ink.image(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        child: InkWell(
                          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.1)),
                          onTap: () {
                            Get.toNamed('home/detailMovie', arguments: controller.firstMovieItem?.slug ?? "");
                          },
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                  width: 130,
                  bottom: 30,
                  child: Center(
                    child: MaterialButton(
                      onPressed: () async {
                        String slug= controller.firstMovieItem.slug;
                        List<EpisodesMovieModel>? listEpisodes= controller.listEpisodesMovieFromSlug;
                        List inforSave=await controller.getSavedEpisode(slug);
                        int server = int.parse(inforSave[0]);
                        int episode = int.parse(inforSave[1]);
                        controller.saveEpisode(server,episode+1);
                        // print(controller.firstMovieItem.slug);
                        Get.toNamed('home/detailMovie/playMovie', arguments: [server,episode+1, slug,listEpisodes]);
                      },
                      color: Colors.white,
                      child: const Row(
                        children: [
                          Icon(Icons.play_arrow,color: Colors.black,size: 30,),
                          SizedBox(width: 5,),
                          Text('Phát',style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
          Container(
            width: context.width-30,
            alignment: Alignment.center,
            child: Text(
              controller.firstMovieItem?.name?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],

      ),
    );
  }
}

