import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new NewsPageList();
  }
}

class NewsPageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _NewsPageListState();
  }
}

class _NewsPageListState extends State<NewsPageList> {
  List<dynamic> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPageData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: _getListChildren(),
    );
  }

  List<Widget> _getListChildren() {
    List<Widget> widgets = new List();
    if (data != null) {
      for (var i = 0; i < data.length; i++) {
        bool isLast = false;
        if (i == data.length - 1) {
          isLast = true;
        } else {
          isLast = false;
        }
        Map<String, dynamic> map = data[i];
        widgets.add(new _News1ItemView(map, isLast));
      }
    } else {
      widgets.add(new Container());
    }
    return widgets;
  }

  void loadPageData() {
    var url =
        "https://m.mydrivers.com/app/newslist.aspx?tid=%d&minId=0&maxId=0&ver=2.2&temp=1464423764091";
    var client = new http.Client();
    client.get(url).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List<dynamic> dataJS = json.decode(response.body);
      //dynamic 类似于JSONArray类型
      //也可以理解为map类型
//      for (var e in data) {
//        for (var entry in e.entries) {
//          print("key:" + entry.key + "\t" + "value:" + entry.value.toString());
//        }
//      }
      if (response.statusCode == 200) {
        data = dataJS;
        //更新界面
        setState(() {});
      }
    }).whenComplete(client.close);
  }
}

class _News1ItemView extends StatelessWidget {
  Map<String, dynamic> itemData;
  bool isLast;

  _News1ItemView(this.itemData, this.isLast);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (itemData == null) {
      return new Container();
    }

    return new Container(
      margin:
          EdgeInsets.only(top: 5, left: 20, right: 20, bottom: isLast ? 5 : 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            color: Colors.amber,
            margin: EdgeInsets.only(right: 10,top: 5),
            child: new Image.network(itemData["icon"].toString(),
                width: 30, height: 30),
            width: 40,
            height: 40,
          ),
          new Expanded(
              child: new Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Text(
                    itemData["title"].toString(),
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    maxLines: 1,
                  ),
                ),
                new Container(
                  child: new Text(
                    itemData["desc"].toString(),
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
