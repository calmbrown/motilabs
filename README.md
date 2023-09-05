# motilabs

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# flutter 설치
https://docs.flutter.dev/get-started/install

# 아이폰에 앱 실행하기
https://msyu1207.tistory.com/entry/flutter-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%83%9D%EC%84%B1-%EB%B0%8F-iPhone%EC%97%90%EC%84%9C-%EC%8B%A4%ED%96%89%ED%95%B4%EB%B3%B4%EA%B8%B0for-Mac

# VPN 기기 관리에서 앱 허용
https://kth496.tistory.com/9

# IOS 아이콘 제너레이터
https://www.appicon.co/
https://icon.kitchen/i/H4sIAAAAAAAAA6tWKkvMKU0tVrKqVkpJLMoOyUjNTVWySkvMKU6t1VHKzU8pzQHJRisl5qUU5WemKOkoZeYXA8ny1CSl2FoApT8%2BHkAAAAA%3D

# IOS 앱 아이콘 변경하기
https://asufi.tistory.com/entry/Flutter-Flutter-%EC%95%B1-%EC%B6%9C%EC%8B%9C-%ED%95%98%EA%B8%B0-relea

# IOS 앱 이름 변경
https://dev-yakuza.posstree.com/ko/flutter/app-name/

# vscode flutter config, hot reload
https://dev-yakuza.posstree.com/en/flutter/vscode-settings/#hot-reload

# 코딩애플 flutter 강의 ( 6강 )
https://www.youtube.com/watch?v=Y1Q4-GxIUHc&list=PLfLgtT94nNq1izG4R2WDN517iPX4WXH3C&index=7&ab_channel=%EC%BD%94%EB%94%A9%EC%95%A0%ED%94%8C

주요 위젲
- Container
- Scaffold ( AppBar, body, bottomNavigationBar )
- Row ( 좌우로 뻗어 나갈때 )
- Column ( 위아래로 뻗어나갈때 )
- ListView ( Column 대신 쓰면 좋으며 스크롤도 되고, 보여지는 부분만 써서 메모리 아낄 수 있다)
- Custom Wiget ( 위젯이 너무 길 경우 함수처럼 빼서 써도 된다, 변수로도 가능하나 성능이슈가 있을 수 있어 바뀌지 않는경우에 이용하는게 좋다  )
- 위젯 크기 설정 가능한데, 비율도 가능하고 Extension으로 나머지 공간 최대화 할 수도 있다.
- 위젯 감싸기 ( 왼쪽 전구표시 눌러서 자동 감싸기도 가능 )

# 기본 메모기능 구현
폴더 리스팅
메모 추가
메모 노트 페이지
리스트, 맵 데이터 구조

# SQLite 적용한 DB
폴더 까지는 진행함, 다만 자동 리로드가 안됨, 이거 참고해도 될듯
자동 리로드 setState()로 감싸서 해결함
setState(() {
    insertFolder(newFolderName);
});
https://luvris2.tistory.com/706

delete가 좀 이상한듯..? (index를 정확히 불러오지 못하는거같)

# cocoapods 설치
sudo gem install activesupport -v 6.1.7.6
sudo gem instasll cocoapods

# Android sdk 설치
Android studio > SDK Manager > SDK Tools > ANdroid SKD Commandline Tools 체크 > 설치
flutter docter

# xcode에서 라이브러리 못찾을때
flutter build ios

# flutter 개발 vscode extention
https://getechnews.com/visual-studio-code-extensions-to-improve-your-flutter-app-development-a9b18fae2c6e

# Future 에 대해서

# 앱 출시하기
https://velog.io/@minji0801/%EC%95%B1%EC%8A%A4%ED%86%A0%EC%96%B4%EC%97%90-%EC%95%B1-%EB%93%B1%EB%A1%9D%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95%EC%9D%84-%EB%AA%A8%EB%A5%B4%EA%B2%A0%EB%8B%A4

# SQLite 겨우 적용했다
애초에 DB 넣지 않고 설계를 해서 상태 저장 여부와 Future를 통해서 
비동기 식의 데이터를 어떻게 처리하고 불러와야하는지를 몰라서 많이 해맸다.

# 와 vscode에서 SQLite 볼 수 있는 방법
var databasesPath = await getDatabasesPath();
String path = join(databasesPath, 'my_database.db');
print("Database path: $path");  // 로그로 경로 출력

위 출력된 경로 
Sqlite 플러그인 깔고 Cmd + Shift + p > SQLite: Open Database > 경로로 검색
Finder에서 Cmd + Shift + G 하면 로그에 나온 폴더 경로로 접근 가능
경로 예시 : /Users/taemin/Library/Containers/com.example.motilabs/Data/Documents/memos.db

# TO-BE 0828
- 오른쪽 하단 팬 버튼을 눌러 메모 바로 작성하게 디자인
- 상단에 좌우 슬라이드 메모 패널 어떻게 삽입할지 > 메모지마다 중요표시 버튼으로 토글된것 상단 슬라이스되게
- 전체적인 디자인, 톤, dark mode
- AOS도 출시..?
- Memoscreen > title 일체화, 메모 스크린에서 바로 타이틀 수정 가능하게끔, 맨 상단을 타이틀로 ( 이건 db 수정 필요하겠네 )
- 이미지 삽입(붙여넣기도 되나..?)
- 검색 ( 제목, 컨텐츠 동시에 ) > 혹시 DB 형태를 바꿔야하나?
