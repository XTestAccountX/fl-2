
import 'package:flutter/material.dart';
import 'package:lab2_conv/Converters/ConverterShaverma.dart';
import 'ButtonData.dart';
import 'Converters/ConverterBinary.dart';
import 'Converters/ConverterGb.dart';
import 'Converters/ConverterInch.dart';
import 'Converters/ConverterViews.dart';

class ConverterMain extends StatelessWidget{
  const ConverterMain({super.key});


  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.grey.shade200,
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1,

          //
          // Десятичное в двоичный
          //
          // Метр - дюйм
          //
          // Гигбайты в байты
          //
          // Просмотры в доллары
          //
          // Рубли в количество шаурмы
          //

          crossAxisCount: 2,
          children: CreateButtons(context),
        )
    );
  }
}

Widget CreateButton(ButtonData buttonData, BuildContext context) {
  return FloatingActionButton(
    onPressed: () {

      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => buttonData.destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ));
    },
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            buttonData.image,
            height: 100,
          ),
          Text(buttonData.text)
        ],
      ),
    ),
  );
}

List<Widget> CreateButtons(BuildContext context) {
  String path = "assets/images/";
  List<ButtonData> buttons = [
    ButtonData("Число в дв. код", "${path}binary.png", ConverterBinary()),
    ButtonData("Метр в дюйм", "${path}inch.png", ConverterInch()),
    ButtonData("Гигабайты в байты", "${path}gb.png", ConverterGb()),
    ButtonData("Просмотры в \$\$\$", "${path}eye.png", ConverterViews()),
    ButtonData("Рубли в шаурму", "${path}shaverma.png", ConverterShaverma()),
    // и так далее для остальных кнопок
  ];

  List<Widget> l = [];

  for (int i = 0; i < buttons.length; i++) {
    l.add(CreateButton(buttons[i], context));
  }
  return l;
}
