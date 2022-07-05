import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serepok/res/AppThemes.dart';
import 'package:serepok/ui/dieuhanh/addemployee/add_employee_screen.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_screen.dart';
import 'package:serepok/ui/dieuhanh/report/report_screen.dart';

import '../../model/staff.dart';
import '../../routes.dart';
import '../../widget/customnavigation/custom_bottom_navigation.dart';
import 'addemployee/list_employee_screen.dart';
import 'addproduct/list_product_screen.dart';

class DieuHanhScreen extends StatefulWidget {
  const DieuHanhScreen({Key? key}) : super(key: key);

  @override
  State<DieuHanhScreen> createState() => _DieuHanhScreenState();
}

class _DieuHanhScreenState extends State<DieuHanhScreen> {
  int _selectedIndex = 0;
  static  final List<Widget> _listPage = <Widget>[
    const ListEmployeeScreen(),
    const ListProductScreen(""),
    const ReportScreen(),
    const ReportScreen(),
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
      if (index==3) {
        Navigator.pop(context);

      }
    });
  }

  void _add() {

    if (_selectedIndex==0) {
      Navigator.of(context)
          .pushNamed(Routes.ADD_EMPLOYEE, arguments: StaffModel(id: 0, name: "", email: "", phone: "", avatarUrl: "", staffType: 0));
    }else if (_selectedIndex == 1) {
      Navigator.of(context).pushNamed(Routes.ADD_PRODUCT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Điều hành'),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: InkWell(
                child: const Icon(FontAwesomeIcons.plus),
                onTap: () => {_add()},
              ),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.users),
            label: 'Nhân viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.boxesStacked),
            label: 'Sản phẩm',
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
        selectedItemColor: MyColor.PRIMARY_COLOR,
        unselectedItemColor: MyColor.PRIMARY_COLOR.withAlpha(50),
        onTap: _onItemTapped,
      ),
    );
  }
}
