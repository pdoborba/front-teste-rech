import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_rech/views/addproduct.dart';
import 'package:teste_rech/views/detailpage.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  var url = Uri.parse("http://192.168.0.127:8686/users");
  late List data;

  get key => null;
  get title => null;

  Future<List> getData() async {
    final response = await http.get(url);
    return json.decode(response.body);
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataProduct(key: key, title: title)),
    );

    if (result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews Products"),
        automaticallyImplyLeading: false,
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(
            color: Colors.black12,
            child: Icon(Icons.add),
            onPressed: () => _navigateAndDisplaySelection(context),
          ),
        ],
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var itemList = new ItemList(
                  List: snapshot.data, list: [],
                );
          return snapshot.hasData
              ? itemList
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  // ignore: non_constant_identifier_names
  ItemList({required this.list, List? List});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: new GestureDetector(
                onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )),
                ),
                child: Container(
                  //color: Colors.black,
                  height: 100.3,
                  child: new Card(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // add this
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  list[i]['name'].toString(),
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  list[i]['price'].toString(),
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black87),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
