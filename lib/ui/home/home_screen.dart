import 'package:flutter/material.dart';
import 'package:serepok/res/AppThemes.dart';

import '../../routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                alignment: Alignment.topCenter,
                child: Column(
                  children: [slide(), menuMain()],
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.greenAccent,
                  child: Text("Box I"),
                )),
          ],
        ));
  }

  Widget slide() {
    return Container(
      height: 200,
      width: double.infinity,
      child: Text("Slide"),
    );
  }

  Widget menuMain() {
    return Container(
      height: 100,
      color: MyColor.ACCENT_COLOR,
      width: double.infinity,
      child: Column(
        children: [
          InkWell(child: Text("Dieu hanh"),onTap: ()=>{
            Navigator.of(context).pushNamed(Routes.DIEU_HANH_SCREEN)
          }),
          InkWell(child: Text("common"),onTap: ()=>{
            Navigator.of(context).pushNamed(Routes.COMMON_SCREEN)
          })
        ],
      ),
    );
  }
}
