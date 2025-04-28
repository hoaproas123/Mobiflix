import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  static Duration duration = const Duration(seconds: 2);

  static void showLoadingIndicator({required String message}) {
    Get.dialog(
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void closeLoadingIndicator() {
    Get.back();
  }

  static Future<dynamic> showSuccess(
      {required String title,
      required String? message,
      required String buttonText}) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message ?? ""),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(buttonText),
            onPressed: () => Get.back(),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<dynamic> showConfirm({
    required String title,
    required String? message,
    required String buttonTextOK,
    required String buttonTextNO,
    required onPressedOK,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message ?? ""),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(buttonTextNO),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            child: Text(buttonTextOK),
            onPressed: onPressedOK,
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<dynamic> showError(
      {required String title,
      required String message,
      required String buttonText}) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(buttonText),
            onPressed: () => Get.back(),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  // static Future<dynamic> showDetails(
  //     {required String image, required String data}) {
  //   return Get.dialog(
  //     Scaffold(
  //       body: SingleChildScrollView(
  //         child: Stack(
  //           children: [
  //             Container(
  //               height: 219,
  //               width: double.infinity,
  //               decoration: BoxDecoration(color: Colors.yellow),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     height: 60,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () => Get.back(),
  //                           icon: Icon(
  //                             Icons.clear_sharp,
  //                             color: Colors.white,
  //                           )),
  //                       Text(
  //                         FlutterI18n.translate(
  //                             Get.context!, "newsDetail.title"),
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 24),
  //                       ),
  //                     ],
  //                   ),
  //                   Text(
  //                     FlutterI18n.translate(
  //                         Get.context!, "newsDetail.describe"),
  //                     style: TextStyle(color: Colors.white, fontSize: 20),
  //                   ),
  //                   Container(
  //                     height: 400,
  //                     width: double.infinity,
  //                     margin: EdgeInsets.only(
  //                         left: 10, right: 10, top: 5, bottom: 5),
  //                     decoration: BoxDecoration(
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Color.fromRGBO(0, 0, 0, 0.3),
  //                               spreadRadius: 1,
  //                               blurRadius: 5,
  //                               offset: Offset(0, 3)),
  //                         ],
  //                         borderRadius: BorderRadius.all(Radius.circular(10)),
  //                         color: Colors.white,
  //                         image: image != null
  //                             ? DecorationImage(
  //                                 image: NetworkImage(
  //                                   "${dotenv.env['APIURL']}" + "$image",
  //                                 ),
  //                                 fit: BoxFit.cover,
  //                                 onError: (dynamic exception, stackTrace) {
  //                                   return null;
  //                                 })
  //                             : null),
  //                   ),
  //                   GlobalStyles.sizedBoxHeight,
  //                   // Html(
  //                   //   data: data,
  //                   //   onLinkTap: (String? url, RenderContext context,
  //                   //       Map<String, String> attributes, element) async {
  //                   //     if (url != null) {
  //                   //       await launchUrl(Uri.parse(url),
  //                   //           mode: LaunchMode.externalApplication);
  //                   //     }
  //                   //   },
  //                   //   style: {
  //                   //     '#': Style(
  //                   //       fontSize: FontSize(14),
  //                   //     ),
  //                   //     "body": Style(
  //                   //       padding: EdgeInsets.zero,
  //                   //     )
  //                   //   },
  //                   // )
  //                 ],
  //               ),
  //             ),
  //             GlobalStyles.sizedBoxHeight_30,
  //           ],
  //         ),
  //       ),
  //     ),
  //     useSafeArea: false,
  //     barrierDismissible: false,
  //   );
  // }
  //
  // static Future<dynamic> showReply({
  //   required TextEditingController controller,
  //   required String hintText,
  //   required Function onPressed,
  //   required double width,
  // }) {
  //   return Get.bottomSheet(
  //     SafeArea(
  //       child: Container(
  //         height: 100,
  //         color: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 hintText,
  //                 maxLines: null,
  //               ),
  //               Expanded(
  //                 child: TextFieldComment(
  //                   height: 70.0,
  //                   width: width,
  //                   hintText: hintText,
  //                   controller: controller,
  //                   onPressed: onPressed,
  //                   autofocus: true,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // static Future<dynamic> showImageModal(
  //     {required String appbarTitle,
  //     required List<dynamic>? imageList,
  //     required int index}) {
  //   return Get.generalDialog(
  //     barrierColor: Colors.white,
  //     barrierDismissible: false,
  //     pageBuilder: (_, __, ___) {
  //       return SizedBox.expand(
  //         child: Scaffold(
  //             appBar: AppBar(
  //               backgroundColor: Colors.transparent,
  //               centerTitle: true,
  //               elevation: 0,
  //               leading: IconButton(
  //                 icon: Icon(
  //                   Icons.arrow_back_outlined,
  //                   size: 20,
  //                   color: AppColors.greenPrimary,
  //                 ),
  //                 onPressed: () => Get.back(),
  //               ),
  //               title: Text(
  //                 appbarTitle,
  //                 style: TextStyle(
  //                   color: AppColors.greenPrimary,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               automaticallyImplyLeading: false,
  //             ),
  //             body: PageView.builder(
  //                 itemCount: imageList!.length,
  //                 controller: PageController(initialPage: index),
  //                 itemBuilder: (context, index) {
  //                   return PhotoView(
  //                     imageProvider: NetworkImage(
  //                         "${dotenv.env['APIURL']}" + imageList[index]!),
  //                   );
  //                 })),
  //       );
  //     },
  //   );
  // }
  //
  // static Future<dynamic> showSelectImage({title}) {
  //   /* -- 1 for camera
  //      -- 2 for photo
  //    */
  //   return Get.bottomSheet(
  //     SafeArea(
  //         child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 5),
  //           decoration: BoxDecoration(
  //               color: Color(0xffF1F1F1),
  //               borderRadius: BorderRadius.circular(15)),
  //           child: CupertinoActionSheet(
  //               title: Column(
  //                 children: [
  //                   Text(
  //                     title ?? "",
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 10),
  //                     child: Text(
  //                         FlutterI18n.translate(Get.context!, "COMMON.choose")),
  //                   ),
  //                 ],
  //               ),
  //               actions: [
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 6),
  //                   child: CupertinoDialogAction(
  //                     child: Text(
  //                       FlutterI18n.translate(
  //                           Get.context!, "COMMON.chooseCamera"),
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w600, fontSize: 18),
  //                     ),
  //                     onPressed: () => Get.back(result: "Camera"),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 1),
  //                   child: CupertinoDialogAction(
  //                     child: Text(
  //                       FlutterI18n.translate(
  //                           Get.context!, "COMMON.chooseImage"),
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w500, fontSize: 18),
  //                     ),
  //                     onPressed: () => Get.back(result: "Image"),
  //                   ),
  //                 ),
  //               ]),
  //         ),
  //         Container(
  //           margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
  //           height: 60,
  //           decoration: BoxDecoration(
  //               color: Color(0xffF1F1F1),
  //               borderRadius: BorderRadius.circular(14)),
  //           child: CupertinoActionSheet(actions: [
  //             CupertinoDialogAction(
  //               child: Center(
  //                 child: Text(
  //                   FlutterI18n.translate(Get.context!, "COMMON.cancel"),
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //                 ),
  //               ),
  //               onPressed: () => Get.back(),
  //             ),
  //           ]),
  //         )
  //       ],
  //     )),
  //     isScrollControlled: true,
  //   );
  // }
  //
  // static Future<dynamic> showErrorMap({
  //   required String title,
  //   required String? message,
  //   required String? choose,
  //   required String? map,
  //   required String buttonTextOK,
  //   required onPressedOK,
  // }) {
  //   return showDialog(
  //     context: Get.context!,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title, style: TextStyle(fontSize: 20)),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           Text(message ?? "", style: TextStyle(fontSize: 18)),
  //           GlobalStyles.sizedBoxHeight_10,
  //           Text(
  //             "${FlutterI18n.translate(context, "map.chooseAddress")} $choose",
  //             style: TextStyle(fontSize: 18, color: Colors.red),
  //             textAlign: TextAlign.start,
  //           ),
  //           GlobalStyles.sizedBoxHeight_10,
  //           Text(
  //             "${FlutterI18n.translate(context, "map.mapAddress")} $map",
  //             style: TextStyle(fontSize: 18, color: Colors.red),
  //             textAlign: TextAlign.start,
  //           ),
  //         ],
  //       ),
  //       actions: <Widget>[
  //         CupertinoDialogAction(
  //           child: Text(buttonTextOK),
  //           onPressed: onPressedOK,
  //         )
  //       ],
  //     ),
  //     barrierDismissible: true,
  //   );
  // }
  //
  // static Future<dynamic> showTotalPrice({
  //   required int totalPriceOrder,
  //   required int feeTransport,
  //   required int totalPayment,
  //   int? voucher,
  //   String? nameVoucher,
  // }) {
  //   return Get.bottomSheet(
  //     SafeArea(
  //       child: Container(
  //         color: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 FlutterI18n.translate(
  //                     Get.context!, "informationOrder.detailPaymentOrder"),
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.greenPrimary,
  //                 ),
  //               ),
  //               Divider(thickness: 2),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     FlutterI18n.translate(
  //                         Get.context!, "informationOrder.totalPriceOrder"),
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: AppColors.grayLight,
  //                     ),
  //                   ),
  //                   Text(
  //                     NumberFormat.currency(
  //                             locale: "vi-VN",
  //                             symbol: FlutterI18n.translate(
  //                                 Get.context!, "buyNow.VND"))
  //                         .format(totalPriceOrder),
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: AppColors.grayLight,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Divider(),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     FlutterI18n.translate(
  //                         Get.context!, "informationOrder.feeTransport"),
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: AppColors.grayLight,
  //                     ),
  //                   ),
  //                   Text(
  //                     NumberFormat.currency(
  //                             locale: "vi-VN",
  //                             symbol: FlutterI18n.translate(
  //                                 Get.context!, "buyNow.VND"))
  //                         .format(feeTransport),
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: AppColors.grayLight,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               voucher != 0 ? Divider() : SizedBox(),
  //               voucher != 0
  //                   ? Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "${FlutterI18n.translate(Get.context!, "informationOrder.voucher")}${nameVoucher ?? ""}",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: AppColors.grayLight,
  //                           ),
  //                         ),
  //                         Text(
  //                           NumberFormat.currency(
  //                                   locale: "vi-VN",
  //                                   symbol: FlutterI18n.translate(
  //                                       Get.context!, "buyNow.VND"))
  //                               .format(voucher),
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: AppColors.grayLight,
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   : SizedBox(),
  //               Divider(thickness: 2),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     FlutterI18n.translate(
  //                         Get.context!, "informationOrder.totalPayment"),
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 12,
  //                       color: AppColors.black,
  //                     ),
  //                   ),
  //                   Text(
  //                     NumberFormat.currency(
  //                             locale: "vi-VN",
  //                             symbol: FlutterI18n.translate(
  //                                 Get.context!, "buyNow.VND"))
  //                         .format(totalPayment),
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 12,
  //                       color: AppColors.black,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // static Future<dynamic> showConfirmDialog({detail}) {
  //   return showDialog(
  //     context: Get.context!,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(FlutterI18n.translate(context, "COMMON.CONFIRM")),
  //       content: Text(detail ?? ""),
  //       actions: <Widget>[
  //         CupertinoDialogAction(
  //           child: Text(FlutterI18n.translate(context, "COMMON.OK")),
  //           onPressed: () => Get.back(result: true),
  //         ),
  //         CupertinoDialogAction(
  //           child: Text(FlutterI18n.translate(context, "COMMON.CANCEL")),
  //           onPressed: () => Get.back(result: false),
  //         )
  //       ],
  //     ),
  //     barrierDismissible: false,
  //   );
  // }
  //
  // static Future<dynamic> showImageModalFile(
  //     {required String appbarTitle,
  //     required List<dynamic>? imageList,
  //     required int index}) {
  //   return Get.generalDialog(
  //     barrierColor: Colors.white,
  //     barrierDismissible: false,
  //     pageBuilder: (_, __, ___) {
  //       return SizedBox.expand(
  //         child: Scaffold(
  //             appBar: AppBar(
  //               backgroundColor: Colors.transparent,
  //               centerTitle: true,
  //               elevation: 0,
  //               leading: IconButton(
  //                 icon: Icon(
  //                   Icons.arrow_back_outlined,
  //                   size: 20,
  //                   color: AppColors.greenPrimary,
  //                 ),
  //                 onPressed: () => Get.back(),
  //               ),
  //               title: Text(
  //                 appbarTitle,
  //                 style: TextStyle(
  //                   color: AppColors.greenPrimary,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               automaticallyImplyLeading: false,
  //             ),
  //             body: PageView.builder(
  //                 itemCount: imageList!.length,
  //                 controller: PageController(initialPage: index),
  //                 itemBuilder: (context, index) {
  //                   return PhotoView(
  //                     imageProvider: FileImage(imageList[index]),
  //                   );
  //                 })),
  //       );
  //     },
  //   );
  // }
  //
  // static Future<dynamic> showChooseProductReview(
  //     {title, required List<ProductModel> listProduct}) {
  //   /* -- 1 for camera
  //      -- 2 for photo
  //    */
  //   return Get.bottomSheet(
  //     PopScope(
  //       canPop: true, //When false, blocks the current route from being popped.
  //       child: SafeArea(
  //           child: Container(
  //         height: MediaQuery.of(Get.context!).size.height / 2,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(16.0),
  //                 topRight: Radius.circular(16.0))),
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(fontSize: 16, color: AppColors.yellowPrimary),
  //             ),
  //             GlobalStyles.sizedBoxHeight_30,
  //             Container(
  //               height: MediaQuery.of(Get.context!).size.height / 2 - 90,
  //               child: ListView.builder(
  //                 scrollDirection: Axis.vertical,
  //                 shrinkWrap: true,
  //                 itemCount: listProduct.length,
  //                 itemBuilder: (context, index) {
  //                   final productModel = listProduct[index];
  //                   return InkWell(
  //                     onTap: () => Get.back(result: index),
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Container(
  //                               height: 50,
  //                               width: 50,
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(8.0),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                       color: Color.fromRGBO(0, 0, 0, 0.3),
  //                                       spreadRadius: 1,
  //                                       blurRadius: 5,
  //                                       offset: Offset(0, 3)),
  //                                 ],
  //                                 image: DecorationImage(
  //                                   image: NetworkImage(
  //                                       "${dotenv.env['APIURL']}" +
  //                                           "${productModel.image}"),
  //                                   fit: BoxFit.fill,
  //                                 ),
  //                               ),
  //                             ),
  //                             GlobalStyles.sizedBoxWidth_10,
  //                             Expanded(
  //                               child: Container(
  //                                 height: 50,
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   mainAxisSize: MainAxisSize.max,
  //                                   children: [
  //                                     Text(
  //                                       productModel.name ?? "",
  //                                       style: TextStyle(
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.bold,
  //                                         color: AppColors.greenPrimary,
  //                                       ),
  //                                       maxLines: 3,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                           child: Divider(thickness: 2),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       )),
  //     ),
  //     isScrollControlled: true,
  //   );
  // }
}
