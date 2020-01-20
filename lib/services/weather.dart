import 'package:meteo_app/services/location.dart';
import 'package:meteo_app/services/networking.dart';

const apiKey;
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapForecastURL =
    'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getFiveDayForecast() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapForecastURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityCurrentWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityForecast(String cityName) async {
    var url =
        '$openWeatherMapForecastURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}

String getWeatherImage(String icon) {
  if (icon == '01d') {
    return 'images/01d.png';
  } else if (icon == '01n') {
    return 'images/01n.png';
  } else if (icon == '02d') {
    return 'images/02d.png';
  } else if (icon == '02n') {
    return 'images/02n.png';
  } else if (icon == '03d') {
    return 'images/03d.png';
  } else if (icon == '03n') {
    return 'images/03n.png';
  } else if (icon == '04d') {
    return 'images/04d.png';
  } else if (icon == '04n') {
    return 'images/04n.png';
  } else if (icon == '09d') {
    return 'images/09n.png';
  } else if (icon == '09n') {
    return 'images/09n.png';
  } else if (icon == '10d') {
    return 'images/10d.png';
  } else if (icon == '10n') {
    return 'images/10n.png';
  } else if (icon == '11d') {
    return 'images/11d.png';
  } else if (icon == '11n') {
    return 'images/11n.png';
  } else if (icon == '13d') {
    return 'images/13d.png';
  } else if (icon == '13n') {
    return 'images/13n.png';
  } else {
    return 'images/50d.png';
  }
}

DateTime convertEpochToDate(int epochDay) {
  epochDay = epochDay * 1000;
  var d = new DateTime.fromMillisecondsSinceEpoch(epochDay, isUtc: true);
  return d;
}

int giveYear(DateTime date) {
  var year = date.year;
  return year;
}

String giveMonth(DateTime date) {
  var month = date.month;
  if (month == 1) {
    return 'January';
  } else if (month == 2) {
    return 'February';
  } else if (month == 3) {
    return 'March';
  } else if (month == 4) {
    return 'April';
  } else if (month == 5) {
    return 'May';
  } else if (month == 6) {
    return 'June';
  } else if (month == 7) {
    return 'July';
  } else if (month == 8) {
    return 'August';
  } else if (month == 9) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'December';
  }
}

int giveDay(DateTime date) {
  var day = date.day;
  return day;
}

String giveWeekday(DateTime date) {
  var weekday = date.weekday;
  if (weekday == 1) {
    return 'Monday';
  } else if (weekday == 2) {
    return 'Tuesday';
  } else if (weekday == 3) {
    return 'Wednesday';
  } else if (weekday == 4) {
    return 'Thursday';
  } else if (weekday == 5) {
    return 'Friday';
  } else if (weekday == 6) {
    return 'Saturday';
  } else {
    return 'Sunday';
  }
}
