import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serepok/ui/dieuhanh/transport/approved_order_screen.dart';
import 'package:serepok/ui/dieuhanh/transport/complete_order_screen.dart';
import 'package:serepok/ui/dieuhanh/transport/transport_order_screen.dart';

import '../../res/AppThemes.dart';
import '../../routes.dart';
import '../sale/empty_screen.dart';

class TransportScreen extends StatefulWidget{
  const TransportScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransportScreen();
}

class _TransportScreen extends State<TransportScreen>{
  int _selectedIndex = 0;
  static final List<Widget> _listPage = <Widget>[
    const ApprovedOrderScreen(),
    const TransportOrderScreen(),
    const EmptyScreen(),
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
      if (index == 2) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Vận chuyển'),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: InkWell(
                child: const Icon(FontAwesomeIcons.qrcode),
                onTap: () => {Navigator.of(context).pushNamed(Routes.QR_CODE_SCREEN)},
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
            icon: Icon(FontAwesomeIcons.hourglassEnd),
            label: 'Đơn chờ vận chuyển',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.truckFast),
            label: 'Đơn đang vận chuyển',
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

  void _scanQRCode(){}
}