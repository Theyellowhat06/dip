import 'package:flutter/material.dart';

class Wheels extends StatefulWidget {
  _Wheels createState() => _Wheels();
}

class _Wheels extends State<Wheels> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Гэрэл"),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://images.carid.com/lumen/items/custom-headlights.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width),
                Text(
                  "Lumen® - Custom Headlights",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Үнэ: 20.00USD - 930.00USD ",
                ),
                Text(
                  "Төрөл: Урд гэрэл",
                )
              ],
            ),
          )),
          Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://images.carid.com/lumen/items/custom-tail-lights.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width),
                Text(
                  "Lumen® - Custom Tail Lights",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Үнэ: 40.00USD - 499.33USD",
                ),
                Text(
                  "Төрөл: Ард гэрэл",
                )
              ],
            ),
          )),
          Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://images.carid.com/replace/page/factory-replacement-tail-lights.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width),
                Text(
                  "Replace® - Factory Tail Lights",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Үнэ: 10.95USD - 850.56USD",
                ),
                Text(
                  "Төрөл: Ард гэрэл",
                )
              ],
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
    );
  }
}
