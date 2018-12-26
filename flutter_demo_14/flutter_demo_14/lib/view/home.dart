import 'package:flutter/material.dart';
import 'package:flutter_demo_14/view/news1.dart';
import 'package:flutter_demo_14/view/news2.dart';

class HomePage extends StatelessWidget {
  String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new HomePageLayout(title);
  }
}

class HomePageLayout extends StatefulWidget {
  String title;

  HomePageLayout(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageLayoutState(title);
  }
}

class _HomePageLayoutState extends State<HomePageLayout> with SingleTickerProviderStateMixin{
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  String title;

  _HomePageLayoutState(this.title);

  final List<Tab> myTabs = <Tab>[
    new Tab(text: '页面1'),
    new Tab(text: '页面2'),
  ];

  TabController control;

  TabBar tabBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    control = new TabController(length: 2, vsync: this)..addListener(() {
      _pageController.animateToPage(control.index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
    //类似于Android中的tablayout
    tabBar = new TabBar(
      controller: control,
      tabs: myTabs,
      isScrollable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text(title),
        bottom: tabBar,
      ),
      body: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return index == 1 ? new News2Page() : new News1Page();
        },
        itemCount: 2,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.category), title: new Text("首页")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.message), title: new Text("我的")),
        ],
        currentIndex: _currentPageIndex,
        onTap: onTap,
      ),
    );
  }

  // bottomnaviagtionbar 和 pageview 的联动
  void onTap(int index) {
    // 过pageview的pagecontroller的animateToPage方法可以跳转
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
      control.index = _currentPageIndex; //相当于直接调用了setIndex方法
//      control.animateTo(_currentPageIndex);  //和上面的意思是一样的
    });
  }
}

//      body: new Center(
//        child: new RaisedButton(
//          onPressed: () {
//            //给前一个页面传递数据的
//            Navigator.pop(context,new DateTime.now().toString());
//          },
//          child: new Text('返回'),
//        ),
//      ),
