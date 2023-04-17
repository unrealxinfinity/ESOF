class TransactionModel {
  String? transactionID;
  String? userID;
  int expense;
  String name;
  num total;
  DateTime date;
  String? notes;

  TransactionModel(
      {this.transactionID,
      required this.userID,
      required this.expense,
      required this.name,
      required this.total,
      required this.date,
      this.notes});

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      TransactionModel(
        transactionID: json['transactionID'],
        userID: json['userID'],
        expense: json['expense'],
        name: json['name'],
        total: json['total'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        notes: json['notes'],
      );

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'expense': expense,
      'name': name,
      'total': total,
      'date': date.millisecondsSinceEpoch,
      'notes': notes,
    };
  }
}