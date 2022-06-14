# wanted_pre_onboarding
원티드 프리온보딩 iOS 코스 사전 과제 (날씨 정보 APP)
Open Weather API 활용

## 버전
- iOS 13.0

## Diagram
![Diagram](https://github.com/hhhan0315/wanted_pre_onboarding/blob/main/스크린샷/diagram.png)

## 구조
![구조](https://github.com/hhhan0315/wanted_pre_onboarding/blob/main/스크린샷/구조.png)

## 기능
![기능](https://github.com/hhhan0315/wanted_pre_onboarding/blob/main/스크린샷/기능.gif)

## 설명
- MVVM 구조를 사용했으며 Observable을 활용해 View와 ViewController 간의 Data Binding
- UITableViewDiffableDataSource을 활용해 화면 1 테이블뷰 구현
- GeoCoding API 호출 -> 해당 lat, lon으로 Current Weather Data Call -> WeatherModel 구현
- NSCache를 활용해 이미지 캐시 구현

## 커밋 메시지
- Convention
  - [Feat] : 기능 추가 / 새로운 로직
  - [Fix] : 버그 수정
  - [Style] : 코드 포맷팅, 코드 변경이 없는 경우
  - [Docs] : 문서 및 리드미 작성
  - [Refactor] : 리팩토링
