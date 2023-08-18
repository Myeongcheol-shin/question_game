# trivia quiz Application (상식 퀴즈 앱)
플러터로 제작한 상식 퀴즈 앱입니다.

## 참고 자료
### OPEN TRIVIA OPENDATABASE - QUIZ API
**상식 퀴즈 API의 경우 "OPEN TRIVIA OPENDATABASE"의 "Quiz API"를 사용.**  
**링크 :** https://opentdb.com/api_config.php

## 사용 라이브러리
### flutter_Provider
위젯 간 상태 공유를 위해 사용
### http
Rest API 통신을 위해 사용

## 기능
* 20개 이상의 문제 카테고리 제공. [과학 / 스포츠 / 애니 등]
* 난이도 상 중 하 설정 가능
* 문제 타입 (사지선다, True/False , 혼합) 선택 가능
* 문제 수 설정 가능 (5 ~ 19개)

## 사용 방법
1. 화면의 카테고리를 자신이 원하는 유형으로 선택을 한다.
2. 선택이 완료가 되면, Start Game을 누른다.
3. 정해진 시간 내에 문제의 정답을 선택한다.
4. 문제가 선택이 완료가 되고 문제의 정답이 공개가 되면 확인 할 수 있다, 추가적으로 Next 버튼을 통해 다음 화면으로 넘어갈 수 있다.
5. 마지막 문제를 풀고 나면 점수 확인 버튼을 눌러 확인한다.

## 주의사항
문제 제한 시간이 좀 짧아요 (15초).

## 사용 영상
![화면 기록 2023-08-18 오후 9 51 04](https://github.com/Myeongcheol-shin/question_game/assets/82868004/ed71b396-c0e2-4e76-8bc4-05f886c26b4d)

## 제작 기간
2023-08-17 ~ 2023-08-18

## Pub dev
### circular_countdown_timer
**타이머 기능 구현을 위해 사용**
**링크 :** https://pub.dev/packages/circular_countdown_timer

### html_unescape
**API의 결과에 escape 문자열이 포함되어 있어 이를 파싱하기 위해 사용**
**링크 :** https://pub.dev/packages/html_unescape

### drop_down_button
**드롭 다운 버튼 구현을 위해 사용**
**링크 :** https://pub.dev/packages/dropdown_button2





