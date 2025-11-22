import 'package:lab9/services/networking.dart';
import '/services/location.dart';

const apiKey = 'c4c4f8b6d7c91b8734c09dcb39aed4da'; 
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String inputCity) async {
    // Thay đổi: param 'q' giữ nguyên, đổi 'key' thành 'appid', thêm 'units=metric'
    NetworkHelper networkHelper = NetworkHelper(
        url: '$openWeatherURL?q=$inputCity&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    print('1. Bắt đầu lấy vị trí...'); // In ra console
    Location location = Location();
    
    await location.getCurrentLocation(); 
    print('2. Đã có vị trí: ${location.latitude}, ${location.longitude}'); // Nếu không thấy dòng này => Lỗi do GPS máy ảo

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    print('3. Bắt đầu gọi API Weather...');
    var weatherData = await networkHelper.getData();
    print('4. Đã lấy được dữ liệu Weather'); // Nếu thấy dòng này mà vẫn quay => Lỗi ở updateUI
    
    return weatherData;
  }
  // Cập nhật logic ID theo chuẩn OpenWeatherMap
  // Tham khảo: https://openweathermap.org/weather-conditions
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩'; // Thunderstorm
    } else if (condition < 400) {
      return '🌧'; // Drizzle
    } else if (condition < 600) {
      return '☔️'; // Rain
    } else if (condition < 700) {
      return '☃️'; // Snow
    } else if (condition < 800) {
      return '🌫'; // Atmosphere (Fog, Mist)
    } else if (condition == 800) {
      return '☀️'; // Clear
    } else if (condition <= 804) {
      return '☁️'; // Clouds
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}