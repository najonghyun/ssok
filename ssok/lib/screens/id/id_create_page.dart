import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../http/http.dart';
import 'package:http/http.dart' as http;
import '../../http/token_manager.dart';

class IdCreatePage extends StatefulWidget {
  const IdCreatePage({super.key});

  @override
  State<IdCreatePage> createState() => _IdCreatePageState();
}

class ImageAndData {
  final XFile image;
  final RecognizedRegCard data;

  ImageAndData({required this.image, required this.data});
}

class RecognizedRegCard {
  final String registrationCardName;
  final String registrationCardPersonalNumber;
  final String registrationCardAddress;
  final String registrationCardIssueDate;
  final String registrationCardAuthority;

  RecognizedRegCard(
      {required this.registrationCardName,
      required this.registrationCardPersonalNumber,
      required this.registrationCardAddress,
      required this.registrationCardIssueDate,
      required this.registrationCardAuthority});
}

class _IdCreatePageState extends State<IdCreatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _personalNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _authorityController = TextEditingController();

  ApiService apiService = ApiService();
  late String registrationCardName = "";
  late String registrationCardPersonalNumber = "";
  late String registrationCardAddress = "";
  late String registrationCardIssueDate = "";
  late String registrationCardAuthority = "";
  late XFile image;

  bool checkRegistrationCardName = false;
  bool checkRegistrationCardPersonalNumber = false;
  bool checkRegistrationCardAddress = false;
  bool checkRegistrationCardIssueDate = false;
  bool checkRegistrationCardAuthority = false;

  void register() async {
    if (checkRegistrationCardName &&
        checkRegistrationCardPersonalNumber &&
        checkRegistrationCardAddress &&
        checkRegistrationCardIssueDate &&
        checkRegistrationCardAuthority) {
      Map<String, String> requestData = {
        "registrationCardName": registrationCardName,
        "registrationCardPersonalNumber": registrationCardPersonalNumber,
        "registrationCardAddress": registrationCardAddress,
        "registrationCardIssueDate": registrationCardIssueDate,
        "registrationCardAuthority": registrationCardAuthority
      };
      var bytes = await File(image.path).readAsBytes();
      final response = await apiService.postRequestWithFile(
          'idcard-service/registration',
          'registrationCardCreateRequest',
          jsonEncode(requestData),
          TokenManager().accessToken,
          bytes);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        throw Exception('Failed to load');
      }
    }
  }

  /**
   * final TextEditingController _nameController = TextEditingController();
      final TextEditingController _personalNumberController = TextEditingController();
      final TextEditingController _typeController = TextEditingController();
      final TextEditingController _addressController = TextEditingController();
      final TextEditingController _numberController = TextEditingController();
      final TextEditingController _renewStartDateController = TextEditingController();
      final TextEditingController _renewEndDateController = TextEditingController();
      final TextEditingController _conditionController = TextEditingController();
      final TextEditingController _codeController = TextEditingController();
      final TextEditingController _issueDateController = TextEditingController();
      final TextEditingController _authorityController = TextEditingController();

      "licenseName": licenseName,
      "licensePersonalNumber": licensePersonalNumber,
      "licenseType": licenseType,
      "licenseAddress": licenseAddress,
      "licenseNumber": licenseNumber,
      "licenseRenewStartDate": licenseRenewStartDate,
      "licenseRenewEndDate": licenseRenewEndDate,
      "licenseCondition": licenseCondition,
      "licenseCode": licenseCode,
      "licenseIssueDate": licenseIssueDate,
      "licenseAuthority": licenseAuthority

      bool checkLicenseName = false;
      bool checkLicensePersonalNumber = false;
      bool checkLicenseAddress = false;
      bool checkLicenseIssueDate = false;
      bool checkLicenseAuthority = false;
      bool checkLicenseType = false;
      bool checkLicenseCode = false;
      bool checkLicenseNumber = false;
      bool checkLicenseRenewStartDate = false;
      bool checkLicenseRenewEndDate = false;
      bool checkLicenseCondition = false;

   */
  @override
  Widget build(BuildContext context) {
    final ImageAndData args =
        ModalRoute.of(context)!.settings.arguments as ImageAndData;
    registrationCardName = args.data.registrationCardName;
    registrationCardPersonalNumber = args.data.registrationCardPersonalNumber;
    registrationCardAddress = args.data.registrationCardAddress;
    registrationCardIssueDate = args.data.registrationCardIssueDate;
    registrationCardAuthority = args.data.registrationCardAuthority;
    image = args.image;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "주민등록증 정보 입력",
          style: TextStyle(
            fontSize: 19,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Color(0xFF676767),
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // 원하는 색상으로 변경
        ),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Center(
            child: Image(
              image: AssetImage('assets/horizonLogo.png'),
              width: 200.0,
            ),
          ),
          Form(
              child: Theme(
            data: ThemeData(
                primaryColor: Colors.grey,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0))),
            child: Container(
                padding: EdgeInsets.all(40.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: '이름'),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            registrationCardName = value.trim();
                            checkRegistrationCardName =
                                registrationCardName.isNotEmpty;
                          });
                        },
                      ),
                      TextField(
                        controller: _personalNumberController,
                        decoration: InputDecoration(labelText: '주민등록번호'),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            registrationCardPersonalNumber = value.trim();
                            checkRegistrationCardPersonalNumber =
                                registrationCardPersonalNumber.isNotEmpty;
                          });
                        },
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: '주소'),
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (value) {
                          setState(() {
                            registrationCardAddress = value.trim();
                            checkRegistrationCardAddress =
                                registrationCardAddress.isNotEmpty;
                          });
                        },
                      ),
                      TextField(
                        controller: _issueDateController,
                        decoration: InputDecoration(labelText: '발급일자'),
                        keyboardType: TextInputType.datetime,
                        onChanged: (value) {
                          registrationCardIssueDate = value.trim();
                          checkRegistrationCardIssueDate =
                              registrationCardIssueDate.isNotEmpty;
                        },
                      ),
                      TextField(
                        controller: _authorityController,
                        decoration: InputDecoration(labelText: '인증기관'),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            registrationCardAuthority = value.trim();
                            checkRegistrationCardAuthority =
                                registrationCardAuthority.isNotEmpty;
                          });
                        },
                      ),
                      Row(children: [
                        Expanded(
                          child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  // register();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent),
                                child: Icon(
                                  Icons.accessibility,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              )),
                        )
                      ]),
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
