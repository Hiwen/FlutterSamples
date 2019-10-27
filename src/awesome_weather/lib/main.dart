import 'HeWeather.dart';
import 'package:flutter/material.dart';
import 'http.dart';
import 'WeatherDataGetter.dart';

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

class _MyHomePageState extends State<MyHomePage> with ResponseListener {
  int _counter = 0;

  String _city = 'wuhan';
  String _now = '当前天气';
  String _forecast = '预测天气';

  var _wdg = WeatherDataGetter();

  void _incrementCounter() {
    _wdg.now(this, _city);
    _wdg.forecast(this, _city);

    // var hm = httpManager();
    // hm.getForecast(null, '武汉');

    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    _wdg.now(this, _city);
    _wdg.forecast(this, _city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_now',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_forecast',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void onError(error) {}

  @override
  void onForecastResponse(body) {
    _forecast = body.toString();
    setState(() {
    });
  }

  @override
  void onNewWeatherResponse(body) {
      _now = body.toString();
    setState(() {
    });
  }
}
