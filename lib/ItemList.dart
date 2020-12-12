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
          i["made_date"]);

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
                  context: context, delegate: Search(items, widget.title));
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
                  crossAxisCount: 2, childAspectRatio: 0.79),
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
                        ),
                        Text(
                          "Төрөл: ${snapshot.data[ind].type}",
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
  final String title;
  Search(this.ListExample, this.title);

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

    return ListView.builder(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Үнэ: ${suggestionList[ind].price}",
                ),
                Text(
                  "Төрөл: ${suggestionList[ind].type}",
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
