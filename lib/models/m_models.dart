

class UserModel {
  int id = 0;
  String? full_name;
  String? email;
  String? password;

  UserModel({
    this.id = 0, this.full_name, this.email, this.password
  });

  @override
  String toString() {
    return 'UserModel{id: $id, full_name: $full_name, email: $email, password: $password}';
  }

}

class CategoryModel {
  int id = 0;
  String? category_name;
  String? type_category;
  int user_id = 0;

  CategoryModel({
    this.id = 0, this.category_name, this.type_category, this.user_id = 0
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      category_name: json['category_name'],
      type_category: json['type_category'],
      user_id: json['user_id'],
    );
  }

  @override
  String toString() {
    return 'CategoryModel{id: $id, category_name: $category_name, type_category: $type_category, user_id: $user_id}';
  }

}

class WalletModel {
  int id = 0;
  String? wallet_name;
  double amount = 0;
  int user_id = 0;

  WalletModel({
    this.id = 0, this.wallet_name, this.amount = 0, this.user_id = 0
  });

  @override
  String toString() {
    return 'WalletModel{id: $id, wallet_name: $wallet_name, amount: $amount, user_id: $user_id}';
  }

}

class ReccurenceModel {
  int id = 0;
  String? recurrance_name;
  int user_id = 0;


  ReccurenceModel({this.id = 0, this.recurrance_name, this.user_id = 0});

  @override
  String toString() {
    return 'ReccurenceModel{id: $id, recurrance_name: $recurrance_name, user_id: $user_id}';
  }
}

class BudgetModel {
  int id = 0;
  String? budget_name;
  int user_id = 0;
  int wallet_id = 0;
  int budget_for_category_id = 0;
  int reccurence_id = 0;
  String? start_date;
  double amount = 0;

  BudgetModel({
    this.id = 0,
    this.budget_name,
    this.user_id = 0,
    this.wallet_id = 0,
    this.budget_for_category_id = 0,
    this.reccurence_id = 0,
    this.start_date,
    this.amount = 0
  });

  @override
  String toString() {
    return 'BudgetModel{'
        'id: $id, '
        'budget_name: $budget_name, '
        'user_id: $user_id, '
        'wallet_id: $wallet_id'
        'budget_for_category_id: $budget_for_category_id, '
        'reccurence_id: $reccurence_id, '
        'start_date: $start_date, '
        'amount: $amount'
        '}';
  }

}

class CashFlowModel {

  int id = 0;
  int user_id = 0;
  int category_id = 0;
  int wallet_id = 0;
  int budget_id = 0;
  double balance_wallet = 0;
  double balance_budget = 0;
  double amount = 0;
  String? note = '';

  CashFlowModel({
      this.id = 0,
      this.user_id = 0,
      this.category_id = 0,
      this.wallet_id = 0,
      this.budget_id = 0,
      this.balance_wallet = 0,
      this.balance_budget = 0,
      this.amount = 0,
      this.note
  });

  factory CashFlowModel.fromMap(Map<String, dynamic> json) {
    return CashFlowModel(
      id: json['id'],
      user_id: json['user_id'],
      category_id: json['category_id'],
      wallet_id: json['wallet_id'],
      budget_id: json['budget_id'],
      balance_wallet: json['balance_wallet'],
      balance_budget: json['balance_budget'],
      amount: json['amount'],
      note: json['note'],
    );
  }

  Map toJson() => {
    'id': id,
    'user_id': user_id,
    'category_id': category_id,
    'wallet_id': wallet_id,
    'budget_id': budget_id,
    'balance_wallet': balance_wallet,
    'balance_budget': balance_budget,
    'amount': amount,
    'note': note,
  };

  @override
  String toString() {
    return 'CashFlowModel{id: $id, user_id: $user_id, category_id: $category_id, wallet_id: $wallet_id, budget_id: $budget_id, balance_wallet: $balance_wallet, balance_budget: $balance_budget, amount: $amount, note: $note}';
  }


}