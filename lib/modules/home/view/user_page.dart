
import 'package:flutter/material.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:mobi_phim/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/services/db_mongo_service.dart';
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
                    GestureDetector(
                      onTap: () => controller.showSelectImageDialog(context),
                      child: Container(
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
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                            child: SizedBox(
                              width: (controller.usernameController.text.length+1)*14.0,
                              child: TextFormField(
                                controller: controller.usernameController,
                                enabled: controller.isEditName.value,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),
                                ) ,
                                onTapOutside: (event) {
                                  if(controller.isEditName.value==true){
                                    controller.isEditName.value= false;
                                    DbMongoService().updateNameProfile(controller.user!.username!, controller.usernameController.text);
                                  }
                                },
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white
                                ),
                                onChanged: (value) {

                                },
                                onEditingComplete: () {
                                  if(controller.isEditName.value==true){
                                    controller.isEditName.value= false;
                                    DbMongoService().updateNameProfile(controller.user!.username!, controller.usernameController.text);
                                  }
                                },
                              ),
                            ),
                          );
                        },),
                        controller.user!.canEdit ?
                        Positioned(
                          bottom: -10,
                          right: -20,
                          child: IconButton(
                              onPressed: (){
                                controller.isEditName.value= !controller.isEditName.value;
                              },
                              icon: Icon(Icons.edit,color: Colors.white,size: 15,)
                          ),
                        )
                          :
                        SizedBox(),
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




