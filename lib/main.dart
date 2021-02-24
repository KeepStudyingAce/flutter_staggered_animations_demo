import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<String> data = ["ListView", "List Sync", "Grid", "Column"];
  int currentIndex = 0;
  TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TabBar(
              controller: _tabController,
              onTap: (int indes) {
                setState(() {
                  currentIndex = indes;
                });
              },
              tabs: List.generate(data.length, (index) {
                bool isSel = index == currentIndex;
                return Text(
                  data[index],
                  style: TextStyle(
                      fontSize: isSel ? 13 : 11,
                      color: isSel ? Colors.black : Colors.black45),
                );
              }).toList()),
        ),
        body: currentIndex == 0
            ? _renderStaggeredList()
            : currentIndex == 1
                ? _renderSynchronized()
                : currentIndex == 2
                    ? _renderStaggeredGrid()
                    : _renderStagererColumn());
  }

  Widget _renderStaggeredList() {
    print("_renderStaggeredList");
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  //滑动效果
                  verticalOffset: 50.0,
                  child:
                      //   FadeInAnimation( //淡入效果
                      // child:
                      ScaleAnimation(
                          //缩放效果
                          child:
                              // FlipAnimation(
                              //     //翻页效果
                              //     child:
                              _renderCell()),
                  //   ),
                  // ),
                ),
              );
            }));
  }

  Widget _renderSynchronized() {
    print("_renderSynchronized");
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.synchronized(
                // position: index,
                duration: const Duration(milliseconds: 375),
                child:
                    // SlideAnimation( //滑动效果
                    //   verticalOffset: 50.0,
                    //   child:
                    FadeInAnimation(
                  //淡入效果
                  child:
                      //   ScaleAnimation(
                      // //缩放效果
                      // child:
                      FlipAnimation(
                    //翻页效果
                    child: _renderCell(),
                  ),
                  //   ),
                  // ),
                ),
              );
            }));
  }

  Widget _renderStaggeredGrid() {
    print("_renderStaggeredGrid");
    return AnimationLimiter(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: SlideAnimation(
                  //滑动效果
                  verticalOffset: 50.0,
                  child:
                      //   FadeInAnimation( //淡入效果
                      // child:
                      ScaleAnimation(
                          //缩放效果
                          child:
                              //  FlipAnimation(
                              //     //翻页效果
                              //     child:
                              _renderCell()),
                  //   ),
                  // ),
                ),
              );
            }));
  }

  Widget _renderStagererColumn() {
    return SingleChildScrollView(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: List.generate(10, (index) {
              return _renderCell();
            }),
          ),
        ),
      ),
    );
  }

  Widget _renderCell() {
    return Container(
      margin: EdgeInsets.all(5),
      width: 200,
      height: 40,
      color: Colors.redAccent,
    );
  }
}
