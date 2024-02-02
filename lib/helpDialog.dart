import 'package:flutter/material.dart';

void showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('도움말'),
        content: const SingleChildScrollView(
          child: ListBody(
            children:  [
              Text('1. 마이크 버튼을 클릭해주세요'),
              Text('2. 스마트폰의 궁금한 기능을 말씀해주세요'),
              Text('3. 지박사가 궁금한 내용을 답해줄 거에요'),
              Text('4. 답변이 이해가 안 되시면 답변 다시듣기 버튼을 눌러주세요'),
              Text('5. 추가로 질문하고 싶으면 질문 다시하기 버튼을 눌러주세요'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('닫기'),
          ),
        ],
      );
    },
  );
}