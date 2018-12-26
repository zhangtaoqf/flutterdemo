import 'package:flutter/material.dart';
import 'view/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_demo_14/view/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    var url =
        "https://m.mydrivers.com/app/newslist.aspx?tid=%d&minId=0&maxId=0&ver=2.2&temp=1464423764091";
    var client = new http.Client();
    client.get(url).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      List<dynamic> data = json.decode(response.body);
      //dynamic 类似于JSONArray类型
      //也可以理解为map类型
      for (var e in data) {
        for (var entry in e.entries) {
          print("key:" + entry.key + "\t" + "value:" + entry.value.toString());
        }
      }
    }).whenComplete(client.close);

//    http.read("http://example.com/foobar.txt").then(print);

    setState(() {
      _counter++;
    });
    //页面跳转带结果的
    Navigator.push<String>(
      context,
      new MaterialPageRoute(
          builder: (context) => new HomePage(DateTime.now().toIso8601String())),
    ).then((String result) {
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: new LoginButton(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
