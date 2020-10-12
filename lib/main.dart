import 'package:flutter/material.dart';
import 'package:flutter_app/Routes.dart';
import 'package:flutter_app/bloc/cars_bloc.dart';
import 'package:flutter_app/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/cars_repository.dart';
import 'package:firebase_core/firebase_core.dart';

main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Routes route = new Routes();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarsBloc(CarsRepo()),
      child: MaterialApp(
          // Start the app with the "/" named route. In this case, the app starts
          // on the FirstScreen widget.
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: route.routes(context),
          home:  FutureBuilder(
            // Initialize FlutterFire
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                print("here ${snapshot.error}");
                return Container();
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return HomePage();
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return CircularProgressIndicator();
            },
          )),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: Text("Home")),
        body: Text("asdf"));
  }
}

