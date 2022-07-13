

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget{
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmptyScreen();

}

class _EmptyScreen extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}