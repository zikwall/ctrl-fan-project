enum Times {
  milliseconds,
  microseconds
}

double getSeconds(int value, Times from) {
  if (from == Times.microseconds) {
    return value / 10000;
  }

  if (from == Times.milliseconds) {
    return value / 1000;
  }

  return value.toDouble();
}

int getMilliseconds(int value) {
  return value * 1000;
}

double getNowTimestamp() {
  return getSeconds(new DateTime.now().millisecondsSinceEpoch, Times.milliseconds);
}