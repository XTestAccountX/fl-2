import 'package:flutter/material.dart';
import 'ConverterMain.dart';


void main() {
  runApp(const Converter());
}

class Converter extends StatelessWidget {
  const Converter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Base.createBase(const ConverterMain());
  }


}

class Base{
  static Widget createBase(Widget w, {String title = "Converter"}){
    return MaterialApp(

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent.shade700),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SafeArea(
          child: w,
        ),

      ),
    );
  }
}



