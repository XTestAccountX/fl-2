
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterShaverma extends StatefulWidget{
  const ConverterShaverma({super.key});

  @override
  State<ConverterShaverma> createState() => _ConverterShavermaState();


}

class _ConverterShavermaState extends State<ConverterShaverma> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Рубли", "Шаурму"];
  int currTitle = 0;
  String result = "";

  List<String> items = ['Рубли', 'Шаурму', 'Пиццу', 'Бургер'];
  String selectedItem = 'Шаурму';

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
          int num = ((int.parse(s) * 215));

          switch (selectedItem){
            case "Рубли":
              result = "$num рублей...";
              break;
            case "Шаурму":
              result = "это $s шаурмы...";
              break;
            case "Пиццу":
              result = "это ${((num / 600) * 1000).round() / 1000} пицц...";
              break;
            case "Бургер":
              result = "это ${((num / 250) * 1000).round() / 1000} бургеров...";
              break;
          }
        }else {
          // 162р это 1 шаурма   600р - 1 пицца  250 - 1 бургер

          switch (selectedItem){
            case "Рубли":
              result = "$s рублей?...";
              break;
            case "Шаурму":
              double num = (int.parse(s) / 215);
              num = (num * 1000).round() / 1000;
              result = "это $num шаурмы...";
              break;
            case "Пиццу":
              double num = (int.parse(s) / 600);
              num = (num * 1000).round() / 1000;
              result = "это $num пицц...";
              break;
            case "Бургер":
              double num = (int.parse(s) / 250);
              num = (num * 1000).round() / 1000;
              result = "это $num бургеров...";
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