import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menu.dart';
import 'signup1.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        //home: menu()); //MyHomePage(title: 'Login'),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _phone, _pass;
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  void initState() {
    super.initState();
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Нэвтрэх",
            icon: Icon(Icons.account_circle, color: Colors.white),
            color: Colors.deepPurple.shade500),
        ButtonState.loading:
            IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
            text: "Алдаа",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            text: "Success",
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      },
      onPressed: onPressedIconWithText,
      state: stateTextWithIcon,
    );
  }

  Future userLogin() async {
    ProgressDialog pr;
    pr = new ProgressDialog(context);
    var url = 'http://testfoxx.ga/login.php';
    var data = {'phone': _phone, 'pass': _pass};
    pr.update(message: "Loading");
    //pr.show();
    var response = await http.post(url, body: json.encode(data));
    var user = jsonDecode(response.body);
    //print(message.toString() + " \n" + message["lname"].toString());
    //pr.hide();
    if (user != '-') {
      print(user["type"]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => menu(user["id"].toString(), user["fname"],
                  user["lname"], user["phone"], user["type"].toString())),
          (route) => false);
      setState(() {
        stateOnlyText = ButtonState.idle;
        stateTextWithIcon = ButtonState.idle;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Хэрэглэгчийн мэдээлэл буруу байна"),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() {
        stateOnlyText = ButtonState.fail;
        stateTextWithIcon = ButtonState.fail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        /*appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),*/
        body: SingleChildScrollView(
      child: Form(
        //autovalidateMode: AutovalidateMode.always,
        child: ui(),
      ),
    ));
  }

  Column ui() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 140,
        ),
        Container(
          width: 120.0,
          height: 120.0,
          padding: EdgeInsets.all(20),
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.deepPurple[200], width: 5),
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/repair.svg",
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Утасны дугаар',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _phone = value;
                },
                validator: (value) {
                  return value.length != 8 ? 'Утасны дугаар биш байна' : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Нууц үг',
                ),
                obscureText: true,
                onChanged: (value) {
                  _pass = value;
                },
                validator: (value) {
                  return value.length < 8
                      ? 'Нууц үг 8-аас дээш тэмдэгттэй байна'
                      : null;
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
        ),
        buildTextWithIcon(),
        SizedBox(
          height: 10,
        ),
        FlatButton(
          child: Text("Бүртгүүлэх"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp1()));
          },
        )
      ],
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        userLogin();
        /*Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });*/

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
