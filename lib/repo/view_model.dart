

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_budgets/models/m_models.dart';

class ViewModelCashFlow {

  static const String URL = 'https://script.google.com/macros/s/AKfycbwy14d5lXkrxfOO_WdbWI0EQRIH5sFvwdJX0PsF8ud7iCwq-m1ETUCtWT8CjyxYDv4Y/exec';
  static const String URL2 = 'https://script.google.com/macros/s/AKfycbzlU4dHetWaYffLqpZTWLhIoXlKDk1dpPIsO-RniBs0IkwXdr6uve27rw9Am1qbDU9i/exec';

  List<CategoryModel> decodeCategories(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<CategoryModel>((json) => CategoryModel.fromMap(json))
        .toList();
  }

  Future<List<CategoryModel>> fetchCategory() async {
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      return decodeCategories(response.body);
    } else {
      throw Exception('Unable to fetch data from the REST API');
    }
  }

  void submitForm(CashFlowModel feedbackForm, void Function(String) callback) async {


    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');

    try {
      print(feedbackForm.toJson());
      await http.post(URL2,
          body: jsonEncode(<String, int>{
        'id': 1,
        'user_id': 1,
        'category_id': 1,
        'wallet_id': 1,
        'budget_id': 1,
        'balance_wallet': 1,
        'balance_budget': 1,
        'amount': 1,
        'note': 1,
      })).then((response) async {
        print(response.statusCode);
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          print(url);
          await http.get(url).then((response) {
            print(response.body);
            callback(json.decode(response.body)['status']);
          });
        } else {
          callback(json.decode(response.body)['status']);
        }
      });
    } catch (e) {
      print('submit error: $e');
    }
  }


}