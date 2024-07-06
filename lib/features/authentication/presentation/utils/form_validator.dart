///[FormFieldValidateClass] is a class that contains all the form field validation methods
///[FormFieldValidateClass] contains the following methods:
///[validatePassword] validates the password
///[isValidEmail] validates the email
///[validateName] validates the name
class FormFieldValidateClass {
  // validate password

  String? validatePassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password should contain at least one special character';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password should contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password should contain at least one number';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password should contain at least one lowercase letter';
    }
    return null;
  }

  //validate email
  String? isValidEmail(String? value) {
    value = value?.trim();
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value ?? '')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }
}
