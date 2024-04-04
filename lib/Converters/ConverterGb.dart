
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterGb extends StatefulWidget{
  const ConverterGb({super.key});

  @override
  State<ConverterGb> createState() => _ConverterGbState();


}

class _ConverterGbState extends State<ConverterGb> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Гиги", "Байты"];
  int currTitle = 0;
  String result = "";

  List<String> items = ['Гиги', 'Байты', 'Мегабайты', 'Терабайты'];
  String selectedItem = 'Байты';

  @override
  void initState() {
    super.initState();
    controller.addListener(() {


      updateResult(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateTitle(){
    setState(() {
      currTitle = currTitle == 0 ? 1 : 0;
    });

  }

  void updateResult(String s){
    setState(() {
      if (s.isEmpty){
        result = "Здесь будет результат...";
      }else {
        if (currTitle == 1){
          double num = double.parse(s);

          switch (selectedItem){
            case "Гиги":
              result = "${num / 1000000000} ГБ...";
              break;
            case "Байты":
              result = "$num Байтов...";
              break;
            case "Мегабайты":
              result = "${num / 1000000} Мегабайтов...";
              break;
            case "Терабайты":
              result = "${num / 1000000000000} ТБ...";
              break;
          }

        }else {

          switch (selectedItem){
            case "Гиги":
              result = "$s ГБ...";
              break;
            case "Байты":
              result = "${(int.parse(s) * 1000000000).round()} Байтов...";
              break;
            case "Мегабайты":
              result = "${(int.parse(s) * 1000000).round()} Мегабайтов...";
              break;
            case "Терабайты":
              result = "${(int.parse(s) / 1000)} ТБ...";
              break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Base.createBase(
        GestureDetector(
          onDoubleTap: (){
            updateTitle();
            updateResult(controller.text);
          },
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: selectedItem,
                      onChanged: (String? newValue) {

                        setState(() {
                          selectedItem = newValue!;
                        });
                        updateResult(controller.text);
                      },
                      items: items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      controller: controller,
                      autofocus: true,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                          fontSize: 20
                      ),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.numbers),
                        hintText: 'Введите число',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(signed: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(result,
                        style: TextStyle(fontSize: 20),),
                    )

                  ],
                ),
              )
          ),
        ),
        title: "${titles[currTitle]} в $selectedItem"
    );
  }
}