import 'package:flutter/material.dart';

class FailedShape extends StatelessWidget {
  const FailedShape({
    super.key,
    required this.msg,
    required this.onTapRefresh,
    this.isWhite = false,
  });
  final String msg;
  final VoidCallback? onTapRefresh;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              msg.contains('&403') ? msg.split('-').first : msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isWhite ? Colors.white : null,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onTapRefresh != null)
              IconButton(
                onPressed: onTapRefresh,
                icon: Icon(Icons.refresh, color: isWhite ? Colors.white : null),
              ),
          ],
        ),
      ),
    );
  }
 }
 