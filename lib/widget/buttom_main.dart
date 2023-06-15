import 'package:flutter/material.dart';

class PressableContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;

  const PressableContainer({
    Key? key,
    required this.onPressed,
    required this.child,
    this.height = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * 0.8;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFFEEF3F8),
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 161, 161, 161),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: child,
      ),
    );
  }
}
