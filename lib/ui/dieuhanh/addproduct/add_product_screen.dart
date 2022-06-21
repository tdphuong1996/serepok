import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/AppThemes.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo sản phấm'),
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
                        textField("Tên sản phẩm"),
                        height(),
                        textField("Chủng loại"),
                        height(),
                        viewPrice(),
                        height(),
                        textField("Giá sỉ"),

                        height(),
                        textField("Địa lý"),
                        height(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
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
                        child: const Text('Tạo sản phẩm')),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget viewPrice() {
    return Row(
      children: [
        Expanded(flex: 4, child: textField("Giá bán")),
        SizedBox(width: 16,),
        Expanded(flex: 3, child: textFieldTap("Đơn vị"))

      ],
    );
  }

  Widget height() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget textField(
    String label,
  ) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(text: ""),
    );
  }

  Widget textFieldTap(String label) {
    return InkWell(
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(FontAwesomeIcons.angleDown)),
          controller: TextEditingController(text: ""),
        ),
      ),
    );
  }
}
