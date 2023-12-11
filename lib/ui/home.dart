import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apiGetData.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

GetDataDevice getData = new GetDataDevice(error: '', dataDevice: {});
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 10)).asyncMap((event) => apiGetData()),
          builder: (context, snapshot) => Container(
            // color: Colors.cyanAccent,
            child: Column(
              children: [
                airQuality(),
                parameterAir()
              ],
            ),
          ),
        )
      ),
    );
  }
  Widget airQuality(){
    var tem = getData.dataDevice["dataDevice"];
    // String hum = getData.dataDevice["dataDevice"]["Hum"];
    print("Data: hum\n$tem");
    return Container(
      // color: Colors.cyanAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Tem: $tem°C"),
          Text("Hum: hum%"),
        ],
      ),
    );
  }
  Widget parameterAir(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Parameter Air"),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
