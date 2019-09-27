
class RetLogin{
  String ResultOk;
  String ErrorMessage;
  String ReturnMessage;
  String userName;
  String email;
  int memberID;
  String restaurantID;


  RetLogin ({
    this.ResultOk,
    this.ErrorMessage,
    this.ReturnMessage,
    this.userName,
    this.email,
    this.memberID,
    this.restaurantID,
  });
  factory RetLogin.fromJson(Map<String, dynamic> parsedJson){
    return RetLogin(
      ResultOk: parsedJson['ResultOk'],
      ErrorMessage: parsedJson['ErroMessage'],
      ReturnMessage: parsedJson['ReturnMessage'],
      userName: parsedJson['userName'],
      email: parsedJson['email'],
      memberID: parsedJson['memberID'],
      restaurantID: parsedJson['restaurantID'],
    );
  }
}