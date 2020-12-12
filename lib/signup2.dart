import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'menu.dart';
import 'package:http/http.dart' as http;

class SignUp2 extends StatefulWidget {
  final String phone, fname, lname, pass, type;
  SignUp2(this.phone, this.fname, this.lname, this.pass, this.type);
  _SingUp2 createState() => _SingUp2();
}

class _SingUp2 extends State<SignUp2> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;

  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
    //senddata();
  }

  Future<List> senddata() async {
    print("pass");
    print(
        "${widget.fname}\n${widget.lname}\n${widget.phone}\n${widget.pass}\n");
    final response = await http.post("http://testfoxx.ga/createUser.php",
        body: json.encode({
          "fname": widget.fname,
          "lname": widget.lname,
          "phone": widget.phone,
          "pass": widget.pass,
          "type": widget.type,
        }));

    var datauser = json.decode(response.body);
    print(datauser.toString());
    if (datauser.toString() == '+') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => menu(
                  "", widget.fname, widget.lname, widget.phone, widget.type)),
          (route) => false);
    }
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+976${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menu("", widget.fname, widget.lname,
                          widget.phone, widget.type)),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Баталгаажуулалт",
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${widget.phone} утасны дугаарт илгээгдсэн 6 оронтой нууц кодыг оруулна уу.",
            style: TextStyle(color: Colors.deepPurple),
          ),
          SizedBox(
            height: 10,
          ),
          PinCodeFields(
            keyboardType: TextInputType.number,
            length: 6,
            autofocus: true,
            activeBorderColor: Colors.deepPurple,
            onComplete: (pin) async {
              try {
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: pin))
                    .then((value) async {
                  if (value.user != null) {
                    senddata();
                  }
                });
              } catch (e) {
                FocusScope.of(context).unfocus();
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text('invalid OTP')));
              }
            },
          ),
          /*RaisedButton(
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
            color: Colors.deepPurple,
            onPressed: () {},
          ),*/
        ],
      ),
    ));
  }
}
