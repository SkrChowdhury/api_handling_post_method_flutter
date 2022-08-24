import 'dart:convert';
import 'package:api_handling_post_method_flutter/DataModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Http POST Method'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<DataModel?> submitData(String name, String job) async {
  var response = await http.post(Uri.parse('https://reqres.in/api/users'),
      body: {"name": name, "job": job});
  var data = response.body;
  if (response.statusCode == 201) {
    String resposeString = response.body;
    return dataModelFromJson(resposeString);
  } else {
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  DataModel? _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Name Here'),
                controller: nameController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Job Title Here'),
                controller: jobController,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String job = jobController.text;
                  DataModel? data = await submitData(name, job);
                  setState(() {
                    _dataModel = data;
                  });
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
