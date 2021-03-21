abstract class Validator {}

class DoubleValidator extends Validator {
  static String? valid(
    double? value, {
    String? errorText,
    double? min,
    double? max,
  }) {
    try {
      if (value != null &&
          value >= (min ?? value - 1.0) &&
          value <= (max ?? value + 1.0)) {
        return null;
      }
      return errorText ?? "Error";
    } catch (e) {
      print(e);
    }
  }
}

class IntValidator extends Validator {
  static String? valid(
    int? value, {
    String? errorText,
    int? min,
    int? max,
  }) {
    try {
      if (value != null &&
          value >= (min ?? value - 1) &&
          value <= (max ?? value + 1)) {
        return null;
      }
      return errorText ?? "Error";
    } catch (e) {
      print(e);
    }
  }
}
