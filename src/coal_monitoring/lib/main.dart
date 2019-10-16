import 'package:flutter/material.dart';
import 'widgets/CoalPainter.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: _buildGrid()));
  }

  Widget _buildGrid() => GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      mainAxisSpacing: 10,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      children: _buildGridTileList(20));

    var _random = math.Random(5);

  List<Container> _buildGridTileList(int count) {
    double arcStart = 0, arcEnd = math.pi * 2;
    if (!_controller.isCompleted) {
      arcStart = Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
          .chain(CurveTween(curve: Interval(0.5, 1.0)))
          .evaluate(_controller);
      arcEnd = math.sin(Tween(begin: 0.0, end: math.pi).evaluate(_controller)) *
          math.pi;
    }

    return List.generate(count, (i) {
      if (_controller.isCompleted) {
        arcEnd = math.pi + math.pi * (_random.nextInt(100) - 50) / 100.0;
      }

      int idx = i + 1;

      return Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: CustomPaint(
            painter: CoalPainter(arcStart, arcEnd, 'C$idx', 30 + _random.nextInt(10) - 5.0),
          ));
    });
  }
}
