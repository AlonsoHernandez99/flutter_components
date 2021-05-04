import 'package:flutter/material.dart';
import 'package:flutter_componenst/src/pages/providers/menu_provider.dart';
import 'package:flutter_componenst/src/utils/icon_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Components')),
      body: _list(),
    );
  }

  Widget _list() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _createListItem(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _createListItem(List<dynamic> data, BuildContext context) {
    final List<Widget> opt = [];

    data.forEach((element) {
      final widgetTmp = ListTile(
        title: Text(element["text"]),
        leading: getIcon(element["icon"]),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.cyanAccent,
        ),
        onTap: () {
          // final route = MaterialPageRoute(builder: (context) => AlertPage());
          // Navigator.push(context, route);
          Navigator.pushNamed(context, element["route"]);
        },
      );
      opt..add(widgetTmp)..add(Divider());
    });
    return opt;
  }
}
