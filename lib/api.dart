import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getGPT3Response(String userInput) async {
  String model = "gpt-4-turbo-preview"; // 모델명 업데이트
  String apiKey = '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'; // 실제 API 키로 교체하세요
  String apiUrl = 'https://api.openai.com/v1/chat/completions'; // 엔드포인트 변경

  // 요청 시간 기록
  var startTime = DateTime.now();

  var response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'model': model,
      'messages': [
        {"role": "user", "content": userInput}
      ],
      'temperature': 0.7,
    }),
  );

  // 응답 완료 시간 기록
  var endTime = DateTime.now();

  //시간
  var duration = endTime.difference(startTime);
  print('Response time: ${duration.inMilliseconds} milliseconds');

  print(response.body);
  if (response.statusCode == 200) {

    print('응답 헤더: ${response.headers}');

    String? contentType = response.headers['content-type'];
    print('Content-Type: $contentType');

    var encoding = Encoding.getByName("utf-8") ?? utf8; // 기본적으로 UTF-8 사용

    if (contentType != null) {
      final charsetMatch = RegExp('charset=([\\w-]+)').firstMatch(contentType);
      if (charsetMatch != null) {
        final charset = charsetMatch.group(1);
        encoding = Encoding.getByName(charset) ?? encoding;
      }
    }

    var decodedResponse = encoding.decode(response.bodyBytes);
    var data = jsonDecode(decodedResponse);
    print(data['choices'][0]['message']['content']);
    return data['choices'][0]['message']['content']; // 응답 구조에 맞게 접근
  } else {
    throw Exception('Failed to load response: ${response.body}');
  }
}