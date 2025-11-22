import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      // Kiểm tra quyền trước
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return; // Không có quyền thì dừng
        }
      }

      // Lấy vị trí với độ chính xác thấp để nhanh hơn trên máy ảo
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, 
        timeLimit: const Duration(seconds: 10) // Đợi tối đa 10s
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
      // Nếu lỗi, gán tọa độ mặc định (Hà Nội) để app không bị crash
      latitude = 21.0285;
      longitude = 105.8542; 
    }
  }
}