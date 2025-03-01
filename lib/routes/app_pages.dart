// import 'package:get/get.dart';
// import 'package:vua_gao/app/modules/dashboard/bindings/dashboard_binding.dart';
// import 'package:vua_gao/app/modules/dashboard/views/dashboard_view.dart';
// // import 'package:vua_gao/app/modules/account/bindings/account_binding.dart';
// // import 'package:vua_gao/app/modules/account/views/account_view.dart';
// // import 'package:vua_gao/app/modules/account_detail/bindings/account_detail_binding.dart';
// // import 'package:vua_gao/app/modules/account_detail/views/account_detail_view.dart';
// // import 'package:vua_gao/app/modules/address/bindings/address_binding.dart';
// // import 'package:vua_gao/app/modules/address/views/address_view.dart';
// // import 'package:vua_gao/app/modules/buy_now/bindings/buy_now_binding.dart';
// // import 'package:vua_gao/app/modules/buy_now/views/buy_now_view.dart';
// // import 'package:vua_gao/app/modules/buy_now/views/list_address_view.dart';
// // import 'package:vua_gao/app/modules/buy_now/views/list_pay_method_view.dart';
// // import 'package:vua_gao/app/modules/buy_now/views/list_shipping_mothod_view.dart';
// // import 'package:vua_gao/app/modules/buy_now/views/list_voucher_view.dart';
// // import 'package:vua_gao/app/modules/card/bindings/card_binding.dart';
// // import 'package:vua_gao/app/modules/card/views/card_view.dart';
// // import 'package:vua_gao/app/modules/confirm_password/bindings/confirm_password_binding.dart';
// // import 'package:vua_gao/app/modules/confirm_password/views/confirm_password_view.dart';
// // import 'package:vua_gao/app/modules/forgot_password/bindings/forgot_password_binding.dart';
// // import 'package:vua_gao/app/modules/forgot_password/views/changed_password_view.dart';
// // import 'package:vua_gao/app/modules/forgot_password/views/email_view.dart';
// // import 'package:vua_gao/app/modules/forgot_password/views/forgot_password_view.dart';
// // import 'package:vua_gao/app/modules/forgot_password/views/otp_view.dart';
// // import 'package:vua_gao/app/modules/forgot_password/views/sms_view.dart';
// // import 'package:vua_gao/app/modules/forgot_password/views/success_view.dart';
// import 'package:vua_gao/app/modules/home/bindings/home_binding.dart';
// import 'package:vua_gao/app/modules/home/views/home_view.dart';
// // import 'package:vua_gao/app/modules/information_order/bindings/information_order_binding.dart';
// // import 'package:vua_gao/app/modules/information_order/views/information_order_view.dart';
// // import 'package:vua_gao/app/modules/information_shipping/bindings/information_shipping_binding.dart';
// // import 'package:vua_gao/app/modules/information_shipping/views/information_shipping_view.dart';
// import 'package:vua_gao/app/modules/init/bindings/init_binding.dart';
// import 'package:vua_gao/app/modules/init/views/init_view.dart';
// // import 'package:vua_gao/app/modules/list_product/bindings/list_product_binding.dart';
// // import 'package:vua_gao/app/modules/list_product/views/list_product_view.dart';
// // import 'package:vua_gao/app/modules/map/bindings/map_binding.dart';
// // import 'package:vua_gao/app/modules/news/bindings/news_binding.dart';
// // import 'package:vua_gao/app/modules/news/views/news_view.dart';
// // import 'package:vuagao_ecommerce/app/modules/news_detail/bindings/news_detail_binding.dart';
// // import 'package:vua_gao/app/modules/news_detail/views/news_detai_view.dart';
// import 'package:vua_gao/app/modules/notification/bindings/notification_binding.dart';
// import 'package:vua_gao/app/modules/notification/views/notification_view.dart';
// // import 'package:vua_gao/app/modules/place_autocomplete/bindings/place_autocomplete_binding.dart';
// // import 'package:vua_gao/app/modules/place_autocomplete/views/place_autocomplete_view.dart';
// // import 'package:vua_gao/app/modules/product_detail/bindings/product_detail_binding.dart';
// // import 'package:vua_gao/app/modules/product_detail/views/product_detail_view.dart';
// // import 'package:vua_gao/app/modules/product_review/bindings/product_review_binding.dart';
// import 'package:vua_gao/app/modules/sign_up/bindings/sign_up_binding.dart';
// import 'package:vua_gao/app/modules/sign_up/views/sign_up_view.dart';
// import 'package:vua_gao/app/modules/splash/bindings/splash_binding.dart';
// import 'package:vua_gao/app/modules/splash/views/splash_view.dart';
//
// // import '../modules/forgot_password_account/bindings/forgot_password_account_binding.dart';
// // import '../modules/forgot_password_account/views/forgot_password_account_view.dart';
// // import '../modules/forgot_password_account/views/new_password_account_view.dart';
// // import '../modules/forgot_password_account/views/otp_account_view.dart';
// // import '../modules/forgot_password_account/views/resend_password_account_view.dart';
// // import '../modules/map/views/map_view.dart';
// // import '../modules/product_review/views/product_review_view.dart';
// import '../modules/forgot_password/bindings/forgot_password_binding.dart';
// import '../modules/forgot_password/views/forgot_password_view.dart';
// import '../modules/sign_in/bindings/sign_in_binding.dart';
// import '../modules/sign_in/views/sign_in_view.dart';
//
// part 'app_routes.dart';
//
// class AppPages {
//   static const INITIAL = Routes.SPLASH;
//
//   static final routes = [
//     GetPage(
//       name: _Paths.SPLASH,
//       page: () => SplashView(),
//       binding: SplashBinding(),
//     ),
//     GetPage(
//       name: _Paths.INIT,
//       page: () => InitView(),
//       binding: InitBinding(),
//     ),
//     GetPage(
//       name: _Paths.SIGN_UP,
//       page: () => SignUpView(),
//       binding: SignUpBinding(),
//     ),
//     GetPage(
//       name: _Paths.LOGIN,
//       page: () => SignInView(),
//       binding: SignInBinding(),
//     ),
//     GetPage(
//       name: _Paths.FORGOT_PASSWORD,
//       page: () => ForgotPasswordView(),
//       binding: ForgotPasswordBinding(),
//       // children: [
//       //   GetPage(
//       //     name: _Paths.SMS,
//       //     page: () => SmsView(),
//       //     binding: ForgotPasswordBinding(),
//       //   ),
//       //   GetPage(
//       //     name: _Paths.EMAIL,
//       //     page: () => EmailView(),
//       //     binding: ForgotPasswordBinding(),
//       //   ),
//       //   GetPage(
//       //     name: _Paths.OTP,
//       //     page: () => OtpView(),
//       //     binding: ForgotPasswordBinding(),
//       //   ),
//       //   GetPage(
//       //     name: _Paths.CHANGED_PASSWORD,
//       //     page: () => ChangedPasswordView(),
//       //     binding: ForgotPasswordBinding(),
//       //   ),
//       //   GetPage(
//       //     name: _Paths.SUCCESS,
//       //     page: () => SuccessView(),
//       //     binding: ForgotPasswordBinding(),
//       //   ),
//       // ],
//     ),
//     GetPage(
//       name: _Paths.HOME,
//       page: () => HomeView(),
//       bindings: [
//         HomeBinding(),
//         DashboardBinding(),
//       ]
//     ),
//     // GetPage(
//     //   name: _Paths.NEWS_DETAIL,
//     //   page: () => NewsDetailView(),
//     //   binding: NewsDetailBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.ACCOUNT_DETAIL,
//     //   page: () => AccountDetailView(),
//     //   binding: AccountDetailBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.LIST_PRODUCTS,
//     //   page: () => ListProductView(),
//     //   binding: ListProductBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.INFORMATION_ORDER,
//     //   page: () => InformationOrderView(),
//     //   binding: InformationOrderBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.PRODUCTS_DETAIL,
//     //   page: () => ProductDetailView(),
//     //   binding: ProductDetailBinding(),
//     //   preventDuplicates: false,
//     // ),
//     // GetPage(
//     //   name: _Paths.INFORMATION_SHIPPING,
//     //   page: () => InformationShippingView(),
//     //   binding: InformationShippingBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.PRODUCT_REVIEW,
//     //   page: () => ProductReviewView(),
//     //   binding: ProductReviewBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.ADDRESS,
//     //   page: () => AddressView(),
//     //   binding: AddressBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.BUY_NOW,
//     //   page: () => BuyNowView(),
//     //   binding: BuyNowBinding(),
//     //   children: [
//     //     GetPage(
//     //       name: _Paths.LIST_ADDRESS,
//     //       page: () => ListAddressView(),
//     //       binding: BuyNowBinding(),
//     //     ),
//     //     GetPage(
//     //       name: _Paths.LIST_SHIPPING_METHOD,
//     //       page: () => ListShippingMethodView(),
//     //       binding: BuyNowBinding(),
//     //     ),
//     //     GetPage(
//     //       name: _Paths.LIST_VOUCHER,
//     //       page: () => ListVoucherView(),
//     //       binding: BuyNowBinding(),
//     //     ),
//     //     GetPage(
//     //       name: _Paths.LIST_PAY_METHOD,
//     //       page: () => ListPayMethodView(),
//     //       binding: BuyNowBinding(),
//     //     ),
//     //   ],
//     // ),
//     // GetPage(
//     //   name: _Paths.GOOGLE_MAP,
//     //   page: () => MapView(),
//     //   binding: MapBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.PLACE_AUTOCOMPLETE,
//     //   page: () => PlaceAutocompleteView(),
//     //   binding: PlaceAutocompleteBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.CONFIRM_PASSWORD,
//     //   page: () => ConfirmPasswordView(),
//     //   binding: ConfirmPasswordBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.FORGOT_PASSWORD_ACCOUNT,
//     //   page: () => ForgotPasswordAccountView(),
//     //   binding: ForgotPasswordAccountBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.RESEND_PASSWORD_ACCOUNT,
//     //   page: () => ResendPasswordAccountView(),
//     //   binding: ForgotPasswordAccountBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.NEW_PASSWORD_ACCOUNT,
//     //   page: () => NewPasswordAccountView(),
//     //   binding: ForgotPasswordAccountBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.OTP_ACCOUNT,
//     //   page: () => OtpAccountView(),
//     //   binding: ForgotPasswordAccountBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.DISCOUNT,
//     //   page: () => DiscountView(),
//     //   binding: NotificationBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.ACTIVATE,
//     //   page: () => ActivateView(),
//     //   binding: NotificationBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.NEWS,
//     //   page: () => NewsView(),
//     //   binding: NewsBinding(),
//     // ),
//     GetPage(
//       name: _Paths.NOTIFICATION,
//       page: () => NotificationView(),
//       binding: NotificationBinding(),
//     ),
//     // GetPage(
//     //   name: _Paths.CART,
//     //   page: () => CardView(),
//     //   binding: CardBinding(),
//     // ),
//     // GetPage(
//     //   name: _Paths.ACCOUNT,
//     //   page: () => AccountView(),
//     //   binding: AccountBinding(),
//     // ),
//   ];
// }
