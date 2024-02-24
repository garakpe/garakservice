import 'package:flutter/material.dart';
import 'package:garakservice/firstpage.dart';
import 'package:garakservice/secondpage.dart';
import 'package:garakservice/thirdpage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ko_KR', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Garak HighSchool',
      home: HomePage(), // home 속성을 사용하여 PageView를 포함하는 HomePage 위젯을 설정
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          FirstPage(), // FirstPage 위젯을 PageView의 첫 번째 페이지로 포함
          SecondPage(
              titleText: '가락고등학교 급식알리미',
              bodyText: 'ㅓㅓ'), // SecondPage 위접를 PageView의 두 번째 페이지로 포함
          ThirdPage(
            titleText: '가락고등학교 급식알리미',
            bodyText: 'ff',
          ), // ThirdPage 위젯을 PageView의 세 번째 페이지로 포함
        ],
      ),
    );
  }
}
