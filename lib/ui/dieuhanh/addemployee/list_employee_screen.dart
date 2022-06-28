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
  @override
  void initState() {
    super.initState();
    final staffProvider = Provider.of<StaffProvider>(context, listen: false);
    staffProvider.getListStaff();
  }
  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    return ListView.builder(
      itemCount: staffProvider.listStaff.length,
      itemBuilder: (context, index) {
        return item(staffProvider.listStaff[index]);
      },
    );
  }

  Widget item(StaffModel staffModel) {
    return InkWell(
      onTap: ()=>{
        Navigator.of(context).pushNamed(Routes.ADD_EMPLOYEE)
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Colors.red,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Tên"),
                  Text("0324923049302"),
                ],
              ),
            )),
            const SizedBox(
              height: 60,
              width: 30,
              child: Icon(FontAwesomeIcons.ellipsisVertical,color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
