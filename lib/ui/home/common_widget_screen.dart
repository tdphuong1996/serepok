import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serepok/res/AppThemes.dart';

import '../../routes.dart';

class CommonWidgetPage extends StatefulWidget {
  const CommonWidgetPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CommonWidgetPage> createState() => _CommonWidgetPageState();
}

class _CommonWidgetPageState extends State<CommonWidgetPage> {

  late ThemeData theme;
  @override
  void initState() {
    super.initState();
    theme = AppThemes.theme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder:
                  theme.inputDecorationTheme.focusedBorder,
                ),
                controller:
                TextEditingController(text: "Natalia Dyer"),


              ),
              SizedBox(height: 16,),
              CupertinoButton(
                  color: MyColor.PRIMARY_COLOR,
                  onPressed: () {},
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  padding: EdgeInsets.only(top: 8,left: 32,right: 32, bottom: 8),
                  pressedOpacity: 0.5,
                  child: Text('Click nè')),
            ],
          ),
        )

    );
  }

}
