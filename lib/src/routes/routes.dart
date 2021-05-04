import 'package:flutter/material.dart';
import 'package:flutter_componenst/src/pages/pages/alert_page.dart';
import 'package:flutter_componenst/src/pages/pages/animeted_container.dart';
import 'package:flutter_componenst/src/pages/pages/avatar_page.dart';
import 'package:flutter_componenst/src/pages/pages/home_page.dart';
import 'package:flutter_componenst/src/pages/pages/input_page.dart';
import 'package:flutter_componenst/src/pages/pages/listview_page.dart';
import 'package:flutter_componenst/src/pages/pages/page_card.dart';
import 'package:flutter_componenst/src/pages/pages/slider_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    "/home": (BuildContext context) => HomePage(),
    "alert": (BuildContext context) => AlertPage(),
    "avatar": (BuildContext context) => AvatarPage(),
    "card": (BuildContext context) => CardPage(),
    "animatedContainer": (BuildContext context) => AnimatedContainerPage(),
    "input": (BuildContext context) => InputPage(),
    "slider": (BuildContext context) => SliderPage(),
    "list": (BuildContext context) => ListPage(),
  };
}
