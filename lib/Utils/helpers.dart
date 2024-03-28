String convertDateString(String dateString) {
  // Phân tích chuỗi ngày tháng thành đối tượng DateTime
  DateTime dateTime = DateTime.parse(dateString);

  // Chuyển định dạng của ngày tháng
  String formattedDate = '${dateTime.day}-${dateTime.month}-${dateTime.year}';

  return formattedDate;
}
