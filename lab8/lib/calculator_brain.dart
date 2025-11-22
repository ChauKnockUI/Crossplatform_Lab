import 'dart:math';

class CalculatorBrain {
  // Constructor với required tham số
  CalculatorBrain({required this.height, required this.weight});

  final int height;
  final int weight;

  double? _bmi;

  // Phương thức tính BMI
  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi!.toStringAsFixed(1);
  }

  // Phương thức trả kết quả BMI
  String getResult() {
    if (_bmi == null) {
      return 'BMI chưa được tính toán'; // Trả về khi BMI chưa tính
    }
    if (_bmi! >= 25) {
      return 'Overweight';
    } else if (_bmi! > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  // Phương thức trả lời giải thích về BMI
  String getInterpretation() {
    if (_bmi == null) {
      return 'BMI chưa được tính toán'; // Trả về khi BMI chưa tính
    }
    if (_bmi! >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (_bmi! >= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
