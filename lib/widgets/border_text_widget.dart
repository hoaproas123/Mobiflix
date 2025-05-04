import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BorderTextWidget extends StatefulWidget {
  final String text;
  final Color color;

  const BorderTextWidget({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  _BorderTextWidgetState createState() => _BorderTextWidgetState();
}

class _BorderTextWidgetState extends State<BorderTextWidget>{
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(
            fontSize: context.orientation==Orientation.portrait ? context.height*0.16 : context.width*0.18,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Colors.white, // Màu viền
          ),
        ),
        // Chữ chính
        Text(
          widget.text,
          style: TextStyle(
            fontSize: context.orientation==Orientation.portrait ? context.height*0.16 : context.width*0.18,
            fontWeight: FontWeight.bold,
            color: widget.color, // Màu chữ chính
          ),
        ),
      ],
    );
  }
}