import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [_carType1(), SizedBox(height: 10), _carType2()],
      ),
    );
  }

  Widget _carType1() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          ListTile(
            title: Text("Card Title..."),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries"),
            leading: Icon(
              Icons.photo_album,
              color: Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(onPressed: () {}, child: Text("Cancel")),
              FlatButton(onPressed: () {}, child: Text("Ok")),
            ],
          )
        ],
      ),
    );
  }

  Widget _carType2() {
    final card = Container(
      child: Column(
        children: [
          FadeInImage(
              fit: BoxFit.cover,
              height: 150,
              fadeInDuration: Duration(milliseconds: 200),
              placeholder: AssetImage("assets/jar-loading.gif"),
              image: NetworkImage(
                  "https://wallpaperaccess.com/full/1769725.jpg")),
          Container(padding: EdgeInsets.all(10), child: Text("Test"))
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 10.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}
