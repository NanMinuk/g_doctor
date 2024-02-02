import 'package:flutter/material.dart';
import '/widgetsrc/answerscreen.dart';
import '/widgetsrc/fullanswerscreen.dart';
import '/widgetsrc/guideScreen.dart';
import '/widgetsrc/whitebackground.dart';
import 'api.dart';
import 'helpDialog.dart';
import 'widgetsrc/bluebackground.dart';
import 'widgetsrc/baseOption.dart';
import 'widgetsrc/helpIconButtion.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp을 사용하여 앱을 초기화합니다.
    return const MaterialApp(
      // 첫 번째 페이지로 이동
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';

  void _onMicPressed() async {
    await _startListening();
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        print('onStatus: $val'); // 상태 출력
      },
      onError: (val) {
        print('onError: $val'); // 오류 출력
      },
    );
    if (available) {
      _speech.listen(
        localeId: "ko-KR",
        onResult: (val) {
          print('onResult: ${val.recognizedWords}'); // 인식된 결과 출력
          if (val.finalResult) {
            setState(() {
              _isListening = false;
              _recognizedText = val.recognizedWords;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage(recognizedText: _recognizedText)),
            );
          }
        },

      );
    } else {
      print('음성 인식을 사용할 수 없음'); // 초기화 실패 출력
    }
  }
  @override
  Widget build(BuildContext context) {

    // Scaffold는 앱의 기본 구조를 제공합니다.
    return Scaffold(
      appBar: homeAppBar(title: '지박사'),

      body: Stack(
        children: [
          // 파란색 네모 배경 (30%)
          const BlueBackgroundBox(),
          // 하얀색 네모(안내창) 배경 (60%부터 70%까지, 가로 길이는 40%부터 60%까지, 가로 기준으로 가운데 정렬)
          GuideScreen(
            text: "클릭 후 말씀해주세요",
            textStyle: standardTextStyle(),
            topPercentage: 0.4, // 화면 높이의 40% 위치에
            alignX: 0.0,
          ),
          // 하얀색 네모(질문창) 배경 (20%부터 40%까지, 가로 길이는 40%부터 60%까지, 가로 기준으로 가운데 정렬)
          EmptyAnswerScreen(),
          // 하얀색 네모 배경 (70%)
          const WhiteBackgroundbox(),
          // 두 번째 페이지로 이동하는 버튼 추가
          // 마이크 버튼 추가
          Positioned(
            top: MediaQuery.of(context).size.height * 0.60,
            left: MediaQuery.of(context).size.width * 0.5 - 25,
            child: Container(
              decoration: MicBoxDecoration(),
              child: IconButton(
                icon: const Icon(
                  Icons.mic,
                  size: 50,
                  color: Colors.white, // 마이크 아이콘의 색상
                ),
                onPressed: () {
                  _onMicPressed();//음성인식 호출
                  // 두 번째 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage(recognizedText: _recognizedText, speech: _speech)),
                  );
                },
              ),
            ),
          ),
          // 도움말 버튼 추가
          HelpIconButton(
            onPressed: () => showHelpDialog(context),
              )
         ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String recognizedText;
  final stt.SpeechToText speech; // SpeechToText 인스턴스 추가

  const SecondPage({Key? key, required this.recognizedText, required this.speech}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void _stopListening() async {
    await widget.speech.stop(); // 음성 인식을 멈춤
    setState(() {
      // 필요한 상태 업데이트 (예: UI 변경)
    });
  }
  @override
  Widget build(BuildContext context) {
    // 두 번째 페이지의 UI를 정의
    return Scaffold(
      appBar: midAppBar(title: '지박사', context: context),
      body: Stack(
        children: [
          // 상단 30%까지 파란 박스
          BlueBackgroundBox(),
          // 하얀 박스(안내창)
          GuideScreen(text: '듣는 중....', textStyle: standardTextStyle()),
          // 하얀 박스(질문창)
          FullAnswerScreen(text: widget.recognizedText, textStyle: standardTextStyle()),
          //하얀박스 배경 부분
          WhiteBackgroundbox(),
          // 로딩창 버튼 추가
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.4,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          //세번째 페이지 이동 부분
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _stopListening();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThirdPage(recognizedText: widget.recognizedText)),
          );
        },
        child: Icon(Icons.stop, color: Colors.white),
        backgroundColor: Colors.blue,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // 위치 변경

    );
  }
}


class ThirdPage extends StatefulWidget {
  final String recognizedText;

  const ThirdPage({Key? key, required this.recognizedText}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    super.initState();
    // 3초 후에 네 번째 페이지로 자동 이동
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FourthPage(recognizedText: widget.recognizedText),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //상단 바
      appBar:midAppBar(title: '지박사', context: context),
      body: Stack(
        children: [
          //파란 배경 박스
          BlueBackgroundBox(),
          //하얀 박스 (안내창)
          GuideScreen(text: '답변 생성중...', textStyle: standardTextStyle()),
          //하얀 박스(질문 창)
          FullAnswerScreen(text: widget.recognizedText, textStyle: standardTextStyle()),
          //하얀 배경 박스
          WhiteBackgroundbox(),
          // 로딩창 버튼 추가
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.4,
            child: const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class FourthPage extends StatefulWidget {
  final String recognizedText;

  const FourthPage({Key? key, required this.recognizedText}) : super(key: key);

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  String gptResponse = "잠시만 기다려 주세요..."; // 초기값

  @override
  void initState() {
    super.initState();
    fetchGPTResponse(); // API 호출
  }

  void fetchGPTResponse() async {
    String userInput = "안녕 gpt, 너는 지박사라는 노인 도우미를 연기해야해. 질문에 친절하게 대답해줘. 지금 너에게 질문하는 사람은 스마트폰의 여러 기능에 대해 물어볼 노인이야 질문에 열심히 대답해줘. 대답은 스마트폰을 처음 쓰는 사람 도 알아들을 수 있을만큼 자세하게 절차 하나하나 구체적으로 부탁할께 . 본격적인 답변 앞에 간단한 인사말도 덧붙혀줘 그리고 답변은 절차별로 숫자 붙혀서 제시해줘 답변 별로 한줄에 한문장씩 나오게하는 것도 잊지 말고질문 : " + widget.recognizedText;
    print(userInput);
    String response = await getGPT3Response(userInput);
    setState(() {
      gptResponse = response; // API 응답으로 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //상단 바
      appBar: homeAppBar(title: '지박사'),
      body: Stack(
        children: [
          //파란 배경 박스
          BlueBackgroundBox(),
          //하얀 박스 (답변창)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: MediaQuery.of(context).size.width * 0.3 - MediaQuery.of(context).size.width * 0.4 / 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity((0.2)),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16), // 좌우 마진 추가
                child: SingleChildScrollView(
                  child: Text(
                    gptResponse,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify, // 텍스트 정렬 조정
                    softWrap: true,
                  ),
                ),
              ),

            ),
          ),
          FullAnswerScreen(text: widget.recognizedText, textStyle: standardTextStyle()),
          //하얀 배경 박스
          WhiteBackgroundbox(),
          // Refresh 아이콘 버튼 추가
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7 - 30, // 80% 위치에서 30픽셀 위로
            left: MediaQuery.of(context).size.width * 0.2, // 화면 가로 중앙에서 왼쪽으로 이동
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    // handleRefresh 함수 호출
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => FourthPage(recognizedText: widget.recognizedText)),
                    );
                  },
                ),
                const SizedBox(height: 5), // 간격 조절
                const Text(
                  "답변 다시 듣기",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15, // 원하는 크기로 조절
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          // 질문 다시하기 아이콘 추가
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7 - 30,
            left: MediaQuery.of(context).size.width * 0.8 - 80,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.mic,
                      size: 40,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //첫 번째 페이지로 이동
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => FirstPage()),
                            (Route<dynamic> route) => false, // false를 반환하여 모든 이전 루트를 제거
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5), // 간격 조절
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    "질문 다시하기",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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

