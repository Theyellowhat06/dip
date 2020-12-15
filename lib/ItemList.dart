import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Item.dart';
import 'additem.dart';
import 'SingleItem.dart';

class ItemsList extends StatefulWidget {
  final String title, cat, subcat, type;
  final List<String> list = List.generate(10, (index) => "Text $index");
  ItemsList(this.title, this.cat, this.subcat, this.type);
  _ItemsList createState() => _ItemsList();
}

class _ItemsList extends State<ItemsList> {
  List<Item> items = [];
  Future<List<Item>> _pullData() async {
    Item _item;
    List<Item> _items = [];
    var url = "http://testfoxx.ga/getItems.php";
    var data = {'cat': widget.cat, 'subcat': widget.subcat};
    var response = await http.post(url, body: json.encode(data));
    var jsonData = jsonDecode(response.body);
    for (var i in jsonData) {
      //print("${i["id]}");
      _item = Item(
          i["id"].toString(),
          i["name"],
          i["type"],
          i["price"].toString(),
          i["color"],
          i["size"].toString(),
          i["mark"],
          i["company"],
          i["made_date"],
          i["item_loc"],
          i["archive_loc"],
          i["stock"].toString());

      _items.add(_item);
    }
    items = _items;
    return _items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: Search(items, widget.title, widget.type));
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: FutureBuilder(
        future: _pullData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot == null) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            return new GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.775),
              itemBuilder: (BuildContext context, int ind) {
                return new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleItem(
                                snapshot.data[ind].id,
                                snapshot.data[ind].name,
                                snapshot.data[ind].type,
                                snapshot.data[ind].price,
                                snapshot.data[ind].color,
                                snapshot.data[ind].size,
                                snapshot.data[ind].mark,
                                snapshot.data[ind].company,
                                snapshot.data[ind].date,
                                snapshot.data[ind].item_loc,
                                snapshot.data[ind].archive_loc,
                                snapshot.data[ind].stock,
                                widget.type,
                                widget.title)));
                  },
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            'http://testfoxx.ga/img/${snapshot.data[ind].id}.png',
                            //height: 240,
                            width: MediaQuery.of(context).size.width),
                        Text(
                          snapshot.data[ind].name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Үнэ: ${snapshot.data[ind].price}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        Text(
                          "Тоо ширхэг: ${snapshot.data[ind].stock}",
                        )
                      ],
                    ),
                  )),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: widget.type == '1'
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddItem(widget.title, widget.cat, widget.subcat)));
              },
            )
          : null,
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<Item> ListExample;
  final String title, type;
  Search(this.ListExample, this.title, this.type);

  List<Item> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Item> suggestionList = [];
    ListExample.where((element) => element.name.contains(query));
    query.isEmpty
        ? suggestionList = ListExample
        : suggestionList.addAll(ListExample.where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase())));

    return suggestionList.length != 0
        ? ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, ind) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleItem(
                                suggestionList[ind].id,
                                suggestionList[ind].name,
                                suggestionList[ind].type,
                                suggestionList[ind].price,
                                suggestionList[ind].color,
                                suggestionList[ind].size,
                                suggestionList[ind].mark,
                                suggestionList[ind].company,
                                suggestionList[ind].date,
                                suggestionList[ind].item_loc,
                                suggestionList[ind].archive_loc,
                                suggestionList[ind].stock,
                                type,
                                title)));
                  },
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            'http://testfoxx.ga/img/${suggestionList[ind].id}.png',
                            height: 240,
                            width: MediaQuery.of(context).size.width),
                        Text(
                          suggestionList[ind].name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Үнэ: ${suggestionList[ind].price}",
                        ),
                        Text(
                          "Тоо ширхэг: ${suggestionList[ind].stock}",
                        )
                      ],
                    ),
                  )));
            },
          )
        : Center(
            child: Text(
              "Хайлт илэрцгүй.",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
  }
}
