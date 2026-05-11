class Validators {
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return "Phone number is required";
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value))
      return "Enter valid 10 digit number";
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return "This field is required";
    if (value.length < 2) return "Too short";
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) return "Invalid characters";
    return null;
  }

  // --- NEW: Email Validator ---
  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email is required";

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? emailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email or phone number is required";
    }

    final trimmed = value.trim();

    final isPhone = RegExp(r'^[0-9]{10}$').hasMatch(trimmed);

    final isEmail = RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(trimmed);

    if (!isPhone && !isEmail) {
      return "Enter a valid email or phone number";
    }

    return null;
  }

  // --- NEW: Password Validator ---
  static String? password(String? value) {
    if (value == null || value.isEmpty) return "Password is required";

    // 1. At least 8 characters
    if (value.length < 8) return "Password must be at least 8 characters";

    // 2. At least 1 uppercase letter
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value))
      return "Must contain at least 1 uppercase letter";

    // 3. At least 1 lowercase letter
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value))
      return "Must contain at least 1 lowercase letter";

    // 4. At least 1 number
    if (!RegExp(r'(?=.*[0-9])').hasMatch(value))
      return "Must contain at least 1 number";

    // 5. At least 1 special character
    if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value))
      return "Must contain at least 1 special character";

    return null;
  }

  static String? pincode(String? value) {
    if (value == null || value.isEmpty) return "Pincode is required";

    // Validates exactly 6 digits (standard Indian Pincode)
    if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
      return "Enter a valid 6-digit pincode";
    }
    return null;
  }

  static String? city(String? value) {
    if (value == null || value.isEmpty) return "City is required";
    if (value.length < 3) return "City name is too short";

    // Allows letters and spaces (e.g., "New Delhi")
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Invalid city name";
    }
    return null;
  }

  static String? state(String? value) {
    if (value == null || value.isEmpty) return "State is required";
    // Usually states are selected via Dropdown, but if it's text:
    if (value.length < 3) return "State name is too short";
    return null;
  }

  static String? address(String? value) {
    if (value == null || value.isEmpty) return "Address is required";
    if (value.length < 10) return "Please enter a more detailed address";
    return null;
  }
}
