import 'package:flutter/material.dart';
import 'package:garakservice/meal_order_api.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Future<String> additionalInfoA1;
  late Future<String> additionalInfoB1;
  late Future<String> additionalInfoC1;

  @override
  void initState() {
    super.initState();
    additionalInfoA1 = UserSheetsApi.fetchA1Value();
    additionalInfoB1 = UserSheetsApi.fetchB1Value();
    additionalInfoC1 = UserSheetsApi.fetchC1Value();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    String tomorrowDate =
        DateFormat('yyyy-MM-dd (E)', 'ko_KR').format(tomorrow);
    return Scaffold(
      appBar: AppBar(
        title: const Text('가락고등학교 체육안전부',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CardWidget(
              cardName: '먼저 먹자\n$tomorrowDate',
              color: Colors.indigo,
              additionalInfoFuture: additionalInfoA1,
              textColor: Colors.white,
            ),
          ),
          Expanded(
            child: CardWidget(
              cardName: '급식실 이용 규칙',
              color: const Color.fromRGBO(66, 169, 155, 1),
              additionalInfoFuture: additionalInfoB1,
              textColor: Colors.white,
            ),
          ),
          Expanded(
            child: CardWidget(
              cardName: '체육안전부 공지',
              color: const Color.fromRGBO(254, 192, 167, 1),
              additionalInfoFuture: additionalInfoC1,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String cardName;
  final Color color;
  final Future<String> additionalInfoFuture;
  final Color textColor;

  const CardWidget({
    Key? key,
    required this.cardName,
    required this.color,
    required this.additionalInfoFuture,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: color,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  cardName,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                FutureBuilder<String>(
                  future: additionalInfoFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: textColor);
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}",
                          style: TextStyle(color: textColor));
                    } else {
                      return AutoSizeText(
                        snapshot.data ?? '데이터 없음',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
