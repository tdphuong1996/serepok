import 'package:flutter/material.dart';
import 'package:serepok/res/AppThemes.dart';

import '../../res/images.dart';
import '../../routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicatorStatic() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(140),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(Images.imgBackground, fit: BoxFit.cover),
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [slide(), menuMain()],
                )),
          ],
        ));
  }

  Widget slide() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            child: PageView(
              pageSnapping: true,
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Container(
                      color: Colors.red,
                    )),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      color: Colors.yellow,
                    )),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicatorStatic(),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuMain() {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        GridView.count(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            childAspectRatio: 5 / 4,
            crossAxisSpacing: 20,
            children: <Widget>[
              itemMenu(
                  "ĐIỀU HÀNH",
                  Images.ic_dieu_hanh,
                  () =>
                      {Navigator.pushNamed(context, Routes.DIEU_HANH_SCREEN)}),
              itemMenu("BÁN HÀNG", Images.ic_ban_hang, () => {
                Navigator.pushNamed(context, Routes.SALE_SCREEN)
              }),
              itemMenu("VẬN CHUYỂN", Images.ic_van_chuyen, () => {}),
              itemMenu("KẾ TOÁN", Images.ic_ke_toan, () => {}),
              itemMenu("KỸ THUẬT", Images.ic_ky_thua, () => {}),
              itemMenu("HỖ TRỢ", Images.ic_ho_tro, () => {}),
              itemMenu("COMMON", Images.ic_ho_tro,
                  () => {Navigator.pushNamed(context, Routes.COMMON_SCREEN)}),
            ]),
      ],
    );
  }

  Widget itemMenu(String title, String icon, Function onClick) {
    return InkWell(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: 60,
              width: 60,
              color: Colors.yellow,
              child: Image.asset(icon),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(title)
        ],
      ),
      onTap: () => {onClick()},
    );
  }
}
