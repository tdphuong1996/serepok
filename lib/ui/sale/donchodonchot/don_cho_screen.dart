import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/AppThemes.dart';
import '../../../routes.dart';

class DonChoScreen extends StatefulWidget {
  const DonChoScreen({Key? key}) : super(key: key);

  @override
  State<DonChoScreen> createState() => _DonChoScreenState();
}

class _DonChoScreenState extends State<DonChoScreen> {
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
      onTap: () => {Navigator.of(context).pushNamed(Routes.ADD_EMPLOYEE)},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    itemInfo(FontAwesomeIcons.calendar, '12/12/1212'),
                    const SizedBox(width: 30),
                    itemInfo(FontAwesomeIcons.barcode, '234324A'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(
                    FontAwesomeIcons.circleInfo, 'Nguyen Van A -  09888787878'),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(FontAwesomeIcons.fileInvoice,
                    'Sầu Ri6 - 10 - Dak nong  '),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(FontAwesomeIcons.listCheck,
                    'Tạm ứng'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemInfo(IconData icon, String info) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: MyColor.PRIMARY_COLOR,
        size: 18,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        info,
        style: TextStyle(fontSize: 16),
      )
    ],
  );
}
