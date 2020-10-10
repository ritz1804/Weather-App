String time(){
  DateTime now = DateTime.now();
  var hour = now.hour;
  var min = now.minute;

  String strMin;
  int lengthMin = min.toString().length;
  if(lengthMin < 2){
    strMin = '0'+'$min';
  }
  else{
    strMin = '$min';
  }

  String strHour;
  int lengthHour = hour.toString().length;
  if(lengthHour < 2){
    strHour = '0'+'$hour';
  }
  else{
    strHour = '$hour';
  }

  return '$strHour:$strMin';
}

String date(){
  DateTime now = DateTime.now();
  var year = now.year;
  var month = now.month;
  var date = now.day;
  var weekday = now.weekday;

  String day;
  String monthName;

  if(weekday == 1){
    day = 'Monday';
  }
  else if(weekday == 2){
    day = 'Tuesday';
  }
  else if(weekday == 3){
    day = 'Wednesday';
  }
  else if(weekday == 4){
    day = 'Thursday';
  }
  else if(weekday == 5){
    day = 'Friday';
  }
  else if(weekday == 6){
    day = 'Saturday';
  }
  else{
    day = 'Sunday';
  }

  if(month == 1){
    monthName = 'Jan';
  }
  else if(month == 2){
    day = 'Feb';
  }
  else if(month == 3){
    monthName = 'Mar';
  }
  else if(month == 4){
    monthName = 'Apr';
  }
  else if(month == 5){
    monthName = 'May';
  }
  else if(month == 6){
    monthName = 'Jun';
  }
  else if(month == 7){
    monthName = 'Jul';
  }
  else if(month == 8){
    monthName = 'Aug';
  }
  else if(month == 9){
    monthName = 'Sep';
  }
  else if(month == 10){
    monthName = 'Oct';
  }
  else if(month == 11){
    monthName = 'Nov';
  }
  else{
    monthName = 'Dec';
  }

  return '$day, $year $monthName $date';
}