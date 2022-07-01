import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/staff.dart';
import 'package:serepok/res/view.dart';
import 'package:serepok/ui/dieuhanh/addemployee/staff_provider.dart';

import '../../../routes.dart';

class ListEmployeeScreen extends StatefulWidget {
  const ListEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<ListEmployeeScreen> createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  late StaffProvider _staffProvider;
  late ScrollController _controller;
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _staffProvider = Provider.of<StaffProvider>(context, listen: false);
    _staffProvider.context = context;
    _staffProvider.getListStaff();
    _controller = ScrollController();
    _controller.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffProvider>(builder: (context, value, child) {
      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _controller,
                itemCount: _staffProvider.listStaff.length,
                itemBuilder: (context, index) {
                  return item(_staffProvider.listStaff[index]);
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

  Future<void> itemClick(StaffModel staffModel) async {
    final result = await Navigator.pushNamed(context, Routes.ADD_EMPLOYEE,
        arguments: staffModel);
    if (result != null) {
      showOkAlertDialog(
          context: context, message: 'Cập nhật thông tin thành công');
      _refresh();
    }
  }

  Widget item(StaffModel staffModel) {
    return InkWell(
      onTap: () => {itemClick(staffModel)},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ImageNetwork(staffModel.avatarUrl)),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(staffModel.name),
                  Text(staffModel.phone),
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
    _staffProvider.dispose();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Future<void> _refresh() async {
    _staffProvider.isRefresh = true;
    _staffProvider.pageNumber = 1;
    await _staffProvider.getListStaff();
  }

  void _loadMore() async {
    if (_isLoading) return;
    final thresholdReached = _controller.position.extentAfter < 200;
    if (thresholdReached && _staffProvider.isCanLoadMore) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _isLoading = true;
      _staffProvider.isLoadMore = true;
      _staffProvider.pageNumber++;
      await _staffProvider.getListStaff();
      _isLoading = false;
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
}
