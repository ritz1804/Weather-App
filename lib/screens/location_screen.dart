import 'package:flutter/material.dart';
import 'package:climate_app/utilities/constants.dart';
import 'package:climate_app/services/weather.dart';
import 'city_screen.dart';
import 'package:climate_app/utilities/date_time.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  // int temperature;
  // String weatherIcon;
  // String cityName;
  // String weatherMessage;

  //new
  int temperature;
  String cityName;
  IconData weatherIcon;
  String weatherMessage;
  double windSpeed;
  int humidity;
  int rain;
  String image;
  int wind;
  String img;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        //weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();
      //print(temperature);
      cityName = weatherData['name'];
      //print(cityName);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(condition);
      //print(condition);
      windSpeed = weatherData['wind']['speed'].toDouble();
      wind = windSpeed.toInt();
      //print(windSpeed);
      humidity = weatherData['main']['humidity'];
      //print(humidity);
      rain = weatherData['clouds']['all'];
      //print(rain);

      if (condition < 300) {
        img = 'thunderstorm';
      } else if (condition < 400) {
        img = 'drizzle';
      } else if (condition < 600) {
        img = 'rain';
      } else if (condition < 700) {
        img = 'snow';
      } else if (condition < 800) {
        img = 'atmosphere';
      } else if (condition == 800) {
        img = 'sunny';
      } else {
        img = 'cloudy';
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$img.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  //color: Colors.black,
                  child: Row(
                    children: [
                      FlatButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CityScreen();
                          }));
                          //print(typedName);
                          if(typedName != null){
                            var weatherData = await weather.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.search,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 168,
                      ),
                      FlatButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$cityName',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Poppins'
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            date(),
                            style: TextStyle(
                                fontFamily: 'Poppins'
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 1,
                            width: 16,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            time(),
                            style: TextStyle(
                                fontFamily: 'Poppins'
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  //color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        '$temperature°',
                        style: TextStyle(
                            fontSize: 130,
                            fontFamily: 'Poppins'
                        ),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Icon(
                              weatherIcon
                          ),
                          SizedBox(width: 20.0,),
                          Text(
                            '$weatherMessage',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Poppins'
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  //color: Colors.red,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: SizedBox(
                  height: 0.5,
                  child: Container(
                    color: Colors.white70,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Wind',
                                        style: TextStyle(
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      Text(
                                        '$wind',
                                        style: TextStyle(
                                            fontSize: 30
                                        ),
                                      ),
                                      Text(
                                        'km/h',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                  //color: Colors.red,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Humidity',
                                        style: TextStyle(
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      Text(
                                        '$humidity',
                                        style: TextStyle(
                                            fontSize: 30
                                        ),
                                      ),
                                      Text(
                                        '%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                  //color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Rain',
                                        style: TextStyle(
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      Text(
                                        '$rain',
                                        style: TextStyle(
                                            fontSize: 30
                                        ),
                                      ),
                                      Text(
                                        '%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                  //color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                  //color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}