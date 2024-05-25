import 'package:bytedriver_app/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteDriver',
      theme: ThemeData(
          useMaterial3: true,

          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF01D758),

            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF000e01)
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  void _byterButton() {
    print('GOING TO BYTER PAGE');
  }

  void _driverButton() {
    print('GOING TO DRIVER PAGE');
  }

  void _login(){
    print('GOING TO LOGIN PAGE');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const login())
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ByteDriver',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'How would you like to fuel your brain today?',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12, right: 5),
                  child: ElevatedButton(
                    child: Text("Byter", style: TextStyle(fontSize: 30)),
                    onPressed: _byterButton,
                    style: (ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                        elevation: MaterialStateProperty.all<double>(10),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(205, 200)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12, left: 5),
                  child: ElevatedButton(
                    child:
                        Text("Driver", style: TextStyle(fontSize: 30)),
                    onPressed: _driverButton,
                    style: (ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                        // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                        elevation: MaterialStateProperty.all<double>(10),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(205, 200)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                  ),
                ), //function
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: ElevatedButton(
                child:
                Text("Login", style: TextStyle(fontSize: 30)),
                onPressed: _login,
                style: (ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.greenAccent),
                    // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                    elevation: MaterialStateProperty.all<double>(10),
                    minimumSize:
                    MaterialStateProperty.all<Size>(Size(205, 100)),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
