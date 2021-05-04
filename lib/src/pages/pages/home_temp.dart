import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final options = ['One', 'Two', 'Three', 'Four', 'Five'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Components Temp')),
      body: ListView(children: _createShortList()),
    );
  }

  List<Widget> _createItems() {
    List<Widget> list = new List<Widget>();

    for (String opt in options) {
      list
        ..add(ListTile(
          title: Text(opt),
        ))
        ..add(Divider());
    }

    return list;
  }

  List<Widget> _createShortList() {
    return options.map((item) {
      return Column(
        children: [
          ListTile(
            title: Text(item),
            subtitle: Text('Lorem ipsum'),
            leading: Icon(Icons.access_alarm),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              
            },
          ),
          Divider()
        ],
      );
    }).toList();
  }
}
