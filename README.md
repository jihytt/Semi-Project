# Semi-Project

## 0. 소개

- **개발 목표** : 반려동물 정보와 일정을 기록하고 수의사와 온라인 화상 상담, 반려동물과 함께 출입 가능한 가게 검색 및 예약, 커뮤니티 등 반려동물 양육 가구가 꾸준하게 증가함에 따라 생활 편의성을 향상시키는 기능들을 한 곳에 모은 사이트 구축

<br/>

- **프로젝트명** : Pet Diary
- **개발 기간** : 2021.04.26 ~ 2021.05.07
- **인원** : 6명
- 📒 **프로젝트 기획서** : https://transparent-nebula-b31.notion.site/d78c1133c53a47d9ab657f422c4975cd

- **담당 역할** :
  - 프로젝트 개발 환경 구축
  - ERD 모델링
  - [로그인](https://github.com/jihytt/Semi-Project/blob/main/%EB%8B%B4%EB%8B%B9%ED%8C%8C%ED%8A%B8/%EB%A1%9C%EA%B7%B8%EC%9D%B8.md)
  - [회원가입](https://github.com/jihytt/Semi-Project/blob/main/%EB%8B%B4%EB%8B%B9%ED%8C%8C%ED%8A%B8/%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85.md)
  - [SNS 로그인(KAKAO,NAVER)](https://github.com/jihytt/Semi-Project/blob/main/%EB%8B%B4%EB%8B%B9%ED%8C%8C%ED%8A%B8/%EB%84%A4%EC%9D%B4%EB%B2%84%2C%EC%B9%B4%EC%B9%B4%EC%98%A4%20%EB%A1%9C%EA%B7%B8%EC%9D%B8.md)
  - [캘린더](https://github.com/jihytt/Semi-Project/blob/main/%EB%8B%B4%EB%8B%B9%ED%8C%8C%ED%8A%B8/%EC%BA%98%EB%A6%B0%EB%8D%94.md)
  - [챗봇](https://github.com/jihytt/Semi-Project/blob/main/%EB%8B%B4%EB%8B%B9%ED%8C%8C%ED%8A%B8/%EC%B1%97%EB%B4%87.md)

<br/>

## 1. 구현 기능

<br/>

**로그인/회원가입**
- 회원가입 : 정규표현식으로 각 input 유효성 검사, SMTP 이메일 인증 기능, 도로명 주소 API
- 로그인/로그아웃
- 네이버, 카카오 로그인
- 아이디 찾기, 임시 비밀번호 발급   

**마이페이지**
- 정보 수정, 회원 탈퇴, 비즈니스 계정 신청
- 사진첩, 작성 여행 계획, 작성 게시글 및 댓글, 예약 및 결제 내역 조회 기능

**다이어리**
- 반려동물 사진 및 정보 등록
- 캘린더를 통한 일정 확인, 추가, 수정, 삭제 기능

**나와 닮은 동물 찾기**
- teachable machine API를 이용하여 학습시킨 사진을 토대로 웹캠 및 사진 업로드를 통해 사용자와 닮은 동물을 알려주는 기능

**병원 상담**
- Web-RTC를 활용한 수의사와 1:1 화상 상담 기능

**가게 예약**
- 가게 예약 및 웨이팅 시스템 제공

**커뮤니티**
- 글쓰기, 삭제, 수정 조회 / 댓글 작성 / 좋아요 기능
- 글 검색, 게시글 신고 기능
- 비속어 필터링 기능 (꼬꼬마 형태소 분석기 API)

**날씨 예보**
- 기상청 오픈 API를 이용하여 선택한 지역의 3일간의 날씨와 강수 확률 확인

**지도**
- KAKAO MAP API
- 원하는 위치의 가게, 병원 검색 및 DB와 연결된 연계 업체 검색

**예약**
- 병원 상담, 가게 예약 및 가게 웨이팅 시스템 기능
- 예약 시 예약 현황을 문자 메시지로 전송

**결제**
- 예약금 결제 기능, 결제 취소 (아임포트 API)

**챗봇**
- 대화처리 API를 이용하여 반려동물 섭취 음식 관련 질의응답 및 연계 가게 및 병원 예약이 가능한 챗봇 기능 (GenieDialog대화 모델링 구축 도구)

**관리자 기능**
- 신고된 게시글 관리, 회원 등급 관리, 회원 리스트 조회

<br/>

## 2. 개발 환경
  - **OS** : `Window 10`
  - **IDE** : `Eclipse`, `VSCODE`
  - **Front-end** : `HTML`, `CSS`, `JSP`, `JavaScript`, `JQuery`, `Ajax`
  - **Back-end** :
     Language - `JAVA`   
     Server - `Apache Tomcat 9.0`   
     DataBase - `ORACLE 11g with SqlDeveloper`   
     Framework - `Mybatis-3.5.7`
  - **버전관리** : `Git`, `Github`

<br/>

## 3. DB ERD
&emsp; ![DB](https://user-images.githubusercontent.com/75427390/146677101-ba8a7608-158d-4653-b7a0-0c7a0444acc1.png)  
