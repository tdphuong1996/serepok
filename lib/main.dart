import 'package:flutter/material.dart';
import 'package:serepok/res/AppThemes.dart';
import 'package:serepok/routes.dart';
import 'package:serepok/ui/dieuhanh/addemployee/add_employee_screen.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_screen.dart';
import 'package:serepok/ui/home/common_widget_screen.dart';
import 'package:serepok/ui/sale/sale_screen.dart';

import 'ui/dieuhanh/dieu_hanh_screen.dart';
import 'ui/home/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppThemes.theme() ,
        routes:  {
          Routes.HOME_SCREEN :(context)=> const MyHomePage(title: 'ssss',),
          Routes.DIEU_HANH_SCREEN :(context)=>  const DieuHanhScreen(),
          Routes.ADD_EMPLOYEE :(context)=>  const AddEmployeeScreen(),
          Routes.SALE_SCREEN :(context)=>  const SaleScreen(),
          Routes.ADD_PRODUCT :(context)=>  const AddProductScreen(),
          Routes.COMMON_SCREEN :(context)=>  const CommonWidgetPage(title: "Common"),
        },
        initialRoute: Routes.HOME_SCREEN  ,
      ),
    );
  }
}
