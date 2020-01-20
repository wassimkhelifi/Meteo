import 'package:flutter/material.dart';
import 'package:meteo_app/services/weather.dart';
import 'package:meteo_app/screens/city_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:meteo_app/utilities/size_config.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.locationForecast});

  final locationWeather;
  final locationForecast;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String cityName;
  int currentWeatherDay;
  String currentWeatherIcon;
  int currentWeatherTemperature;
  String currentWeatherDescription;
  double currentWeatherWindSpeed;
  int currentWeatherHumidity;
  int currentWeatherMaxTemp;
  List<int> forecastDay = [];
  List<int> forecastTemperature = [];
  List<String> forecastImage = [];

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather, widget.locationForecast);
  }

  Widget buildImage(String weatherPicture) {
    if (weatherPicture == 'images/01n.png' ||
        weatherPicture == 'images/13d.png' ||
        weatherPicture == 'images/13n.png') {
      return Container(
        child: Image.asset(
          weatherPicture,
          width: 150.0,
          height: 150.0,
        ),
      );
    } else if (weatherPicture == 'images/01d.png') {
      return Container(
        child: Image.asset(
          weatherPicture,
          width: 240.0,
          height: 240.0,
        ),
      );
    } else if (weatherPicture == 'images/02d.png' ||
        weatherPicture == 'images/02n.png') {
      return Container(
        child: Image.asset(
          weatherPicture,
          width: 300.0,
          height: 300.0,
        ),
      );
    } else {
      return Container(
        child: Image.asset(
          weatherPicture,
          width: 300.0,
          height: 300.0,
        ),
      );
    }
  }

  Widget adjustImage(String weatherPicture, int day) {
    if (weatherPicture == 'images/01n.png' ||
        weatherPicture == 'images/13d.png' ||
        weatherPicture == 'images/13n.png') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${giveWeekday(convertEpochToDate(forecastDay[day]))}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Image.asset(
              weatherPicture,
              width: 20.0,
              height: 20.0,
            ),
          ),
          Text(
            '${forecastTemperature[day]}°',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
            ),
          ),
        ],
      );
    } else if (weatherPicture == 'images/01d.png') {
      //sun
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${giveWeekday(convertEpochToDate(forecastDay[day]))}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          Image.asset(
            weatherPicture,
            width: 30.0,
            height: 30.0,
          ),
          Text(
            '${forecastTemperature[day]}°',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
            ),
          ),
        ],
      );
    } else if (weatherPicture == 'images/02d.png' ||
        weatherPicture == 'images/02n.png') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${giveWeekday(convertEpochToDate(forecastDay[day]))}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          Container(
            child: Image.asset(
              weatherPicture,
              width: 32.0,
              height: 32.0,
            ),
          ),
          Text(
            '${forecastTemperature[day]}°',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${giveWeekday(convertEpochToDate(forecastDay[day]))}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          Image.asset(
            weatherPicture,
            width: 30.0,
            height: 30.0,
          ),
          Text(
            '${forecastTemperature[day]}°',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.0,
            ),
          ),
        ],
      );
    }
  }

  void updateUI(dynamic currentWeatherData, dynamic forecastWeatherData) {
    setState(() {
      if (currentWeatherData == null && forecastWeatherData == null) {
        if (Platform.isIOS) {
          CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
            title: Text('Error Finding City'),
            content: Text(
                'The city you typed could not be found. Please try again.'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  var typedName = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return CityScreen();
                  }));
                  if (typedName != null) {
                    var weatherData =
                        await weather.getCityCurrentWeather(typedName);
                    var forecastData = await weather.getCityForecast(typedName);
                    updateUI(weatherData, forecastData);
                  }
                },
              ),
            ],
          );
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return cupertinoAlert;
            },
          );
          return;
        } else {
          showAlertDialog(BuildContext context) {
            Widget okButton = FlatButton(
              child: Text("OK"),
              onPressed: () async {
                var typedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CityScreen();
                }));
                Navigator.pop(context);
                if (typedName != null) {
                  var weatherData =
                      await weather.getCityCurrentWeather(typedName);
                  var forecastData = await weather.getCityForecast(typedName);
                  updateUI(weatherData, forecastData);
                }
              },
            );
            AlertDialog alert = AlertDialog(
              title: Text("Error Finding City"),
              content: Text(
                  "The city you typed could not be found. Please try again."),
              actions: [
                okButton,
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }

          showAlertDialog(context);
          return;
        }
      } else {
        cityName = currentWeatherData['name'];
        currentWeatherDay = currentWeatherData['dt'] - 25200;
        currentWeatherIcon = currentWeatherData['weather'][0]['icon'];
        currentWeatherTemperature = currentWeatherData['main']['temp'].round();
        currentWeatherDescription =
            currentWeatherData['weather'][0]['description'];
        currentWeatherWindSpeed =
            currentWeatherData['wind']['speed'].toDouble();
        currentWeatherHumidity = currentWeatherData['main']['humidity'];
        currentWeatherMaxTemp = currentWeatherData['main']['temp_max'].round();
      }

      if (forecastDay.isNotEmpty) {
        forecastDay.clear();
      }

      if (forecastTemperature.isNotEmpty) {
        forecastTemperature.clear();
      }

      if (forecastImage.isNotEmpty) {
        forecastImage.clear();
      }

      for (int i = 0; i < 40; i++) {
        if (forecastWeatherData['list'][i]['dt_txt'].contains('12:00:00')) {
          forecastDay.add(forecastWeatherData['list'][i]['dt'] - 25200);
          forecastTemperature
              .add(forecastWeatherData['list'][i]['main']['temp'].round());
          forecastImage
              .add(forecastWeatherData['list'][i]['weather'][0]['icon']);
        }
      }

      for (int i = 0; i < 5; i++) {
        if (forecastImage[i] == '02n') {
          forecastImage[i] = '02d';
        }
        if (forecastImage[i] == '01n') {
          forecastImage[i] = '01d';
        }
        if (forecastImage[i] == '10n') {
          forecastImage[i] = '10d';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          height: SizeConfig.blockSizeVertical * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //container for top navigation bar
                height: SizeConfig.blockSizeVertical * 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        var weatherData =
                            await WeatherModel().getLocationWeather();
                        var forecastData =
                            await WeatherModel().getFiveDayForecast();
                        updateUI(weatherData, forecastData);
                      },
                      child: Icon(
                        Icons.home,
                        size: 40.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityCurrentWeather(typedName);
                          var forecastData =
                              await weather.getCityForecast(typedName);
                          updateUI(weatherData, forecastData);
                        }
                      },
                      child: Icon(
                        Icons.place,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //container for city name and date
                height: SizeConfig.blockSizeVertical * 20,
                padding: EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: AutoSizeText(
                        '$cityName',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 50.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${giveWeekday(convertEpochToDate(currentWeatherDay))} ${giveDay(convertEpochToDate(currentWeatherDay))} ${giveMonth(convertEpochToDate(currentWeatherDay))} ${giveYear(convertEpochToDate(currentWeatherDay))}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  //container for image
                  height: SizeConfig.blockSizeVertical * 30,
                  child: buildImage(getWeatherImage(currentWeatherIcon))),
              Container(
                //temp and desc
                height: SizeConfig.blockSizeVertical * 19,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        '$currentWeatherTemperature°',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 50.0,
                        ),
                      ),
                    ),
                    Center(
                      child: AutoSizeText(
                        '$currentWeatherDescription',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //windspeed etc.
                height: SizeConfig.blockSizeVertical * 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${currentWeatherWindSpeed}km/h',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Wind',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$currentWeatherHumidity%',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$currentWeatherMaxTemp°',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Maximum',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    adjustImage(getWeatherImage(forecastImage[0]), 0),
                    adjustImage(getWeatherImage(forecastImage[1]), 1),
                    adjustImage(getWeatherImage(forecastImage[2]), 2),
                    adjustImage(getWeatherImage(forecastImage[3]), 3),
                    adjustImage(getWeatherImage(forecastImage[4]), 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
