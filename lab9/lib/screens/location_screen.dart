import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab9/screens/city_screen.dart';
import '/utilities/constants.dart';
import '/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherData});

  final dynamic weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
  WeatherModel weather = WeatherModel();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  // --- PHẦN QUAN TRỌNG NHẤT ĐÃ ĐƯỢC SỬA ---
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'ERROR';
        cityName = '';
        weatherMessage = 'Unable to get data';
        return;
      } else {
        // 1. Sửa cách lấy nhiệt độ (OpenWeatherMap để trong main -> temp)
        // Thêm .toDouble() để tránh lỗi nếu API trả về số nguyên (ví dụ: 30 thay vì 30.0)
        double temp = weatherData['main']['temp'].toDouble();
        temperature = temp.toInt();

        // 2. Sửa cách lấy icon (OpenWeatherMap để trong mảng weather -> id)
        var condition = weatherData['weather'][0]['id'];
        
        // 3. Sửa cách lấy tên thành phố (nằm ngay bên ngoài)
        cityName = weatherData['name'];

        // Các hàm logic này giữ nguyên vì bạn đã sửa bên weather.dart rồi
        weatherIcon = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(temperature!);
      }
    });
  }
  // -----------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: SpinKitChasingDots(
                color: Colors.white,
                size: 100.0,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/location_background.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              constraints: const BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            // Thêm loading khi bấm nút định vị lại
                            setState(() {
                              isLoading = true;
                            });
                            dynamic weatherData =
                                await weather.getLocationWeather();
                            setState(() {
                              isLoading = false;
                            });
                            updateUI(weatherData);
                          },
                          child: const Icon(
                            Icons.near_me,
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            var typedName = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CityScreen();
                            }));
                            if (typedName != null) {
                              setState(() {
                                isLoading = true;
                              });
                              var weatherData =
                                  await weather.getCityWeather(typedName);                           
                              setState(() {
                                isLoading = false;
                              });
                              if (weatherData != null) {
                                updateUI(weatherData);
                              }
                            }
                          },
                          child: const Icon(
                            Icons.location_city,
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$temperature°', // Thêm ký hiệu độ cho đẹp
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherIcon!,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        '$weatherMessage in $cityName',
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}