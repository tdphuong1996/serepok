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

  @override
  void initState() {
    super.initState();
    _staffProvider = Provider.of<StaffProvider>(context, listen: false);
    _staffProvider.context = context;
    _staffProvider.getListStaff();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _staffProvider.listStaff.length,
      itemBuilder: (context, index) {
        return item(_staffProvider.listStaff[index]);
      },
    );
  }

  Widget item(StaffModel staffModel) {
    return InkWell(
      onTap: () => {
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
    super.dispose();
  }
}
