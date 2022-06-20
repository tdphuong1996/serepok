import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serepok/res/AppThemes.dart';
import 'package:serepok/ui/dieuhanh/addemployee/add_employee_screen.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_screen.dart';
import 'package:serepok/ui/dieuhanh/report/report_screen.dart';

import '../../widget/customnavigation/custom_bottom_navigation.dart';

class DieuHanhScreen extends StatefulWidget {
  const DieuHanhScreen({Key? key}) : super(key: key);


  @override
  State<DieuHanhScreen> createState() => _DieuHanhScreenState();
}

class _DieuHanhScreenState extends State<DieuHanhScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _listPage = <Widget>[
   AddEmployeeScreen(),
   AddProductScreen(),
   ReportScreen(),
   ReportScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều hành'),
      ),
      body: IndexedStack(
       index: _selectedIndex,
        children: _listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userPlus),
            label: 'Tạo nhân viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.circlePlus),
            label: 'Tạo sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clipboardList),
            label: 'Báo cáo',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Trang chủ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:MyColor.PRIMARY_COLOR,
        unselectedItemColor:MyColor.PRIMARY_COLOR.withAlpha(50),
        onTap: _onItemTapped,
      ),
    );
  }

}
