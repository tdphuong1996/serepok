import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/staff.dart';
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
  List<StaffModel> listStaff = [];
  bool _isLoadMoreRunning = false;
  bool _hasNextPage = true;
  int _currentPage = 1;
  int _lastPage = 1;


  Future _firstLoad() async {
    setState(() async {
      await _staffProvider.getListStaff(_currentPage);
      listStaff = _staffProvider.listStaff;
      _lastPage = _staffProvider.lastPage;
    });
  }

  void _loadMore() async {
    if (_currentPage < _lastPage) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _currentPage += 1; // Increase _page by 1
      if (_staffProvider.listStaff.length <= _staffProvider.total) {
        await _staffProvider.getListStaff(_currentPage);
        setState(() {
          listStaff = _staffProvider.listStaff;
        });
      } else {
        // This means there is no more data
        // and therefore, we will not send another GET request
        setState(() {
          _hasNextPage = false;
        });
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  Future _refresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      listStaff.clear();
      _currentPage = 1;
      _firstLoad();
    });
  }

  @override
  void initState() {
    super.initState();
    _staffProvider = Provider.of<StaffProvider>(context, listen: false);
    _staffProvider.context = context;
    _controller = ScrollController()
      ..addListener(_loadMore);
    _firstLoad();
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
                itemCount: listStaff.length,
                itemBuilder: (context, index) {
                  return item(listStaff[index]);
                },
              ),
            ),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
    });
  }

  Widget item(StaffModel staffModel) {
    return InkWell(
      onTap: () =>
      {
        Navigator.of(context)
            .pushNamed(Routes.ADD_EMPLOYEE, arguments: staffModel)
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: Image.network(staffModel.avatarUrl)),
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

  @override
  void dispose() {
    _staffProvider.dispose();
    _controller.removeListener(_loadMore);
    super.dispose();
  }
}
