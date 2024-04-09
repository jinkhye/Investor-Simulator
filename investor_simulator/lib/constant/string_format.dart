String formatPercentageString(String input) {
  double value = double.tryParse(input) ?? 0.0;
  String formattedValue = value.toStringAsFixed(2); // Ensure two decimal places

  if (value >= 0) {
    formattedValue = '+$formattedValue%'; // Add '+' sign for positive values
  } else {
    formattedValue = '$formattedValue%';
  }

  return formattedValue;
}
