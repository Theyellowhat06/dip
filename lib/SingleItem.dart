import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class SingleItem extends StatefulWidget {
  final String id,
      name,
      type,
      price,
      color,
      size,
      mark,
      company,
      date,
      item_loc,
      archive_loc,
      stock,
      user_type,
      title;
  SingleItem(
    this.id,
    this.name,
    this.type,
    this.price,
    this.color,
    this.size,
    this.mark,
    this.company,
    this.date,
    this.item_loc,
    this.archive_loc,
    this.stock,
    this.user_type,
    this.title,
  );
  _SingleItem createState() => _SingleItem();
}

class _SingleItem extends State<SingleItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network('http://testfoxx.ga/img/${widget.id}.png',
                width: MediaQuery.of(context).size.width),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "ID: ${widget.id}",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Үнэ: ${widget.price}MNT",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        Text(
                          "Тоо ширхэг: ${widget.stock}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),

                  /*Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Үнэ: ${widget.price}MNT",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                ),*/
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Нэмэлт мэдээлэл",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Марк: ${widget.mark}",
                              style: TextStyle(fontSize: 16)),
                          Text("Компани: ${widget.company}",
                              style: TextStyle(fontSize: 16)),
                          Text("Төрөл: ${widget.type}",
                              style: TextStyle(fontSize: 16)),
                          widget.user_type == '1'
                              ? Text("Байршил: ${widget.archive_loc}",
                                  style: TextStyle(fontSize: 16))
                              : Text("Байршил: ${widget.item_loc}",
                                  style: TextStyle(fontSize: 16)),
                          Text("Үйлдвэрлэсэн он: ${widget.date}",
                              style: TextStyle(fontSize: 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Өнгө:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(
                                Icons.circle,
                                color: Color(int.parse(
                                    widget.color.toUpperCase(),
                                    radix: 16)),
                                size: 30,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
