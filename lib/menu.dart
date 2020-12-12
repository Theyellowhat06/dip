import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';
import 'wheels.dart';
import 'light.dart';
import 'ItemList.dart';

class menu extends StatefulWidget {
  final String id, fname, lname, phone, type;
  menu(this.id, this.fname, this.lname, this.phone, this.type);
  _menu createState() => _menu();
}

class _menu extends State<menu> {
  bool isclicked;
  String cat, name;
  @override
  void initState() {
    // TODO: implement initState
    isclicked = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        /*appBar: AppBar(
          title: Text("Үндсэн цэс"),
          centerTitle: true,
        ),*/
        body: Stack(
      children: [
        Container(
            padding: EdgeInsets.only(top: 50),
            color: Colors.deepPurple,
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Icon(),
                FlatButton(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 25,
                  ),
                  minWidth: 10,
                  onPressed: () {},
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Сайн байна уу?",
                      style: TextStyle(color: Colors.white),
                    ),
                    widget.type == '1'
                        ? Text(
                            "${widget.fname}",
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          )
                        : Text(
                            "${widget.fname} ${widget.lname}",
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          ),
                    Text(
                      "ID:${widget.id}",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                Spacer(),
                FlatButton(
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 25,
                  ),
                  minWidth: 10,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                        (route) => false);
                  },
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(top: 120),
          padding: EdgeInsets.all(40),
          //color: Colors.white,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Text(
                name == null ? "Барааны ангилал" : name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              new Expanded(child: isclicked ? comp() : menu())
            ],
          ),
        ),
      ],
    ));
  }

  GridView menu() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.only(top: 20),
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      crossAxisCount: 2,
      //childAspectRatio: 0.7,
      children: <Widget>[
        OutlineButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/wheel.svg",
                height: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Дугуй")
            ],
          ),
          onPressed: () {
            setState(() {
              isclicked = true;
              cat = "wheel";
              name = "Дугуй";
            });
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/car-lights.svg",
                height: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Гэрэл")
            ],
          ),
          onPressed: () {
            setState(() {
              isclicked = true;
              cat = "light";
              name = "Гэрэл";
            });
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/damper.svg",
                height: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Амортизатор")
            ],
          ),
          onPressed: () {
            setState(() {
              isclicked = true;
              cat = "damper";
              name = "Амортизатор";
            });
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/gear.svg",
                height: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Мотор")
            ],
          ),
          onPressed: () {
            setState(() {
              isclicked = true;
              cat = "gear";
              name = "Мотор";
            });
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/car-door.svg",
                height: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Хаалга")
            ],
          ),
          onPressed: () {
            setState(() {
              isclicked = true;
              cat = "door";
              name = "Хаалга";
            });
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
      ],
    );
  }

  GridView comp() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.only(top: 20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 3,
      //childAspectRatio: 0.7,
      children: <Widget>[
        OutlineButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              isclicked = false;
              name = null;
            });
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/nissan.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "nissan", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/hyundai.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "hyundai", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/toyota.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "toyota", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/lexus.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "lexus", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/bmw.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "bmw", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/benz.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "benz", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/chevrolet.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "chevrolet", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Image.asset(
            "assets/ford.png",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "ford", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
        OutlineButton(
          child: Text("Бусад"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemsList(name, cat, "other", widget.type)),
            );
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          borderSide: BorderSide(color: Colors.deepPurple[200]),
        ),
      ],
    );
  }
}
