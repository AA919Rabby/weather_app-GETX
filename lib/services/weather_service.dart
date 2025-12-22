import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService{
  String apiKey='37e8469ff832df6ae2a40d517997c955';
  Future<Map<String,dynamic>> getWeather(String city)async{
    final url=Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'
    );
    final response=await http.get(url);
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to load weather');
    }
  }
}