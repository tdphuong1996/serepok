import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:serepok/ui/dieuhanh/addemployee/staff_provider.dart';

import '../../../model/staff.dart';
import '../../../res/AppThemes.dart';

enum Role { SELL, SHIPPER }

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  Role? _role;
  String? imageUrl;

  final TextEditingController _editingNameController = TextEditingController();
  final TextEditingController _editingPhoneController = TextEditingController();
  final TextEditingController _editingEmailController = TextEditingController();
  final TextEditingController _editingPasswordController =
      TextEditingController();
  final TextEditingController _editingRePasswordController =
      TextEditingController();
  final TextEditingController _editingRoleController = TextEditingController();
  late StaffProvider _staffProvider;

  @override
  void initState() {
    super.initState();
    _staffProvider = Provider.of<StaffProvider>(context, listen: false);
    _staffProvider.createStaffSuccessCallback = resetData;
  }

  @override
  Widget build(BuildContext context) {
    final staffModel = ModalRoute.of(context)!.settings.arguments as StaffModel;

    return Scaffold(
      appBar: AppBar(
        title: staffModel.id != 0
            ? const Text('Chỉnh sửa nhân viên')
            : const Text('Tạo nhân viên'),
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
                      child: staffModel.id != 0 ? viewUpdate(staffModel) : viewCreate()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoButton(
                        color: MyColor.PRIMARY_COLOR,
                        onPressed: () {
                          staffModel.id == 0
                              ? createStaff()
                              : image != null
                                  ? updateStaffWithImage(staffModel)
                                  : updateStaffNoImage(staffModel);
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        padding: const EdgeInsets.only(
                            top: 8, left: 32, right: 32, bottom: 8),
                        pressedOpacity: 0.5,
                        child: staffModel.id != 0
                            ? const Text('Cập nhật nhân viên')
                            : const Text('Tạo nhân viên')),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> pickAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        this.image = File(image.path);
      });
    }
  }

  void pickRole() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Chọn phân quyền",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    InkWell(
                      onTap: () {
                        _role = Role.SELL;
                        _editingRoleController.text = "Nhân viên bán hàng";
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Nhân viên bán hàng"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _role = Role.SHIPPER;
                        _editingRoleController.text = "Nhân viên giao hàng";
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Nhân viên giao hàng"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  void createStaff() {
    _staffProvider.createStaff(
        _editingNameController.text,
        _editingPhoneController.text,
        _editingEmailController.text,
        _editingPasswordController.text,
        _editingRePasswordController.text,
        _role,
        image);
  }

  void updateStaffWithImage(StaffModel staffModel) {
    _staffProvider.updateStaffWithImage(
        staffModel.id,
        _editingNameController.text,
        _editingPhoneController.text,
        _editingEmailController.text,
        _role,
        image);
  }

  void updateStaffNoImage(StaffModel staffModel) {
    _staffProvider.updateStaffNoImage(
        staffModel.id,
        _editingNameController.text,
        _editingPhoneController.text,
        _editingEmailController.text,
        _role);
  }

  Widget viewCreate() {
    return Column(
      children: [
        height(),
        avatar(),
        height(),
        textField("Họ và tên", _editingNameController),
        height(),
        textField("Số điện thoại", _editingPhoneController),
        textField("Email", _editingEmailController),
        textField("Mật khẩu", _editingPasswordController),
        textField("Nhập lại mật khẩu", _editingRePasswordController),
        height(),
        textFieldTap("Phân quyền"),
        height(),
      ],
    );
  }

  Widget viewUpdate(StaffModel staffModel) {
    setupDefaultData(staffModel);
    return Column(
      children: [
        height(),
        avatar(),
        height(),
        textField("Họ và tên", _editingNameController),
        height(),
        textField("Số điện thoại", _editingPhoneController),
        textField("Email", _editingEmailController),
        textFieldTap("Phân quyền"),
        height(),
      ],
    );
  }

  Widget textFieldTap(String label) {
    return InkWell(
      onTap: () => {pickRole()},
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(FontAwesomeIcons.angleDown)),
          controller: _editingRoleController,
        ),
      ),
    );
  }

  Widget height() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget avatar() {
    return InkWell(
      onTap: () => {pickAvatar()},
      child: SizedBox(
        width: 80,
        height: 80,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                )
              : imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey.shade200,
                    ),
        ),
      ),
    );
  }

  Widget textField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(labelText: label),
      controller: controller,
    );
  }

  resetData() {
    _role = null;
    image = null;
    _editingNameController.text = "";
    _editingPhoneController.text = "";
    _editingEmailController.text = "";
    _editingPasswordController.text = "";
    _editingRePasswordController.text = "";
    _editingRoleController.text = "";
  }

  setupDefaultData(StaffModel staffModel) {
    if (staffModel.id != 0) {
      _role = null;
      imageUrl = staffModel.avatarUrl;
      _editingNameController.text = staffModel.name;
      _editingPhoneController.text = staffModel.phone;
      _editingEmailController.text = staffModel.email;
      _editingRoleController.text = "";
    }
  }
}
