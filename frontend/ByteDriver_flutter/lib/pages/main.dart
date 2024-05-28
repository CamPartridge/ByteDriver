import 'package:bytedriver_app/pages/byter.dart';
import 'package:bytedriver_app/pages/driver.dart';
import 'package:bytedriver_app/pages/login.dart';
import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

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
      debugShowCheckedModeBanner: false,
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
    if(!isLoggedIn){
      Toast.show("Please Login before going to Byter Page",
          duration: 3,
          textStyle: TextStyle (fontSize:50, color: Colors.red),
          backgroundColor: Colors.white70
      );
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const byter())
      );
    }
  }

  void _driverButton() {
    print('GOING TO DRIVER PAGE');
    if(!isLoggedIn){
      Toast.show("Please Login before going to Driver Page",
          duration: 3,
          textStyle: TextStyle (fontSize:50, color: Colors.red),
          backgroundColor: Colors.white70
      );
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const driver())
      );
    }
  }

  void _login(){
    print('GOING TO LOGIN PAGE');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const login())
    );
  }

  @override
  Widget build(BuildContext context) {

    ToastContext().init(context);
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
              style: TextStyle(fontSize: 75, color: const Color(0xFF8bff00)),
            ),
            Text(
              'How would you like to fuel your brain today?',
              style: TextStyle(fontSize: 35,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60,),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 12, left: 5),
                  child: ElevatedButton.icon(onPressed: _byterButton,
                    icon: Icon(Icons.fastfood, size: 40), // Add your icon here
                    label: Text("Byter", style: TextStyle(fontSize: 40)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF00cc00)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      elevation: MaterialStateProperty.all<double>(10),
                      minimumSize: MaterialStateProperty.all<Size>(Size(205, 200)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 12, left: 5),
                  child: ElevatedButton.icon(onPressed: _driverButton,
                    icon: Icon(Icons.directions_car, size: 40), // Add your icon here
                    label: Text("Driver", style: TextStyle(fontSize: 40)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF00cc00)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      elevation: MaterialStateProperty.all<double>(10),
                      minimumSize: MaterialStateProperty.all<Size>(Size(205, 200)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ), //function
              ],
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: _login,
                child: Text('Login', style: TextStyle(fontSize: 20, color: const Color(0xFFFFFFFF))),
                color: const Color(0xFF006d25),),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
