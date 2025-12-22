import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/weather_controller.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
 final WeatherController controller=Get.put(WeatherController());
 final TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text ('Weather app'),
      actions: [
        IconButton(
            onPressed:() {
              Get.defaultDialog(
                title: 'Search a city',
                content: TextField (
                  controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter a city',
                    ),
                ),
                confirm: ElevatedButton(
                    onPressed: (){
                      controller.fetchWeather(searchController.text);
                      searchController.clear();
                      Get.back();
                    },
                    child: Text('Search')),
              );
            },
            icon:Icon(Icons.search)),
        IconButton(
            onPressed: () => Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            ),
            icon: Icon (Get.isDarkMode ? Icons.light_mode : Icons.dark_mode)),
      ],
    ),
      body: GetBuilder<WeatherController>(
          builder: (_){
            if(controller.isLoading){
              return Center(
                child: SizedBox(
                 height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: Colors.blueGrey,
                  ),
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.city,
                    style: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    controller.dateTimeString,
                    style: TextStyle(
                      fontSize: 16,color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    controller.temperature,
                    style: TextStyle(
                      fontSize: 60,fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    controller.description,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    controller.earthquakeInfo,
                    style: TextStyle(
                      fontSize: 16,color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
