import 'package:flutter/material.dart';
import 'package:serepok/model/product_model.dart';
import 'package:serepok/res/constant.dart';
import 'package:serepok/ui/dieuhanh/addproduct/list_product_screen.dart';

class ChooseProductScreen extends StatefulWidget {
  const ChooseProductScreen({Key? key}) : super(key: key);

  @override
  State<ChooseProductScreen> createState() => _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn sản phẩm'),
      ),
      body: const ListProductScreen("SELECT"),
    );
  }

  void itemProductClick(ProductModel product) {
    Navigator.pop(context, product);
  }
}
