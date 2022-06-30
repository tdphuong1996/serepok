import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/ui/dieuhanh/addproduct/add_product_provider.dart';

import '../../../res/AppThemes.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late ProductProvider _productProvider;

  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context,listen: false);
  }

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
                        imageProduct(),
                        height(),
                        textField("Tên sản phẩm"),
                        height(),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 4,
                          decoration:
                              InputDecoration(labelText: 'Thông tin sản phẩm'),
                        ),
                        height(),
                        textField("Chủng loại"),
                        height(),
                        viewPrice(),
                        height(),
                        textField("Giá sỉ"),
                        height(),
                        textField("Địa lý"),
                        height(),
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
                          _productProvider.createProduct();
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
        SizedBox(
          width: 16,
        ),
        Expanded(flex: 3, child: textFieldTap("Đơn vị"))
      ],
    );
  }

  Widget imageProduct() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey.shade200,
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
