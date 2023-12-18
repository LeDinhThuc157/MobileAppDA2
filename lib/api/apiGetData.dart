import 'dart:convert';
import 'package:dio/dio.dart';

import '../main.dart';
class GetDataDevice{
   String error;
   Map<String, dynamic> dataDevice;

  GetDataDevice({required this.error, required this.dataDevice});


}

Future<GetDataDevice> apiGetData() async{
  final dio = Dio();
  try{
    Response response = await dio.post(
      "${hostName}/api/DataAPI/GetDevice",
      options: Options(
        headers: {
          "Content-type": "text/plain",
        },
      ),
    );
    // print(response.toString() + "\n ${response.statusCode}");
    Map<String, dynamic> userMap = jsonDecode(response.toString());
    // print("Map: $userMap");
    return GetDataDevice( error: '', dataDevice: userMap);
  }catch(e){
      String error = e.toString();
      if(error == "FormatException: Unexpected character (at character 1)\nThiết bị đã tồn tại\n^\n"){
        error = "Thiết bị đã tồn tại";
      }else{
        error = "Không có kết nỗi!";
      }
      return GetDataDevice(error: error,dataDevice: {});
  }
}