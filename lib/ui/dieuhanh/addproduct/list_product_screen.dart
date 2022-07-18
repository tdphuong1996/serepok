import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/product_model.dart';
import 'package:serepok/res/AppThemes.dart';

import '../../../res/constant.dart';
import '../../../res/view.dart';
import '../../../routes.dart';
import 'add_product_provider.dart';

class ListProductScreen extends StatefulWidget {
  final String? _type;

  const ListProductScreen(this._type, {Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late ProductProvider _productProvider;
  late ScrollController _controller;
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;
  TypeActionList _typeAction = TypeActionList.SELECT;

  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.context = context;
    _productProvider.getListProduct();
    _controller = ScrollController();
    _controller.addListener(_loadMore);
    _productProvider.deleteProductSuccessCallback = () {
      showOkAlertDialog(
          context: context, message: 'Xoá sản phẩm thành công!');
      _refresh();
    };
    _typeAction = widget._type == "SELECT"
        ? _typeAction = TypeActionList.SELECT
        : TypeActionList.ADDEDIT;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, value, child) {
      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _controller,
                itemCount: _productProvider.listProduct.length,
                itemBuilder: (context, index) {
                  return item(_productProvider.listProduct[index]);
                },
              ),
            ),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    });
  }

  Future<void> itemClick(ProductModel product) async {
    if (_typeAction == TypeActionList.SELECT) {
      itemProductClick(product);
    } else {
      final result = await Navigator.pushNamed(context, Routes.ADD_PRODUCT,
          arguments: product);
      if (result != null) {
        showOkAlertDialog(
            context: context, message: 'Cập nhật thông tin thành công');
        _refresh();
      }
    }
  }

  void itemProductClick(ProductModel product) {
    Navigator.pop(context, product);
  }

  Widget item(ProductModel product) {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ImageNetwork(product.imageUrl!)),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name!),
                  const Spacer(), // I just added one line
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                        onTap: () => {itemClick(product)},
                        child: const Icon(Icons.edit,
                            color: MyColor.PRIMARY_COLOR)),
                  ),
                  InkWell(
                      onTap: () => {deleteProduct(product.id, context)},
                      child: const Icon(Icons.delete,
                          color: MyColor.PRIMARY_COLOR))
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productProvider.listProduct = [];
    super.dispose();
  }

  void deleteProduct(int id, BuildContext context) {
    showAlertDialog(context, id);
  }

  showAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Huỷ"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Xoá sản phẩm"),
      onPressed: () {
        _productProvider.deleteProduct(id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Cảnh báo!"),
      content: const Text("Bạn có chắc muốn xoá sản phẩm này?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _refresh() async {
    _productProvider.isRefresh = true;
    _productProvider.pageNumber = 1;
    await _productProvider.getListProduct();
  }

  void _loadMore() async {
    if (_isLoading) return;
    final thresholdReached = _controller.position.extentAfter < 200;
    if (thresholdReached && _productProvider.isCanLoadMore) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _isLoading = true;
      _productProvider.isLoadMore = true;
      _productProvider.pageNumber++;
      await _productProvider.getListProduct();
      _isLoading = false;
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
}
