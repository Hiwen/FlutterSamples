import 'package:flutter/material.dart';
import 'DemoPainter.dart';
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
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat()
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  //  @override
  // void initState() {
  //   _controller =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
  //         ..repeat();
  //   super.initState();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CustomPaint(
  //     painter: DemoPainter(0.0, _controller.value * math.pi * 2),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(animation: _controller, builder: (context, child) {
  //     return CustomPaint(
  //       painter: DemoPainter(0.0, _controller.value * math.pi * 2),
  //     );
  //   });

  //   @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(
  //       animation: _controller,
  //       builder: (context, child) {
  //         return CustomPaint(
  //           painter: DemoPainter(
  //             Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
  //                 .chain(CurveTween(curve: Interval(0.5, 1.0)))
  //                 .evaluate(_controller),
  //             math.sin(Tween(begin: 0.0, end: math.pi).evaluate(_controller)) *
  //                 math.pi,
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: _buildGrid()));
  }

  Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 100,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 60,
    crossAxisSpacing: 15,
    children: _buildGridTileList(20));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(child: 
    CustomPaint(
            painter: DemoPainter(
              Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
                  .chain(CurveTween(curve: Interval(0.5, 1.0)))
                  .evaluate(_controller),
              math.sin(Tween(begin: 0.0, end: math.pi).evaluate(_controller)) *
                  math.pi,
            ),
    )));
}
