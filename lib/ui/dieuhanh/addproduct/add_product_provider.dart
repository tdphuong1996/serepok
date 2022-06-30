import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/product_model.dart';

import '../../../api/repository/product_repository.dart';

class ProductProvider extends BaseProvider {
  final ProductRepository _repository = ProductRepository();
  List<ProductModel> listProduct = [];
  Function? createProductSuccessCallback;

  void getListProduct() {
    showLoading();
    _repository.getListProduct().then(handleDataList).onError(handleError);
  }

  FutureOr handleDataList(PagingResponseModel<ProductModel> data) async {
    listProduct.addAll(data.data);
    notifyListeners();
    hideLoading();
  }

  void createProduct(
      String name,
      String description,
      String species,
      String price,
      String cost,
      String unit,
      String location,
      String gardenName,
      String code,
      File? image) async {
    showLoading();
    var formData = FormData.fromMap({
      'name': name,
      'price': price,
      'cost': cost,
      'species': species,
      'location': location,
      'code': code,
      'unit': unit,
      'garden_name': gardenName,
      'description': description,
      'status': 1,
      'image': await MultipartFile.fromFile(image!.path,
          filename: "image_${DateTime.now().millisecondsSinceEpoch}.jpg")
    });
    _repository
        .createProduct(formData)
        .then(createProductSuccess)
        .onError(handleError);
  }

  FutureOr createProductSuccess(ProductModel value) {
    showAlert('Tạo sản phẩm thành thành công');
    createProductSuccessCallback?.call();
    hideLoading();
  }
}
