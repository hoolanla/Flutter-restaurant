class Qrcode {
  final String restuarantID;
  final String tableID;

  Qrcode({this.restuarantID, this.tableID});

  factory Qrcode.fromJson(Map<String, dynamic> parsedJson) {
    return Qrcode(
      restuarantID: parsedJson['restuarantID'],
      tableID: parsedJson['tableID'],
    );
  }
}
