import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/product_model.dart';
import 'package:serepok/res/constant.dart';

import '../../../api/repository/product_repository.dart';
import '../../../model/order_model.dart';

class ProductProvider extends BaseProvider {
  final ProductRepository _repository = ProductRepository();
  List<ProductModel> listProduct = [];
  Function? createProductSuccessCallback;
  Function? updateProductSuccessCallback;
  Function? deleteProductSuccessCallback;

  Future<void> getListProduct() async {
    showLoading();
    try {
      final response = await _repository.getListProduct(pageNumber);
      handleDataList(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  FutureOr handleDataList(PagingResponseModel<ProductModel> data) async {
    if(isRefresh){
      isRefresh=  false;
      listProduct.clear();
    }
    listProduct.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
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

  void updateProduct(
      String name,
      String description,
      String species,
      String price,
      String cost,
      String unit,
      String location,
      String gardenName,
      String code,
      File? image,
      int id) async {
    showLoading();
    FormData formData;
    if (image != null) {
      formData = FormData.fromMap({
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
        'image': await MultipartFile.fromFile(image.path,
            filename: "image_${DateTime.now().millisecondsSinceEpoch}.jpg")
      });
    } else {
      formData = FormData.fromMap({
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
      });
    }
    _repository
        .updateProduct(formData, id)
        .then(updateProductSuccess)
        .onError(handleError);
  }

  void deleteProduct(
      int id) async {
    showLoading();
    _repository
        .deleteProduct(id)
        .then(deleteProductSuccess)
        .onError(handleError);
  }

  FutureOr createProductSuccess(ProductModel value) {
    showAlert('Tạo sản phẩm thành thành công');
    createProductSuccessCallback?.call();
    hideLoading();
  }

  FutureOr updateProductSuccess(ProductModel value) {
    updateProductSuccessCallback?.call();
    hideLoading();
  }

  FutureOr deleteProductSuccess(List<CreateModel> value) {
    deleteProductSuccessCallback?.call();
    hideLoading();
  }
}
