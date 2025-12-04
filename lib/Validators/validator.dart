String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return 'Mobile number is required';
  }
  if (value.length != 10) {
    return 'Please enter a valid mobile number';
  }
  if (RegExp(r'^[0-5]').hasMatch(value)) {
    return 'Invalid format';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Special characters not allowed';
  }
  return null;
}


String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)){
    return ' Enter Alphabetic characters only';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'Email is required';
  }
  
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
    return 'Enter a valid email address';
    }
  
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  
  // Minimum 8 characters
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  
  // At least one uppercase letter
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }

  // At least one lowercase letter
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }

  // At least one digit
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one digit';
  }

  // At least one special character
 

  return null; // Validation passed
}


String? loginvalidatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  // At least one special character
 

  return null; // Validation passed
}


String? validatePasswordMatch(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Please re-enter your password';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? validatePrice(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a price';
  }

  final n = num.tryParse(value);
  if (n == null) {
    return 'Please enter a valid number';
  }

  if (n <= 0) {
    return 'Price must be greater than zero';
  }

  // Optional: Validate decimal places (e.g., maximum 2 decimal places)
  final regex = RegExp(r'^\d+(\.\d{1,2})?$');
  if (!regex.hasMatch(value)) {
    return 'Price can have at most 2 decimal places';
  }

  return null; // Return null if the input is valid
}

String? validatePinCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a PIN code';
  } else if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
    return 'Please enter a valid 6-digit PIN code';
  }
  return null;
}

String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your account number';
    } else if (!RegExp(r'^[0-9]{10,16}$').hasMatch(value)) {
      return 'Please enter a valid account number (10-16 digits)';
    }
    return null;
  }

   String? validateIFSC(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an IFSC code';
  }
  // Check if the input is in uppercase
  if (value != value.toUpperCase()) {
    return 'Please enter the IFSC code in uppercase';
  }
  // Regex pattern for IFSC code
  final regex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid IFSC code';
  }
  return null;
}

String? validatePAN(String value) {
  if (value.isEmpty) {
    return 'Please enter a PAN number';
  }
  // Check if the input is in uppercase
  if (value != value.toUpperCase()) {
    return 'Please enter the PAN number in uppercase';
  }
  String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter a valid PAN number';
  }
  return null;
}

String? validateGST(String value) {
  if (value.isEmpty) {
    return 'Please enter a GST number';
  }
  // Check if the input is in uppercase
  if (value != value.toUpperCase()) {
    return 'Please enter the GST number in uppercase';
  }
  String pattern = r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[A-Z0-9]{3}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter a valid GST number';
  }
  return null;
}


String? validateRegion(String? value) {
  if (value == null || value.isEmpty) {
    return 'Region cannot be empty';
  }
  
  // You can also add further validation like allowed region names or pattern matching
  // Example: Only allow alphabetical characters and spaces
  final RegExp regionPattern = RegExp(r'^[a-zA-Z\s]+$');
  if (!regionPattern.hasMatch(value)) {
    return 'Region contains invalid characters';
  }

  return null; // Returns null if the validation passes
}

String? validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return 'City cannot be empty';
  }

  // Validate for letters and spaces only
  final RegExp cityPattern = RegExp(r'^[a-zA-Z\s]+$');
  if (!cityPattern.hasMatch(value)) {
    return 'City contains invalid characters';
  }

  return null; // Returns null if validation passes
}

String? validateCountry(String? value) {
  if (value == null || value.isEmpty) {
    return 'Country cannot be empty';
  }

  // Validate for letters and spaces only
  final RegExp countryPattern = RegExp(r'^[a-zA-Z\s]+$');
  if (!countryPattern.hasMatch(value)) {
    return 'Country contains invalid characters';
  }

  return null; // Returns null if validation passes
}

String? validateRestaurantName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Restaurant name cannot be empty';
  }

  // Validate for allowed characters: letters, numbers, spaces, apostrophes, and hyphens
  final RegExp restaurantNamePattern = RegExp(r"^[a-zA-Z0-9\s'-]+$");
  if (!restaurantNamePattern.hasMatch(value)) {
    return 'Restaurant name contains invalid characters';
  }

  // Optionally enforce a minimum or maximum length
  if (value.length < 3) {
    return 'Restaurant name must be at least 3 characters long';
  }
  
  return null; // Returns null if validation passes
}

String? validateBankName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Bank name cannot be empty';
  }

  // Validate for letters, spaces, apostrophes, and hyphens only
  final RegExp bankNamePattern = RegExp(r"^[a-zA-Z\s'-]+$");
  if (!bankNamePattern.hasMatch(value)) {
    return 'Bank name contains invalid characters';
  }

  // Optional: Ensure minimum length for validity
  if (value.length < 2) {
    return 'Bank name must be at least 2 characters long';
  }

  return null; // Returns null if validation passes
}


String? priceValidation (String? value) {
 if (value == null || value.trim().isEmpty) {
    return 'This field cannot be empty';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Only numbers are allowed';
  }
  return null;
}


String? validationNoempty (String? value) {
 if (value == null || value.trim().isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}


String? validationNoaddonpriceEmpty(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field cannot be empty';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Digit required';
  }
  return null;
}


String? addprice(String? value) {
  // Check if the value is empty (after trimming whitespace)
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }

  // Check if the value (after removing the ₹ symbol) is a valid price format
  String priceValue = value.trim().replaceFirst('₹', '').trim(); // Remove ₹ and check the rest of the input

  final RegExp priceRegExp = RegExp(r'^\d+(\.\d{1,2})?$'); // Validates numbers and optional 2 decimals
  if (!priceRegExp.hasMatch(priceValue)) {
    return 'Invalid price'; // Invalid price format
  }

  return null; // Return null if the value is valid
}

String? foodaddprice(String? value) {
  // Remove ₹ symbol and trim spaces
  String priceValue = value?.replaceAll('₹', '').trim() ?? '';

  // If value is empty after removing ₹, show required error
  if (priceValue.isEmpty) {
    return 'Required';
  }

  // Allow only whole numbers (no decimals)
  final RegExp wholeNumberRegExp = RegExp(r'^\d+$');
  if (!wholeNumberRegExp.hasMatch(priceValue)) {
    return 'Invalid price';
  }

  return null; // Valid input
}
