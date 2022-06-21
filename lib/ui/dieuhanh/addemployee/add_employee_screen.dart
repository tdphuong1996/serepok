import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/AppThemes.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo nhân viên'),
      ),
      body: GestureDetector(
        onPanDown: (pd) {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        height(),
                        avatar(),
                        height(),
                        textField("Họ và tên"),
                        height(),
                        textField("Số điện thoại"),
                        textField("Email"),
                        textField("Mật khẩu"),
                        textField("Nhập lại mật khẩu"),
                        height(),
                        textFieldTap("Phân quyền"),
                        height(),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoButton(
                        color: MyColor.PRIMARY_COLOR,
                        onPressed: () {
                          print("ss");
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        padding: const EdgeInsets.only(
                            top: 8, left: 32, right: 32, bottom: 8),
                        pressedOpacity: 0.5,
                        child: const Text('Tạo nhân viên')),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget height() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget avatar() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.red,
    );
  }

  Widget textField(String label,) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: ""),
    );
  }


  Widget textFieldTap(String label) {
    return InkWell(
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(labelText: label,suffixIcon: Icon(FontAwesomeIcons.angleDown)),
          controller: TextEditingController(text: ""),
        ),
      ),
    );
  }
}
