import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoalPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;
  final double _value;
  final double _paintWidth;
  final String _name;

  CoalPainter(this._arcStart, this._arcSweep,
      [this._name = 'coal', this._value = 30, this._paintWidth = 4.0]);

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    double max = math.max(size.width, size.height);
    double delta = max - side;

    var tp = TextPainter()..textDirection = TextDirection.ltr;

    tp
      ..text = new TextSpan(
        text: _name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Consolas',
          fontSize: 28.0 * 1,
        ),
      )
      ..layout()
      ..paint(canvas, new Offset((size.width - tp.width) / 2, 0));

    tp
      ..text = new TextSpan(
          text: '$_value',
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Consolas',
            fontSize: 28.0 * 1,
          ))
      ..layout()
      ..paint(
          canvas, new Offset(tp.width / 2, delta + side / 2 - tp.height / 2));

    var paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // canvas.drawRect(Offset(0, 0) & Size(size.width, size.height), paint);

    paint.color = Colors.green;
    canvas
      ..drawCircle(Offset(side / 2, side / 2 + delta), side / 2, paint)
      ..drawCircle(Offset(side / 2, side / 2 + delta),
          side / 2 - _paintWidth * 2, paint);

    paint
      ..color = Colors.red
      ..strokeWidth = _paintWidth;

    canvas.drawArc(
        Offset(_paintWidth, delta + _paintWidth) &
            Size(side - _paintWidth * 2, side - _paintWidth * 2),
        _arcStart,
        _arcSweep,
        false,
        paint);
  }

  @override
  bool shouldRepaint(CoalPainter other) {
    return _arcStart != other._arcStart ||
        _arcSweep != other._arcSweep ||
        _value != other._value;
  }
}
