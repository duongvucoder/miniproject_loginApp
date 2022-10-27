// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyBottom extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool enable;
  final VoidCallback onTap;

  const MyBottom({
    Key? key,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    required this.text,
    required this.onTap,
    this.enable = true,
  }) : super(key: key);

  @override
  State<MyBottom> createState() => _MyBottomState();
}

class _MyBottomState extends State<MyBottom> {
  var lock = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (!lock && widget.enable) {
          lock = true;
          setState(() {});
          widget.onTap();
          Future.delayed(
            const Duration(milliseconds: 500),
            (() {
              setState(() {});
              lock = false;
            }),
          );
        }
      }),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color:
                (lock || !widget.enable) ? Colors.grey : widget.backgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
