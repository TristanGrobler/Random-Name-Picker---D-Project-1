import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        ),

      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //This is the variable that holes the result of the random picked name.
  String result = '';
  //This is the variable that holds the string of the input field.
  String itemText = '';
  //This is the variable that holds the list of items for the spinner.
  List<String> stringList = [];
  //This is the stream controller for the spinning wheel.
  StreamController<int> controller = StreamController<int>();
  // This is the item to control text in textfield
  TextEditingController txtEditController = TextEditingController();

  //Method to create the list for the spinner
  List<FortuneItem> getWheelItems() {
    List<FortuneItem> _list = [
      FortuneItem(child: Text('Enter Data')),
      FortuneItem(child: Text('Enter Data')),
    ];
    if (stringList.isNotEmpty && stringList.length > 1) {
      _list = [];
      for (var i = 0; i < stringList.length; i++) {
        _list.add(FortuneItem(child: Text(stringList[i],style: TextStyle(),)));
      }
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //This is the top bar that has the title of the app in it.
      appBar: AppBar(
        title: const Text('Random Item Picker'),
      ),
      //This is the body of the app, so everything below the app bar.
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // This widget shows the text at the top of the body.
              const Text('Items List:'),
              // This widget shows the user input field.
              Container(
                color: Colors.blue.withOpacity(0.2),
                child: TextFormField(
                  controller: txtEditController,
                  maxLines: 1,
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    stringList.add(txtEditController.text);
                    txtEditController.clear();
                    setState(() {});
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Item')),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 200,
                child: FortuneWheel(
                  selected: controller.stream,
                  items: getWheelItems(),
                ),
              ),
              // This widget shows the button to run randomly spin the wheel.
              TextButton(
                onPressed: () {
                  controller.add(Random().nextInt(100));
                },
                child: const Icon(Icons.refresh_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}