import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    this.textSize = 18,
  });
  final Color color;
  final String text;
  final VoidCallback onTap;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2 ),  

          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: textSize,
                  ),
                ),
                Divider(height: 1, thickness: 1, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
