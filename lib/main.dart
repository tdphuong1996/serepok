import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:serepok/res/AppThemes.dart';
import 'package:serepok/routes.dart';
import 'package:serepok/ui/auth/login_provider.dart';
import 'package:serepok/ui/auth/login_screen.dart';
import 'package:serepok/ui/dieuhanh/addemployee/add_employee_screen.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_screen.dart';
import 'package:serepok/ui/home/common_widget_screen.dart';
import 'package:serepok/ui/sale/sale_screen.dart';

import 'ui/dieuhanh/dieu_hanh_screen.dart';
import 'ui/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider(),),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.theme(),
      routes: {
        Routes.HOME_SCREEN: (context) => const LoginScreen(),
        Routes.DIEU_HANH_SCREEN: (context) => const DieuHanhScreen(),
        Routes.LOGIN_SCREEN: (context) => const LoginScreen(),
        Routes.ADD_EMPLOYEE: (context) => const AddEmployeeScreen(),
        Routes.SALE_SCREEN: (context) => const SaleScreen(),
        Routes.ADD_PRODUCT: (context) => const AddProductScreen(),
        Routes.COMMON_SCREEN: (context) =>
            const CommonWidgetPage(title: "Common"),
      },
      initialRoute: Routes.HOME_SCREEN,
      builder: EasyLoading.init(),
    );
  }
}
