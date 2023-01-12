import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const MyHomePage(title: 'Prueba de bateria'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const platform = MethodChannel('albin/battery');
// Get battery level.

  String _batteryLevel = 'Presione icono de bateria ';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel_albin');
      batteryLevel = 'es  $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    } on Exception catch (e) {
      batteryLevel = "Error $e";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(123, 242, 241, 241),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.blue,
                width: 300,
                height: 100,
                child: Center(
                    child: Text(
                  "Samsung A70",
                  textScaleFactor: 2.1,
                ))),
            Text('La bateria de tu celular',
                //overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline4),
            Text(
              _batteryLevel,
              //overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryLevel,
        tooltip: 'Bateria',
        child: const Icon(Icons.battery_unknown_rounded),
        //focusColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 255, 7, 65),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
