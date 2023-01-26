import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Text("Push Notification"),
          ),
        ),
      ),
    );
  }
}
