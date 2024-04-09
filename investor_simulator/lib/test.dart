void main() {
  List<List<dynamic>> data = [
    [1712001600000, 68257.0, 69438.0, 68257.0, 69433.0],
    [1712016000000, 69647.0, 69869.0, 69390.0, 69786.0],
    [1712030400000, 69674.0, 69674.0, 66724.0, 66811.0],
    [1712044800000, 66772.0, 67124.0, 66340.0, 66583.0],
    [1712059200000, 66546.0, 66736.0, 65187.0, 65429.0],
  ];

  for (var point in data) {
    int timeInMillis = point[0];
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    print(
        'Time: ${dateTime.toString()}, Open: ${point[1]}, High: ${point[2]}, Low: ${point[3]}, Close: ${point[4]}');
  }
}
