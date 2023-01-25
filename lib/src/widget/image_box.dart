import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

final borderRadius = BorderRadius.circular(20);
const size = 100.0;

class ImageBox extends StatelessWidget {
  Widget? child;
  ImageBox({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}
