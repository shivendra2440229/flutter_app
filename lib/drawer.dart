import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Center(
                      child: Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 100,
                  )),
                  Center(child:Text("Car Bazaar",style: TextStyle(fontSize: 20,color: Colors.white,fontStyle: FontStyle.italic),))
                ]),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                )),
            onTap: () {
              Navigator.pushNamed(context, '/signin');
            },
          ),
          ListTile(
            title: Center(
                child: Text(
              'Explore Cars',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
            )),
            onTap: () {
              Navigator.pushNamed(context, '/cars');
            },
          ),
//          ListTile(
//            title: Text('Videos'),
//            onTap: () {Navigator.pushNamed(context, '/video');},
//          ),
        ],
      ),
    );
  }
}
