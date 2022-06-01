import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/states/user_provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage ({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey));

  TextEditingController _phoneNumberController =
    TextEditingController(text: "010");

  TextEditingController _codeController =
  TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains){

        Size size = MediaQuery.of(context).size;

        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formkey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('전화번호 로그인',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'assets/imgs/padlock.png',
                          width: size.width*0.15,
                          height: size.width*0.15,
                        ),
                        SizedBox(
                          width: common_sm_padding,
                        ),
                        Text('''토마토마켓은 휴대폰 번호로 가입해요.
번호는 안전하게 보관 되며
어디에도 공개되지 않아요.''')
                      ],
                    ),
                    SizedBox(height: common_padding,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      decoration: InputDecoration(
                        focusedBorder: inputBorder, border: inputBorder),
                        validator: (phoneNumber) {
                          if(phoneNumber !=null && phoneNumber.length == 13){

                          }else{
                            //error
                            return '전화번호를 올바르게 입력해주세요.';
                          }
                        }),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    TextButton(onPressed: (){
                      if(_formkey.currentState !=null) {
                        bool passed = _formkey.currentState!.validate();
                        print(passed);
                        if(passed)
                          setState(() {
                            _verificationStatus = VerificationStatus.codeSent;
                          });

                      }
                    },
                        child: Text('인증문자 발송')),
                    SizedBox(
                      height: common_padding,
                    ),
                    AnimatedOpacity(
                      duration: duration,
                      curve: Curves.easeInOut,
                      opacity: (_verificationStatus == VerificationStatus.none)
                          ?0
                          :1,
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: duration,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                              hintText: '인증번호를 입력하세요.',
                              hintStyle: TextStyle(color: Theme.of(context).hintColor),
                              focusedBorder: inputBorder, border: inputBorder),
                          ),
                      ),
                    ),
                    AnimatedContainer(
                        duration: duration,
                        curve: Curves.easeInOut,
                        height: getVerificationBtnHeight(_verificationStatus),
                        child: TextButton(onPressed: (){
                          attemptVerify();
                        }, child: (_verificationStatus ==
                            VerificationStatus.verifying)
                            ?CircularProgressIndicator(
                               color: Colors.white,
                             )
                            :Text('인증하기'))),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
      // TODO: Handle this case.
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 60 + common_sm_padding;
    }
  }

  double getVerificationBtnHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
      // TODO: Handle this case.
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });

    context.read<UserProvider>().setUserAuth(true);
  }

}


enum VerificationStatus{ none, codeSent, verifying, verificationDone }