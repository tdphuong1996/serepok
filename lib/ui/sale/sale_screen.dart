import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serepok/res/AppThemes.dart';
import 'package:serepok/ui/sale/createorder/create_order_screen.dart';
import 'package:serepok/ui/sale/donchodonchot/don_cho_screen.dart';

import '../../routes.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _listPage = <Widget>[
    CreateOrderScreen(),
    DonChoScreen(),
    DonChoScreen(),
    DonChoScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bán hàng'),
        leading: Container(),

      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartPlus),
            label: 'Tạo đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.hourglassEnd),
            label: 'Đơn chờ',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.dollyBox),
            label: 'Đơn chốt',
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
