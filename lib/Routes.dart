//import 'package:/pages/login/forgot.page.dart';
//import 'package:/pages/login/login.page.dart';
//import 'package:/pages/login/newuser.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/sign_in_page.dart';
import 'package:flutter_app/pages/upload.dart';
import 'package:flutter_app/pages/cars.dart';
class Routes {
  Map routes(BuildContext context) {
    var route = {
//      '/video': (context) => new ViewVideo(),
      '/cars': (context) => new Cars(),
      '/signin': (context) => new SignInPage(),
    };

    return route;
  }
}
