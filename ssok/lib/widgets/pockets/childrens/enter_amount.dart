import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssok/http/http.dart';
import 'package:ssok/http/token_manager.dart';
import 'package:ssok/widgets/frequents/main_button.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({
    Key? key,
    required this.buttonTitle,
    required this.donateSeq
  }) : super(key: key);
  final String buttonTitle;
  final int donateSeq;

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}


class _EnterAmountState extends State<EnterAmount> {
  ApiService apiService = ApiService();

  int withDrawMoney = 0;

  void sendMoneyToDonate()async{
    final response = await apiService.postRequest('pocket-service/donate',{"donateSeq":widget.donateSeq.toString(),"donateAmt":withDrawMoney.toString()},TokenManager().accessToken);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.of(context).pushReplacementNamed('/main');
    }else if(response.statusCode == 400){ // 금액이 부족할떄 
      if(jsonDecode(response.body)['error']['status'] == 400){
          // ignore: use_build_context_synchronously
          showAlet("기부");
      }
    }else{
      showAlet("", msg2 : "오류발생", msg3 : "잠시후 다시 시도 해주세요.");
    }
  }

  void sendMoneyToMyAccount()async{
    final response = await apiService.postRequest('pocket-service/pocket/history',{"pocketHistoryType":"WITHDRAWAL","pocketHistoryTransAmt":withDrawMoney.toString()},TokenManager().accessToken);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.of(context).pushReplacementNamed('/main');
    }else if(response.statusCode == 400){ // 금액이 부족할떄 
      if(jsonDecode(response.body)['error']['status'] == 400){
          // ignore: use_build_context_synchronously
          showAlet("이체");
      }
    }else{
      showAlet("", msg2 : "오류발생", msg3 : "잠시후 다시 시도 해주세요.");
    }
  }


  void showAlet(String msg, {String? msg2, String? msg3}) async{
  await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                          msg2 != null ? msg2 : msg + "실패",
                          ),
                  content: Text(
                          msg3 != null ? msg3 : "보유 포켓머니가 부족합니다.",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  actions: <Widget>[  
                    TextButton(
                      onPressed: () { 
                        Navigator.of(context).pop();                       
                        },
                      child: Text("확인"),
                    ),
                  ],
                ),
              );
}



  void changeMoney(int money){
    setState(() {
      withDrawMoney = money;
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.1),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  onChanged: (text) {changeMoney(int.parse(text));}, // 텍스트 변경시 실행되는 함수
                  onSubmitted: (text) {}, // Enter를 누를 때 실행되는 함수
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 15),
                    contentPadding: EdgeInsets.only(top: screenHeight * 0.018),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04, top: screenHeight * 0.02),
                child: Text(
                  "원",
                  style: TextStyle(fontSize: 22),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.08),
        MainButton(
          title: widget.buttonTitle,
          onPressed: () {
            if(widget.donateSeq==0){
              sendMoneyToMyAccount();
            }else{
              sendMoneyToDonate();
            }
          }
        )
      ],
    );
  }
}
