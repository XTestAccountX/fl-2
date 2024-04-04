
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterInch extends StatefulWidget{
  const ConverterInch({super.key});

  @override
  State<ConverterInch> createState() => _ConverterInchState();


}

class _ConverterInchState extends State<ConverterInch> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Метр", "Дюйм"];
  int currTitle = 0;
  String result = "";

  List<String> items = ['Метр', 'Километр', 'Сантиметр', 'Дюйм'];
  String selectedItem = 'Дюйм';

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
          // Дюймы во что то, считаем метр для удобства
          double meter = (double.parse(s) * 0.254);
          switch (selectedItem){
            case "Метр":
              result = "${meter} метров...";
              break;
            case "Сантиметр":
              result = "${(meter * 100)} Сантиметров...";
              break;
            case "Километр":
              result = "${(meter / 1000)} Километров...";
              break;
            case "Дюйм":
              result = "${s} Дюймов...";
              break;
          }
        }else {
          // Метры во что то
          switch (selectedItem){
            case "Метр":
              result = "${double.parse(s)} метров...";
              break;
            case "Сантиметр":
              result = "${(double.parse(s) * 100)} Сантиметров...";
              break;
            case "Километр":
              result = "${(double.parse(s) / 1000)} Километров...";
              break;
            case "Дюйм":
              result = "${(double.parse(s) * 39.3701)} дюймов...";
              break;
          }
        }
      }

    });
  }

  String beautifyText(String text){

    return text;
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