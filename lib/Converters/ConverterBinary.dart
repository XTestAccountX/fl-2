
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class ConverterBinary extends StatefulWidget{
  const ConverterBinary({super.key});

  @override
  State<ConverterBinary> createState() => _ConverterBinaryState();


}

class _ConverterBinaryState extends State<ConverterBinary> {

  final TextEditingController controller = TextEditingController();
  List<String> titles = ["Десятичное", "Двоичное"];
  int currTitle = 0;
  String result = "";

  List<String> items = ['Двоичное', 'Десятичное', 'Восьмиричное', 'Шестнадцатиричное'];
  String selectedItem = 'Двоичное';

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

      if (s.isNotEmpty && currTitle == 1) {

        if(!RegExp("[2-9]").hasMatch(s)){
          switch (selectedItem){
            case "Двоичное":
              result = controller.text;
              break;
            case "Десятичное":
              result = int.parse(s, radix: 2).toString();;
              break;
            case "Восьмиричное":
              result = int.parse(s, radix: 2).toRadixString(8).toString();
              break;
            case "Шестнадцатиричное":
              result = int.parse(s, radix: 2).toRadixString(16).toString();
              break;
          }

        }else {
          result = "Вы ввели что то неверно...";
        }

      }if (s.isNotEmpty && currTitle == 0) {



        switch (selectedItem){
          case "Двоичное":
            result = int.parse(s).toRadixString(2);
            break;
          case "Десятичное":
            result = controller.text;
            break;
          case "Восьмиричное":
            result = int.parse(s).toRadixString(8);
            break;
          case "Шестнадцатиричное":
            result = int.parse(s).toRadixString(16);
            break;
        }

      }else if (s.isEmpty){
        result = "Здесь будет результат...";
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
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly // С таким фильтром могут быть введены только числа
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