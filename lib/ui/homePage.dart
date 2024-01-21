

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'graph.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int chooseIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBarPage(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar(){
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(20),
            gap: 20,
            onTabChange: (index){
              setState(() {
                chooseIndex = index;
              });
            },
            selectedIndex: chooseIndex,
            tabs: [
              GButton(
                icon: Icons.heat_pump,
                text: 'Device',
                textSize: 25,
              ),
              GButton(
                icon: Icons.location_on,
                text: 'Map',
                textSize: 25,
              ),
            ]
        ),
      ),
    );
  }
  Widget getBarPage(){
    return IndexedStack(
      index: chooseIndex,
      children: <Widget>[
        Home(),
        Graph(),
      ],
    );
  }
}
