import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController{
  String city ='Dhaka';
  String temperature='';
  String description='';
  String earthquakeInfo='';
  bool isLoading=true;
  String dateTimeString='';
  int timezoneOffset=0;
  Timer? timer;
  final String apiKey='37e8469ff832df6ae2a40d517997c955';
  final String baseUrl='https://api.openweathermap.org/data/2.5/weather';
  @override
  void onInit(){
    super.onInit();
    fetchWeather(city);
  }
  fetchWeather(String cityName)async{
    isLoading=true;
    update();
    try{
      http.Response response=await http.get(
        Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        city=cityName;
        temperature='${data['main']['temp']}°C';
        description=data['weather'][0]['description'];
        earthquakeInfo='No recent earthquakes';
        timezoneOffset=data['timezone'] ?? 0;
        startDateTimeUpdater();
      }else{
        throw Exception('Failed to load weather');
      }
    }catch(e){
      print('Error:$e');
    }finally{
      isLoading=false;
      update();
    }
  }
  startDateTimeUpdater(){
    timer?.cancel();
    updateDateTime();
    timer=Timer.periodic(Duration(seconds: 1),(_){
      updateDateTime();
    });
  }

  updateDateTime() {
    final nowUtc = DateTime.now().toUtc();
    final cityTime = nowUtc.add(Duration(seconds: timezoneOffset));
    dateTimeString =
        DateFormat('EEE, dd MMM yyyy – hh:mm:ss a').format(cityTime);
    update();
  }
  @override
  onClose() {
    timer?.cancel();
    super.onClose();
  }

}
