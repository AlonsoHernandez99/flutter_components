import 'dart:async';

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<int> _data = [];
  int _lastItem = 0;
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addImages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Builder"),
      ),
      body: Stack(
        children: [
          _createList(),
          _createLoading(),
        ],
      ),
    );
  }

  Widget _createList() {
    return RefreshIndicator(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          final image = _data[index];

          return FadeInImage(
            image: NetworkImage("https://picsum.photos/500/300?random=$image"),
            placeholder: AssetImage("assets/jar-loading.gif"),
          );
        },
      ),
      onRefresh: _getPageOne,
    );
  }

  Future<Null> _getPageOne() async {
    final duration = new Duration(seconds: 2);

    new Timer(duration, () {
      _data.clear();
      _lastItem++;
      _addImages();
    });

    return Future.delayed(duration);
  }

  void _addImages() {
    setState(() {
      for (var i = 1; i <= 10; i++) {
        _lastItem++;
        _data.add(_lastItem);
      }
    });
  }

  Future<Null> _fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);
    new Timer(duration, _httpResponse);
  }

  void _httpResponse() {
    _isLoading = false;
    _scrollController.animateTo(_scrollController.position.pixels + 200,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 300));
    _addImages();
  }

  Widget _createLoading() {
    return _isLoading
        ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
                SizedBox(
                  height: 15.0,
                )
              ])
        : Container();
  }
}
