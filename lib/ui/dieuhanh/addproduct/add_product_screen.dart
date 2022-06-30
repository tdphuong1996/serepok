import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _editingNameProductController =
      TextEditingController();
  final TextEditingController _editingCodeProductController =
      TextEditingController();
  final TextEditingController _editingDesProductController =
      TextEditingController();
  final TextEditingController _editingTypeProductController =
      TextEditingController();
  final TextEditingController _editingGardenNameController =
      TextEditingController();
  final TextEditingController _editingPriceProductController =
      TextEditingController();
  final TextEditingController _editingUnitProductController =
      TextEditingController();
  final TextEditingController _editingCostProductController =
      TextEditingController();
  final TextEditingController _editingAreaProductController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? image;

  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.context = context;
    _productProvider.createProductSuccessCallback = resetData;
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
                        textField(
                            "Tên sản phẩm", _editingNameProductController),
                        height(),
                        textField("Mã sản phẩm", _editingCodeProductController),
                        height(),
                        TextFormField(
                          controller: _editingDesProductController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 4,
                          decoration:
                              InputDecoration(labelText: 'Thông tin sản phẩm'),
                        ),
                        height(),
                        textField("Chủng loại", _editingTypeProductController),
                        height(),
                        textField("Tên nhà vườn", _editingGardenNameController),
                        height(),
                        viewPrice(),
                        height(),
                        textField("Giá sỉ", _editingCostProductController),
                        height(),
                        textField("Địa lý", _editingAreaProductController),
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
                          createProduct();
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

  resetData() {
    setState(() {
      this.image = null;
    });
    final controllers = [
      _editingNameProductController,
      _editingDesProductController,
      _editingTypeProductController,
      _editingPriceProductController,
      _editingCostProductController,
      _editingUnitProductController,
      _editingCodeProductController,
      _editingAreaProductController,
      _editingGardenNameController,
    ];
    for (var element in controllers) {
      element.text = "";
    }
  }

  void createProduct() {
    String name = _editingNameProductController.text;
    String description = _editingDesProductController.text;
    String species = _editingTypeProductController.text;
    String price = _editingPriceProductController.text;
    String cost = _editingCostProductController.text;
    String unit = _editingUnitProductController.text;
    String location = _editingAreaProductController.text;
    String code = _editingCodeProductController.text;
    String gardenName = _editingGardenNameController.text;
    if (name.isEmpty ||
        description.isEmpty ||
        gardenName.isEmpty ||
        code.isEmpty ||
        species.isEmpty ||
        price.isEmpty ||
        cost.isEmpty ||
        location.isEmpty ||
        image == null ||
        unit.isEmpty) {
      _productProvider.showAlert('Vui lòng nhập đầy đủ thông tin');
      return;
    }
    _productProvider.createProduct(name, description, species, price, cost,
        unit, location, gardenName, code, image);
  }

  Future<void> pickAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        this.image = File(image.path);
      });
    }
  }

  Widget viewPrice() {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: textField("Giá bán", _editingPriceProductController)),
        SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 3, child: textField("Đơn vị", _editingUnitProductController))
      ],
    );
  }

  Widget imageProduct() {
    return InkWell(
      onTap: () => {pickAvatar()},
      child: SizedBox(
        width: 100,
        height: 100,
        child: ClipRRect(
          child: image != null
              ? Image.file(image!, fit: BoxFit.cover)
              : Container(
                  color: Colors.grey.shade200,
                ),
        ),
      ),
    );
  }

  Widget height() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget textField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      controller: controller,
    );
  }

  Widget textFieldTap(String label) {
    return InkWell(
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(FontAwesomeIcons.angleDown)),
          controller: _editingUnitProductController,
        ),
      ),
    );
  }
}
