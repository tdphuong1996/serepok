import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/AppThemes.dart';
import '../../../routes.dart';

class ListEmployeeScreen extends StatefulWidget {
  const ListEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<ListEmployeeScreen> createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return item();
      },
    );
  }

  Widget item() {
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
