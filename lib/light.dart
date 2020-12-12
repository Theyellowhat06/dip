import 'package:flutter/material.dart';

class Light extends StatefulWidget {
  _Light createState() => _Light();
}

class _Light extends State<Light> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Дугуй"),
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
                    'https://images.carid.com/pirelli/pirelli-p-zero-nero.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width),
                Text(
                  "PIRELLI® - P ZERO NERO",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Үнэ: 121.22USD - 484.88USD",
                ),
                Text(
                  "Төрөл: Зун",
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
                    'https://images.carid.com/michelin/michelin-energy-saver.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width),
                Text(
                  "MICHELIN® - ENERGY SAVER",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Үнэ: 155.04USD - 620.16USD",
                ),
                Text(
                  "Төрөл: Зун",
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
