
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterViews extends StatefulWidget{
  const ConverterViews({super.key});

  @override
  State<ConverterViews> createState() => _ConverterViewsState();


}

class _ConverterViewsState extends State<ConverterViews> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Просмотры", "\$\$\$"];
  int currTitle = 0;
  String result = "";

  List<String> items = ['Просмотры', '\$\$\$', '€€€', '¥¥¥'];
  String selectedItem = '\$\$\$';

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

          switch (selectedItem){
            case "Просмотры":
              result = "${(int.parse(s) / 0.002).round()} просмотров...";
              break;
            case "\$\$\$":
              result = "$s USD...";
              break;
            case '€€€':
              result = "${(int.parse(s) * 0.93)} Евро...";
              break;
            case '¥¥¥':
              result = "${(int.parse(s) * 7.15)} Юаней...";
              break;
          }

        }else {
          double usd = double.parse(s) * 0.002;
          result = "$usd USD...";

          switch (selectedItem){
            case "Просмотры":
              result = "$s просмотров...";
              break;
            case "\$\$\$":
              result = "$usd USD...";
              break;
            case '€€€':
              result = "${usd * 0.93} Евро...";
              break;
            case '¥¥¥':
              result = "${usd * 7.15} Юаней...";
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