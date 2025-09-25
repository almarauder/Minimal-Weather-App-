import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('571c3aea44b5f11e07815e747d2775c2') ; 
  Weather? _weather ; 

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity() ; 

    try {
      final weather = await _weatherService.getWeather(cityName) ; 
      setState(() {
        _weather = weather ; 
      }) ; 
    }

    catch (e) {
      print(e) ; 
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json' ; 

    switch (mainCondition.toLowerCase()) {
      case 'clouds' : 
        return 'assets/cloudy.json' ; 
      case 'fog' : 
      case 'thunderstorm' : 
        return 'assets/storm.json' ; 
      case 'clear' : 
        return 'assets/sunny.json' ; 
      default : 
        return 'assets/sunny.json' ; 
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather() ;  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading...") , 

            // animation 
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)) , 

            Text('${_weather?.temperature.round()} Celcius') , 

            Text(_weather?.mainCondition ?? "") 
          ],
        ),
      )
    );
  }
}