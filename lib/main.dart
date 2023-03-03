import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Drugs> fetchDrugs(int albumId) async {
  final response = await http.get(
      'https://my-json-server.typicode.com/Olamidipupo-favour/pharmb-api/drugs/$albumId');
  if (response.statusCode == 200) {
    return Drugs.fromJson(json.decode(response.body));
  } else {
    throw Exception('Drug not available ');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharmB',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PharmB'),
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
  double? _result;

  // Create a text controller  to retrieve the value
  final _textController = TextEditingController();
  Future<Drug> futuredrugs;

  // the function which calculates square
  void _calculate() {
    // textController.text is a string and we have to convert it to double
    final double? enteredNumber = double.tryParse(_textController.text);
    setState(() {
      futuredrugs = fetchDrugs(enteredNumber);
      _result = enteredNumber != null ? enteredNumber * enteredNumber : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // The user will type something here
            TextField(
              controller: _textController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),

            ElevatedButton(onPressed: _calculate, child: const Text('Submit')),

            // add some space
            const SizedBox(height: 30),

            // Display the result
            Text(
              _result == null
                  ? 'Please enter a valid number!'
                  : _result!.toStringAsFixed(2),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
} // This trailing comma makes auto-formatting nicer for build methods.
