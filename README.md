[BEEMARKET PPT 3차 병합본.pdf](https://github.com/ihyongi/beeMarket/files/6721742/BEEMARKET.PPT.3.pdf)
![화면 캡처 2021-06-27 233119](https://user-images.githubusercontent.com/73655077/123548455-ccc27500-d79f-11eb-859a-5f4ce57d7e91.jpg)


프로젝트 상세
- 온라인 쇼핑몰에서의 중간 유통 이윤을 생략하고 판매자와 구매자를
직접 연결시켜줌으로써 기존보다 더 저렴한 가격으로 판매를 할 수
있다는 오픈마켓의 취지에 맞춰 빅데이터 분석을위한 플랫폼을 웹으로
제작하여 자바로 통계를 내고 구글차트를 이용하여 통계를 시각화
해보았습니다.
- OS 및 DB : windows, Oracle
- 사용 Tool : Eclipse
- 프로그래밍 언어 : JAVA, JSP
- 웹표준 기술 : HTML, CSS, JavaScript, jQuery
- 프레임워크 : SpringMVC, MyBatis

역할 및 성과
- 1. 스토리보드 설계 : 사이트의 전반적인 설계에 주도적으로 참여했습니다

- 2. ERD 및 데이터베이스 설계 : 해당 프로젝트의 ERD를 설계, 각 기능별로 필요한 테이블, 컬럼을 설계하고 starUML로 제작하였습니다

- 3. 로그인 및 회원가입 페이지구현-주로 기능구현에 초점
- 가. 이메일 인증 및 닉네임 중복검사 기능 구현, 미입력 유효성 검사
- 나. 로그인, 회원가입, 비밀번호 찾기
- 다. 회원가입 및 비밀번호 찾기는 이메일 인증을 통하게 함

- 4. 판매자 페이지를 도맡아 처리함
- 가. 프로필 사진 등록 및 개인정보 수정 , 다음 우편번호 api 활용
- 나. 판매자 지갑에 구매확정시 금액이 적립되고 내역을 보여주게끔처리
- 다. 정산하기 페이지와 정산한 내역과 수수료(쇼핑몰 수익)를 차감하게끔 구현함
- 라. 판매자가 보기 쉽게하도록 통계분석페이지를 만들어 상품접속이 많은순, 실질적으로 구매량이 많은순, 전일대비 판매액을 비교해 어떤상품에 주력을 하게끔해야할지 판매자의 고민을 덜어주도록 그래프로 나타내었습니다

- 5. 상품관련 기능들 도맡아 처리함
- 가. 상품등록
- :상품에 따른 옵션들(옵션,가격,재고) 배열로 처리하여 ajax로 한번에 insert하였고 수정하고 배열로 삭제하기까지.. 등록된 상품내역은 ajax로 페이징으로 처리하는데 성공했습니다.. 이미지삽입을위해 ajax처리시 formdata로 구현했습니다
- 나. 판매현황
- :판매자별 구매내역 상태를 보여주고 배송처리부터 취소,반품,교환기능을 넣고 환불하는 과정에서 쇼핑몰 캐시로 환불해주는 등을 작업을 했습니다. 반품, 교환기능의 경우 신청내역을 구매자가 신청하여 사유를 확인해 판매자가 승인하게끔하고 추가배송비를 어떻게 처리하게할지 판매자가 선택하여 승인할 수있게 구현하였고 그 신청내역을 구매자가 진행상황을 볼 수 있게 하였습니다.
- 다. 입고추가
- :재고가 0개인 상품의 경우 주문을 못하도록 막아놓았고.. 할인가가 적용되었는지 옵션별로 여부를 확인할수 있게하여 모달로 입고를 추가할 수 있게했습니다. 이역시도 ajax를 이용해 구현했습니다.
- 라. 할인적용
- :할인을 적용하여 적용된 상품 메인페이지에서 상품내역을 보여줄 때 할인가를 보이게하였고 할인종료일이 지나면 할인상태를 n으로 바꾸고 등록된내역에서 삭제되게끔 구현했습니다

- 6. 채팅기능 담당
- ajax로 마찬가지로 구현하였고 메인화면의 구매자쪽과 관리자 다대일의관계로 채팅기능을 구현해본바가 있습니다. ui를 직접만들어보면서 작업을 해야했고 관리자쪽에서 function이 두번돌아 메시지가 두번보이는 이슈등이 있었지만 setClearTime()으로 이를 해결하였습니다.

- 7. 교환, 반품의 경우 사유별로 로그를 남게 해 송장번호를 관리할 수 있게 하였고 배송중에서 송장번호 처리 한번, 상품회수할때 한번, 교환배송준비중일때 한번 총 많게는 세번이 찍히게 구현하였습니다

- 8. 구매자쪽에서 구매확정시 처리
- 가. 배송완료상태에서 구매확정버튼 나타나게하고
- 나. 구매확정시 구매자의 등급별 적립%*구매액하여 구매자 캐시로 적립되게끔 구현하였습니다.
- 다. 구매확정시 마찬가지로 구매액-2500원의 금액을 판매자의 캐시로 적립하여 판매자의 수익으로 처리되게끔 만들었습니다.

- 9. 구매자쪽에서 취소, 교환, 환불처리
- 가. 취소신청의 경우에는 판매자가 배송중으로 상태를 바꾸기 전까지 취소를 신청 할 수 있게 했으며 취소 후 환불금액은 구매자의 캐시로 적립되게끔 만들었습니다.
- 나. 마찬가지로 배송완료시 교환, 환불을 처리할 수 있게 했고, 사유를 직접 작성 할 수 있도록 모달을 띄워 신청서를 작성할 수 있게 만들었습니다.
- 다. 교환신청시 해당 상품의 옵션목록을 다시띄워 선택하여 그 값으로 변경값을 저장
- 라. 교환, 환불 신청완료시 신청내역을 띄워 본인이 취소한 상품에 대해 내역을 확인할 수 있도록 모달을 띄워보여줬습니다.

- 10. 그 외 사이트 전반적인 기능이 잘 작동되도록 오류해결에 도움을 주었습니다.


