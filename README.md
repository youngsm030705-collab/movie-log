# MovieLog

영화의 순간을 기록하는 Flutter 앱입니다. (UMC 0주차 과제)

## 개발 환경

- OS: macOS 26.6.2 (Apple Silicon)
- IDE: VS Code + Flutter/Dart Extension
- Flutter: 3.47.4 (stable)
- 실행 기기: Android Emulator (Pixel 9, API 35)

## 실행 화면

시작 화면 캡처는 `screenshots/` 폴더에 있습니다.

## 트러블슈팅 기록

**현상**: `flutter doctor -v` 실행 시 아래 에러 발생
Error: Flutter failed to create a directory at "/Users/.../.config/flutter".
Please ensure that the SDK and/or project is installed in a location that has read/write permissions for the current user.

**추정 원인**: `~/.config` 디렉토리의 소유자가 `root`로 되어있어서 Flutter가 해당 경로에 쓰기 권한이 없었음

**시도한 방법**: `ls -la ~/.config`로 소유자 확인

**실제 해결 방법**:
```bash
sudo chown -R $(whoami) ~/.config
```

**해결을 확인한 방법**: 다시 `flutter doctor -v` 실행 시 정상적으로 진단 결과 출력됨

## 학습 회고

Flutter 개발 환경을 처음부터 구성하면서 Android SDK, 에뮬레이터, VS Code 확장까지 하나씩 연결해보는 과정을 배웠습니다. 특히 권한 문제로 막혔던 부분을 직접 원인을 찾아 해결하면서 macOS 파일 시스템 권한 구조에 대해서도 조금 더 이해하게 됐습니다.

