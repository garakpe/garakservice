import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
// 날짜 포맷을 위한 intl 패키지 추가
import 'package:garakservice/api_service.dart';
// 이 부분은 fetchAndParseJson 함수가 정의되어 있는 가정

class ThirdPage extends StatelessWidget {
  final String titleText;
  final String bodyText;

  const ThirdPage({
    Key? key,
    required this.titleText,
    required this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 현재 날짜와 요일을 포맷팅
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final formatter = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR');
    final formattedDate = formatter.format(tomorrow);

    return Scaffold(
      backgroundColor: const Color(0xff1eb090),
      appBar: AppBar(
        backgroundColor: const Color(0xff1eb090),
        title: Text(
          titleText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true, // 페이지 타이틀을 AppBar에 표시
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  formattedDate, // '가락고등학교 급식알리미' 대신 현재 날짜와 요일을 표시
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset('assets/images/image1.png'),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '내일의 메뉴',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<String>(
                    future: fetchAndParseJsonTomorrow(), // 비동기 데이터 로딩 함수
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SpinKitFadingCircle(
                          color: Colors.white,
                          size: 30.0,
                          duration: Duration(seconds: 2),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              snapshot.data ?? '',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
