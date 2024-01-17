import 'package:flutter/material.dart';

class FireBar extends StatefulWidget {
  const FireBar({super.key});

  @override
  State<FireBar> createState() => _FireBarState();
}

class _FireBarState extends State<FireBar> {
  Color _color = Colors.black.withAlpha(100);

  void _handleTap() {
    print('fire');
    // setState(() {
    //   _color = Colors.green;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Center(
        child: GestureDetector(
          onTap: _handleTap,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            // child: Icon(Icons.touch_app_rounded),
          ),
        ),
      ),
    );
  }
}
