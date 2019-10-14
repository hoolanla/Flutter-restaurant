class Qrcode {
  final String ResultOk;
  final String ErrorMessage;
  final String ReturnMessage;
  final String restaurantID;
  final String tableID;
  final String tableName;

  Qrcode(
      {this.ResultOk,
      this.ErrorMessage,
      this.ReturnMessage,
      this.restaurantID,
      this.tableID,
      this.tableName});

  factory Qrcode.fromJson(Map<String, dynamic> parsedJson) {
    return Qrcode(
      ResultOk: parsedJson['ResultOk'],
      ErrorMessage: parsedJson['ErrorMessage'],
      ReturnMessage: parsedJson['ReturnMessage'],
      restaurantID: parsedJson['restaurantID'],
      tableID: parsedJson['tableID'],
      tableName: parsedJson['tableName'],
    );
  }
}
