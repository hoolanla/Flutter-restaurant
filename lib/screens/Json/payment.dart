import 'dart:convert' show jsonDecode;

const paymentsJson = """
{
  "result": "success",
  "count": 2,
  "payments": [
    {
      "amount": "100.0",
      "destination": "rf1BiGeXwwQoi8",
      "executed_time": "2014-05-29T17:05:20Z",
      "source": "ra5nK24KXen9AH"
    },
    {
      "amount": "1.0",
      "destination": "ra5nK24KXen9AH",
      "executed_time": "2014-06-02T22:47:50Z",
      "source": "rf1BiGeXwwQoi8"
    }
  ]
}
""";

void main() {
  final pmt = new Payments.fromJson(paymentsJson);
  print(pmt.payments[1].destination);
  //expect(pmt.result, "success");
}

class Payments {
  //String result;
  int count;
  List<Payment> payments;

  Payments.fromJson(String jsonStr) {
    final _map = jsonDecode(jsonStr);
    //this.result = _map['result'];
    this.count = _map['count'];
    this.payments = [];
    final _paymentList = _map['payments'];

    for (var i = 0; i < (this.count); i++) {
      this.payments.add(new Payment.fromJson(_paymentList[i]));
    }
  }
}

class Payment {
  double amount;
  String source, destination;
  DateTime executedTime;

  Payment.fromJson(Map<String, dynamic> jsonMap) {
    this.amount = double.parse(jsonMap['amount']);
    this.source = jsonMap['source'];
    this.destination = jsonMap['destination'];
    this.executedTime = DateTime.parse(jsonMap['executed_time']);
  }
}
