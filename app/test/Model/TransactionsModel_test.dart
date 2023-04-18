import 'package:es/Model/TransactionsModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    TransactionModel object = TransactionModel(
      userID: '1',
      categoryID: '2',
      expense: 1,
      name: 'Joe',
      total: 200,
      date: DateTime(2020, 10, 1));
  Map<String, dynamic> json = {
    'userID': '1',
    'categoryID': '2',
    'expense': 1,
    'name': 'Joe',
    'total': 200,
    'date': DateTime(2020, 10, 1).millisecondsSinceEpoch
  };

  group('Transaction model tests', () {
    test('Deserialize from JSON', () {
      TransactionModel temp = TransactionModel.fromMap(json);
      expect(temp.userID, json['userID']);
      expect(temp.categoryID, json['categoryID']);
      expect(temp.expense, json['expense']);
      expect(temp.name, json['name']);
      expect(temp.total, json['total']);
      expect(temp.date.millisecondsSinceEpoch, json['date']);
    });

    test('Serialize to JSON', () {
      Map<String, dynamic> serializedMap = object.toMap();
      expect(serializedMap['userID'], json['userID']);
      expect(serializedMap['categoryID'], json['categoryID']);
      expect(serializedMap['expense'], json['expense']);
      expect(serializedMap['name'], json['name']);
      expect(serializedMap['total'], json['total']);
      expect(serializedMap['date'], json['date']);
    });
  });
}