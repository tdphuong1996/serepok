import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/product_model.dart';

import 'add_product_provider.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late ProductProvider _productProvider;

  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _productProvider.listProduct.length,
      itemBuilder: (context, index) {
        return item(_productProvider.listProduct[index]);
      },
    );
  }

  Widget item(ProductModel product) {
    return InkWell(
      onTap: () => {

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: Image.network(product.imageUrl)),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                ],
              ),
            )),
            const SizedBox(
              height: 60,
              width: 30,
              child:
                  Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
