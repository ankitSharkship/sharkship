class Validators {
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter valid 10 digit number";
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    if (value.length < 2) {
      return "Too short";
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return "Invalid characters";
    }

    return null;
  }
}
