import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/apiReadDeviceDataByDay.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  Map<String, dynamic> dataDevice = {};
  List<String> keysList = [];

  Future<void> getDataDevice(String year, String month, String day) async{
    ReadDeviceDataByDay data = await apiReadDeviceDataByDay(year,month,day);
    dataDevice = data.dataDevice["Acetone"];
  }
  @override
  initState() {
    getDataDevice('2023','7','12');
    print("initState Called");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          TextButton(
              onPressed: (){
                setState(() {
                  getDataDevice('2023','7','12');
                });
              },
              child: Text(
                "Acetone"
              )
          ),
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            height: 400,
            width: 400,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: getDataSpots(),
                    isCurved: true,
                    color: Colors.blue,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles:SideTitles(showTitles: true,reservedSize: 35),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)
                  ),
                  bottomTitles: AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                  interval: 100,
                  getTitlesWidget: (value,meta){
                    return SideTitleWidget(axisSide: meta.axisSide, child: Text("${keysList[value.toInt()]}"));
                  }),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                gridData: FlGridData(show: true),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<FlSpot> getDataSpots() {
    List<FlSpot> spots = [];
    int index = 0;
    dataDevice.forEach((key, value) {
      spots.add(FlSpot( index.toDouble(), double.parse(value)));
      index++;
    });
    keysList = dataDevice.keys.toList();
    print("List: $spots");
    return spots;
  }
  // List<FlSpot> getDataPoints() {
  //   List<MapEntry<String, dynamic>> entries = dataDevice!.entries.toList();
  //   return entries
  //       .map((entry) => FlSpot(
  //     entries.indexOf(entry).toDouble(),
  //     entry.value is num ? entry.value.toDouble() : 0.0,
  //   ))
  //       .toList();
  // }


}
