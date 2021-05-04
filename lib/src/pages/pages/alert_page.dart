import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Page"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Show Alert"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () => _showAlert(context),
          shape: StadiumBorder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text("Title"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Contenido"), FlutterLogo(size: 100.0)],
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              FlatButton(onPressed: () {}, child: Text("Ok"))
            ],
          );
        });
  }
}
