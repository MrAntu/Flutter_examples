import 'package:flutter/material.dart';

class ExceptionPage extends StatelessWidget {
  final String exception;
  final String stack;
  ExceptionPage(this.exception, this.stack);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          // width: getWidthPx(750),
          // height: getHeightPx(1334),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  exception,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  stack,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
