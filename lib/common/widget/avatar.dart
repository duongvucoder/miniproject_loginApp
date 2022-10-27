import 'package:flutter/material.dart';

class BuildAvart extends StatelessWidget {
  const BuildAvart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child: Image.asset(
            'assets/images/vinhomes1.jpeg',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 8,
        ),
        const Text(
          'VINHOMES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 4,
        ),
        const Text(
          'STAR CITY',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
