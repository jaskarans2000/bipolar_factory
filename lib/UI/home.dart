import 'package:flutter/material.dart';

import 'ImageGrid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);

    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top:30.0),
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      indicatorColor: Colors.white,
                      controller: _tabController,
                      labelPadding: const EdgeInsets.all(0.0),
                      tabs: [
                        _getTab(0, Center(child: Text("Nature"))),
                        _getTab(1, Center(child: Text("Pets"))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      ImageGrid(index: 0),
                      ImageGrid(index: 1),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
              (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index),
          border:Border.all(color: Colors.grey.shade300,style: BorderStyle.solid,width: 2.0)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0),topLeft: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0),topRight: Radius.circular(10.0));
    else
      return BorderRadius.circular(8.0);
  }
}

