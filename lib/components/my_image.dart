import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(
        'assets/images/logo4.png',
        width: 300,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
