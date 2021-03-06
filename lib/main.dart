import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/order_model.dart';
import 'package:serepok/model/product_model.dart';
import 'package:serepok/model/staff.dart';
import 'package:serepok/res/AppThemes.dart';
import 'package:serepok/res/constant.dart';
import 'package:serepok/routes.dart';
import 'package:serepok/ui/auth/login_provider.dart';
import 'package:serepok/ui/auth/login_screen.dart';
import 'package:serepok/ui/dieuhanh/addemployee/add_employee_screen.dart';
import 'package:serepok/ui/dieuhanh/addemployee/staff_provider.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_provider.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_screen.dart';
import 'package:serepok/ui/dieuhanh/addproduct/list_product_screen.dart';
import 'package:serepok/ui/dieuhanh/qr/enter_phone_transport_screen.dart';
import 'package:serepok/ui/dieuhanh/qr/qr_code_screen.dart';
import 'package:serepok/ui/dieuhanh/transport_screen.dart';
import 'package:serepok/ui/home/common_widget_screen.dart';
import 'package:serepok/ui/sale/createorder/choose_product_screen.dart';
import 'package:serepok/ui/sale/createorder/create_order_screen.dart';
import 'package:serepok/ui/sale/createorder/order_provider.dart';
import 'package:serepok/ui/sale/donchodonchot/don_cho_screen.dart';
import 'package:serepok/ui/sale/sale_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/dieuhanh/dieu_hanh_screen.dart';
import 'ui/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => StaffProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderProvider(),
      ),
    ], child: const MyApp()),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 60000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(Constant.PREF_USER);
    return user != null;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppThemes.theme(),
            routes: {
              Routes.HOME_SCREEN: (context) => const MyHomePage(title: ""),
              Routes.DIEU_HANH_SCREEN: (context) => const DieuHanhScreen(),
              Routes.LOGIN_SCREEN: (context) => const LoginScreen(),
              Routes.ADD_EMPLOYEE: (context) =>  AddEmployeeScreen(ModalRoute.of(context)!.settings.arguments as StaffModel),
              Routes.SALE_SCREEN: (context) => const SaleScreen(),
              Routes.TRANSPORT_SCREEN: (context) => const TransportScreen(),
              Routes.CHOOSE_PRODUCT: (context) => const ChooseProductScreen(),
              Routes.ADD_PRODUCT: (context) =>  AddProductScreen(ModalRoute.of(context)!.settings.arguments as ProductModel?),
              Routes.CREATE_ORDER: (context) =>  CreateOrderScreen(ModalRoute.of(context)!.settings.arguments as OrderModel?),
              Routes.LIST_PRODUCT: (context) =>  ListProductScreen(ModalRoute.of(context)!.settings.arguments as String?),
              Routes.DON_CHO_SCREEN: (context) =>  const DonChoScreen(OrderType.PENDING),
              Routes.QR_CODE_SCREEN: (context) =>  const QRCodeScreen(),
              Routes.ENTER_PHONE_TRANSPORT_SCREEN: (context) =>  EnterPhoneTransportScreen(ModalRoute.of(context)!.settings.arguments as List<OrderModel>?),
              Routes.COMMON_SCREEN: (context) =>
                  const CommonWidgetPage(title: "Common"),
            },
            initialRoute: snapshot.data == true
                ? Routes.HOME_SCREEN
                : Routes.LOGIN_SCREEN,
            builder: EasyLoading.init(),
          );
        } else {
          return Container(
            color: Colors.white,
          );
        }
      },
    );
  }
}
