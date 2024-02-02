import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getGPT3Response(String userInput) async {
  String modelname = "text-davinci-003";
  String apiKey = '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';
  String apiUrl = 'https://api.openai.com/v1/engines/$modelname/completions';

  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({'prompt': userInput, 'max_tokens': 1000, 'temperature': 0.5}),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return data['choices'][0]['text'];
  } else {
    throw Exception('Failed to load response');
  }
}

// // 상태 관리 클래스
// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }
//
// class _MyWidgetState extends State<MyWidget> {
//   String gptResponse = "GPT 답변"; // 초기값
//
//   @override
//   void initState() {
//     super.initState();
//     fetchGPTResponse(); // API 호출
//   }
//
//   void fetchGPTResponse() async {
//     String userInput = "안녕 gpt, 너는 지박사라는 노인 도우미를 연기해야해. 질문에 친절하게 대답해줘. 어이 지박사, 내가 화면 확대하는 법을 모르겠어. 아들이 손가락으로 뭐 어떻게 하면 된다는데 알려줘";
//     String response = await getGPT3Response(userInput);
//     setState(() {
//       gptResponse = response; // API 응답으로 상태 업데이트
//     });
//   }
