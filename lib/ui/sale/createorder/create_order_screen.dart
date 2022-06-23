import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/AppThemes.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      textField("Tên khách hàng"),
                      height(),
                      textField("Số điện thoại"),
                      height(),
                      textField("Địa chỉ"),
                      height(),
                      textField("Tên hàng"),
                      height(),
                      viewChungLoaiKhoiLuong(),
                      height(),
                      textField("Tổng tiền"),
                      height(),
                      header(),
                      height(),
                      paymentView(),
                      textField("Ghi chú"),
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
                      onPressed: () {},
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      padding: const EdgeInsets.only(
                          top: 8, left: 32, right: 32, bottom: 8),
                      pressedOpacity: 0.5,
                      child: const Text('Hoàn thành')),
                ),
              )
            ],
          )),
    );
  }

  Widget header() {
    return Row(
      children: const [
        Text(
          "Thanh toán",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
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

  Widget viewChungLoaiKhoiLuong() {
    return Row(
      children: [
        Expanded(flex: 1, child: textField("Chủng loại")),
        const SizedBox(
          width: 16,
        ),
        Expanded(flex: 1, child: textField("Khối lượng"))
      ],
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
              labelText: label, suffixIcon: Icon(FontAwesomeIcons.angleDown)),
          controller: TextEditingController(text: ""),
        ),
      ),
    );
  }

  Widget paymentView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         Row(
           children: [
             Expanded(
                 flex: 3,
                 child:  Row(
               children: [
                 Icon(
                   FontAwesomeIcons.circle,
                   color: MyColor.PRIMARY_COLOR,
                 ),
                 SizedBox(
                   width: 8,
                 ),
                 Text('Nhận đủ',style: TextStyle(fontSize: 16),),
               ],
             )),
             Expanded(
             flex: 3
             ,child: Container())
           ],
         ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child:  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.circle,
                        color: MyColor.PRIMARY_COLOR,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Tạm ứng',style: TextStyle(fontSize: 16),),
                    ],
                  )),
              Expanded(
                  flex: 3
                  ,child: textField("Số tiền "))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child:  Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.circle,
                        color: MyColor.PRIMARY_COLOR,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Thu hộ',style: TextStyle(fontSize: 16),),
                    ],
                  )),
              Expanded(
                  flex: 3
                  ,child: textField("Số tiền "))
            ],
          ),
        ],
      ),
    );
  }
}
