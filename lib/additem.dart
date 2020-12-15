import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'ItemList.dart';

class AddItem extends StatefulWidget {
  final String title, cat, subcat;
  AddItem(this.title, this.cat, this.subcat);
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  Color currentColor = Colors.blue;
  var _pickedImage;
  String name,
      mark,
      company,
      type,
      price,
      color,
      size,
      date,
      item_loc,
      archive_loc,
      stock,
      bs64;

  void changeColor(Color color) => setState(() => currentColor = color);

  void _upload() async {
    print("\nbase64: $bs64\n");
    final response = await http.post("http://testfoxx.ga/insertTest.php",
        body: json.encode({
          "name": name,
          "color": currentColor.value.toRadixString(16),
          "size": '0',
          "price": price,
          "date": date,
          "company": company,
          "mark": mark,
          "type": type,
          "cat": widget.cat,
          "img": bs64,
          "subcat": widget.subcat,
          "item_loc": item_loc,
          "archive_loc": archive_loc,
          "stock": stock,
        }));
    Navigator.pop(context);
    Navigator.pop(context);
    //var datauser = json.decode(response.body);
    //print("Result: ${datauser.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Нэмэх"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            FlatButton(
              height: 200,
              child: bs64 == null
                  ? Icon(
                      Icons.image,
                      size: 200,
                      color: Colors.grey,
                    )
                  : SizedBox(
                      height: 200,
                      //width: 140,
                      child: pic(bs64),
                    ),
              onPressed: () {
                _showPickOptionsDialog(context);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                //icon: Icon(Icons.phone),
                labelText: 'Нэр',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      //icon: Icon(Icons.phone),
                      labelText: 'Марк',
                    ),
                    onChanged: (value) {
                      mark = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      //icon: Icon(Icons.phone),
                      labelText: 'Компани',
                    ),
                    onChanged: (value) {
                      company = value;
                    },
                  ),
                )
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                //icon: Icon(Icons.phone),
                labelText: 'Төрөл',
              ),
              onChanged: (value) {
                type = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Агуулахын байршил',
              ),
              onChanged: (value) {
                archive_loc = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Барааны байршил',
              ),
              onChanged: (value) {
                item_loc = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Тоо ширхэг',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                stock = value.toString();
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Нэг бүрийн үнэ',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                price = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 14),
                  child: Text(
                    "Өнгө:",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  //elevation: 3.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select a color'),
                          content: BlockPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                          ),
                          actions: [
                            RaisedButton(
                              child: Text("Дуусгах"),
                              onPressed: () {
                                print(
                                    '${currentColor.value.toRadixString(16)}');
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.circle,
                    color: currentColor,
                    size: 50,
                  ),
                  //color: currentColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Үйлдвэрлэсэн он:",
                  style: TextStyle(fontSize: 16),
                ),
                FlatButton(
                  child: Text(
                    date == null ? "YYYY-MM-DD" : date,
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1940),
                            lastDate: DateTime.now())
                        .then((value) {
                      setState(() {
                        date = value.toString().substring(0, 10);
                      });
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              padding:
                  EdgeInsets.only(top: 18, bottom: 18, left: 50, right: 50),
              color: Colors.deepPurple,
              child: Text(
                "Нэмэх",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () {
                _upload();
              },
            ),
          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source, maxWidth: 1000);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.deepPurple,
        toolbarColor: Colors.deepPurple,
        activeControlsWidgetColor: Colors.deepPurple,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        bs64 = base64Encode(cropped.readAsBytesSync());
        //_pickedImage = cropped;
        //_upload(cropped);
      });
    }
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Pick from Gallery"),
              onTap: () {
                _loadPicker(ImageSource.gallery);
              },
            ),
            ListTile(
              title: Text("Take a pictuer"),
              onTap: () {
                _loadPicker(ImageSource.camera);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget pic(String _bs64) {
    var bytes = base64.decode(_bs64);
    return Image.memory(bytes);
  }
}
