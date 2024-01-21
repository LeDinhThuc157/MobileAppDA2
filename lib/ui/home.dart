import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apiGetData.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tem = 0;
  int hum = 0;
  int acetone = 0;
  int alcohol = 0;
  int co = 0;
  int co2 = 0;
  int ammoniac = 0;
  int toluene = 0;
  bool status = false;
  DateTime datetime = DateTime.now();

  Future<void> getDataDevice() async {
    GetDataDevice data = await apiGetData();
    final Map<String, dynamic>? userMap = data.dataDevice;

    dynamic getValueByKey(List<dynamic> data, String key) {
      var item = data.firstWhere((element) => element["key"] == key);
      return item["value"];
    }
    status = userMap?["status"];
    datetime = DateTime.parse(userMap?["lastTimeSystem"]);
    print(datetime);
    List<dynamic> listdata = userMap?["lastData"];
    tem = getValueByKey(listdata, "Tem");
    hum = getValueByKey(listdata, "Hum");
    acetone = getValueByKey(listdata, "Acetone");
    alcohol = getValueByKey(listdata, "Alcohol");
    co = getValueByKey(listdata, "CO");
    co2 = getValueByKey(listdata, "CO2");
    ammoniac = getValueByKey(listdata, "Ammoniac");
    toluene = getValueByKey(listdata, "Toluene");
    print("Tem:$tem");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      // ),
      body: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 10))
              .asyncMap((event) => getDataDevice()),
          builder: (context, snapshot) =>  Column(
            children: [
              SizedBox(height: 70,),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFC9D2C9),
                  border: Border.all(
                    color: Color(0xFF000000), // Màu sắc của khung viền
                    width: 2.0, // Độ dày của khung viền
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),),
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(right: 5,left: 5),
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Text("Device",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 24),)
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Status : ",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                          Center(
                            child: status ? Text("Online",style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),):
                            Text("Offline",style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Last Received : ",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                          Center(
                            child: Text("${datetime.day}/${datetime.month}/${datetime.year} ${datetime.hour}:${datetime.minute}:${datetime.second}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 220,
                width: double.infinity,
                margin: EdgeInsets.only(right: 5,left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFD6F5EC),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 40,),
                    CircleValue("Temperature(°C)", tem),
                    SizedBox(width: 40,),
                    CircleValue("Humidity(%)", hum),
                    SizedBox(width: 40,)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 330,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CardValue("Ammonia",ammoniac, 25,100),
                      SizedBox(
                        height: 10,
                      ),
                      CardValue("Carbon Dioxide",co2, 1000,2000),
                      SizedBox(
                        height: 10,
                      ),
                      CardValue("Toluene",toluene, 50,200),
                      SizedBox(
                        height: 10,
                      ),
                      CardValue("Carbon monoxide", co,100,400),
                      SizedBox(
                        height: 10,
                      ),
                      CardValue("Alcohol", alcohol,2,4),
                      SizedBox(
                        height: 10,
                      ),
                      CardValue("Acetone", acetone,300,500),
                    ],
                  ),
                ),
              )
            ],
          )
      ));
  }

  Widget CircleValue(String title, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFC1F6C1),
                    Color(0xFF00A8E8),
                    Color(0xFF0077CC),
                    Color(0xFF67EC58)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget CardValue(String title, int value, int min, int max){
    Color getValueColor() {
      if (value < min) {
        return Color(0xFF67EC58);  // Màu thứ nhất
      } else if (value >= min && value <= max) {
        return Color(0xFFF1DB58);  // Màu thứ hai
      } else {
        return Color(0xFFF64B42);  // Màu thứ ba
      }
    }
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 5,right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF8D8DB9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10,),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      getValueColor(),
                      getValueColor()
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.cyanAccent,
            height: 90,
            width: 290,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                SizedBox(),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Container(
                      height: 30,
                      width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF67EC58),
                        ),
                      child: Center(
                        child: Text("0 - $min",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                        ),
                      )
                    ),
                    SizedBox(),
                    Container(
                      height: 30,
                      width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF1DB58),
                        ),
                      child: Center(
                        child: Text("$min - $max",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                      )
                    ),
                    SizedBox(),
                    Container(
                      height: 30,
                      width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF64B42),
                        ),
                      child: Center(
                        child: Text(" > $max",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                          ),
                        ),
                      )
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
