
import 'package:flutter/material.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/widgets/list_movie_widget.dart';
import 'package:mobi_phim/widgets/widgets.dart';

class UserPage extends GetView<HomeController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.black,
          child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                context.orientation==Orientation.portrait ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WidgetSize.sizedBoxHeight_15,
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image.network(
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/icon/unknown_user.png',fit: BoxFit.fill,color: Colors.white,);
                        },
                        controller.user?.urlAvatar??'',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                          child: Text(
                            controller.user?.name?? 'Người dùng không xác định',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.edit,color: Colors.white,size: 15,)
                          ),
                        ),
                      ],
                    ),
                    WidgetSize.sizedBoxHeight_15,
                    ListMovieWidget(title: MovieString.LIST_CONTINUE_MOVIE_WATCH_TITLE,controller: controller,listType: ListType.CONTINUE_MOVIE_WATCH,),
                    ListMovieWidget(title: MovieString.LIST_FAVORITE_MOVIE_WATCH_TITLE,controller: controller,listType: ListType.FAVORITE_MOVIE,),
                  ],
                )
                    :
                SizedBox(
                  height: context.height*0.8,
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      if(value==3) {
                        controller.accessScroll.value= !controller.accessScroll.value;
                      }
                    },
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 125,
                            width: 125,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Image.network(
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/icon/unknown_user.png',fit: BoxFit.fill,color: Colors.white,);
                              },
                              controller.user?.urlAvatar??'',
                              fit: BoxFit.fill,
                            ),
                          ),

                          WidgetSize.sizedBoxWidth_15,
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                                child: Text(
                                  controller.user?.name?? 'Người dùng không xác định',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.edit,color: Colors.white,size: 15,)
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListMovieWidget(title: MovieString.LIST_CONTINUE_MOVIE_WATCH_TITLE,controller: controller,listType: ListType.CONTINUE_MOVIE_WATCH,),
                      ListMovieWidget(title: MovieString.LIST_FAVORITE_MOVIE_WATCH_TITLE,controller: controller,listType: ListType.FAVORITE_MOVIE,),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }
}




