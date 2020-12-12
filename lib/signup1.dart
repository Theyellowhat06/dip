import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'signup2.dart';

String phoneNumber, lname, fname, password, type;

class SignUp1 extends StatefulWidget {
  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  TabController _controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Container(
              height: 30,
              color: Colors.deepPurple,
            ),
            new Container(
              color: Colors.deepPurple,
              child: new TabBar(
                controller: _controller,
                tabs: [
                  Tab(
                    text: "Хувь хүн",
                  ),
                  Tab(
                    text: "Албан байнуулаг",
                  ),
                ],
              ),
            ),
            /*new Container(
              height: MediaQuery.of(context).size.height - 80,
              child: TabBarView(
                children: [tab1(), tab2()],
              ),
            ),*/
            SizedBox(
              height: 100,
            ),
            Container(
              child: Text(
                "Бүртгэл                               ",
                style: TextStyle(fontSize: 28),
              ),
            ),
            Container(
              height: 350,
              child: TabBarView(
                children: [tab1(), tab2()],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    //color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                RaisedButton(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                  color: Colors.deepPurple,
                  onPressed: () {
                    lname == null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp2(
                                    phoneNumber, fname, lname, password, "1")))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp2(
                                    phoneNumber, fname, lname, password, "0")));
                    //_verifyPhone();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget tab1() {
    return Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Энэ хүү хэсэгт та өөрийн хувийн мэдээллийг бөглөх шаардлагатай",
              style: TextStyle(color: Colors.deepPurple),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Овог',
              ),
              onChanged: (value) {
                fname = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Нэр',
              ),
              onChanged: (value) {
                lname = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Утасны дугаар',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                phoneNumber = value;
              },
              validator: (value) {
                return value.length != 8 && value.length != 0
                    ? 'Утасны дугаар биш байна'
                    : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Нууц үг',
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              validator: (value) {
                return value.length < 8
                    ? 'Нууц үг 8-аас дээш тэмдэгттэй байна'
                    : null;
              },
            ),
          ],
        ));
  }

  Widget tab2() {
    return Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Энэ хүү хэсэгт байгуулагын мэдээллийг бөглөх шаардлагатай",
              style: TextStyle(color: Colors.deepPurple),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Байгуулагын нэр',
              ),
              onChanged: (value) {
                fname = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Утасны дугаар',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                phoneNumber = value;
              },
              validator: (value) {
                return value.length != 8 && value.length != 0
                    ? 'Утасны дугаар биш байна'
                    : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Нууц үг',
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              validator: (value) {
                return value.length < 8
                    ? 'Нууц үг 8-аас дээш тэмдэгттэй байна'
                    : null;
              },
            ),
          ],
        ));
  }
}
