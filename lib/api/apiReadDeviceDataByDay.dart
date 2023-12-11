import 'dart:convert';
import 'package:dio/dio.dart';

import '../main.dart';
class ReadDeviceDataByDay{
  final String? error;
  final Map<String, dynamic> dataDevice;

  ReadDeviceDataByDay(this.error, this.dataDevice);


}

Future<ReadDeviceDataByDay> apiReadDeviceDataByDay(String year, String month, String day) async{
  final dio = Dio();
  try{
    Response response = await dio.post(
      "${hostName}/api/DataAPI/ReadDeviceDataByDay",
      options: Options(
        headers: {
          "Content-type": "text/plain",
        },
      ),
      data:jsonEncode({
          "year" : year,
          "month" : month,
          "day": day
      })
    );
    // print(response.toString() + "\n ${response.statusCode}");
    Map<String, dynamic> userMap = jsonDecode(response.toString());
    print("MapDay: $userMap");
    return ReadDeviceDataByDay('',userMap);
  }catch(e){
    String error = e.toString();
    return ReadDeviceDataByDay(error,{});
  }
}