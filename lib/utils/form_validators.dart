class FormValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email address.';
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty || password.length < 6) {
      return 'Password must be at least 8 characters long.';
    }

    // bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    // bool hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // if (!hasUppercase || !hasSymbol) {
    //   return 'Password must include at least one uppercase\nletter and one symbol.';
    // }

    return null; // Valid password
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password.';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    } else if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password.';
    } else if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    // You can add more password validation logic here if needed
    return null; // Return null if validation succeeds
  }
}
