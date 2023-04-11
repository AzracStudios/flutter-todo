bool titleValidate(val, errorStream) {
  if (val.length < 6) {
    errorStream.add('Input needs atleast 6 characters');
    return true;
  }

  if (val.length > 30) {
    errorStream.add('Input should be no longer than 30 characters');
    return true;
  }

  errorStream.add(null);
  return false;
}

bool descValidate(val, errorStream) {
  if (val.length > 300) {
    errorStream.add('Input should be no longer than 300 characters');
    return true;
  }

  errorStream.add(null);
  return false;
}

bool timeValidate(errorStream, startTime, endTime) {
  int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
  int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;

  if (startTimeInt >= endTimeInt) {
    errorStream.add("Invalid start time");
    return true;
  }

  errorStream.add(null);
  return false;
}
