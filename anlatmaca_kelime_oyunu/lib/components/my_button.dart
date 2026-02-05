import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.context,
    required this.text,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.function,
    required this.color,
    required this.fontColor,
  });

  final BuildContext context;
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final Color color;
  final Color fontColor;

  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // 👈 Varsayılan rengi kapattık
      elevation: 0, // 👈 Material gölgesini iptal ettik
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        onTap: () {
          HapticFeedback.lightImpact();
          function();
        },
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
