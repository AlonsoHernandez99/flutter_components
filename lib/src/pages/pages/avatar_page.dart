import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/styles/1200/public/media/image/2016/11/stan-lee.jpg?itok=rj-BqyOg"),
              radius: 25.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              child: Text("SL"),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage(
              "https://www.geekmi.news/__export/1605198940916/sites/debate/img/2020/11/12/stan_leex_su_legado_a_dos_axos_de_su_muerte.jpg_242310155.jpg"),
          placeholder: AssetImage("assets/jar-loading.gif"),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
