import 'package:flutter/material.dart';
import 'package:meteo_app/services/weather.dart';
import 'package:meteo_app/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var forecastData = await WeatherModel().getFiveDayForecast();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
          locationWeather: weatherData, locationForecast: forecastData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/01d.png',
              width: 280.0,
              height: 280.0,
            ),
          ],
        ),
      ),
    );
  }
}
