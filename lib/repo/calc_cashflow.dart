
import 'package:intl/intl.dart';
import 'package:my_budgets/models/m_models.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class CalcCashFlow {

  UserModel? userModel;
  CategoryModel? categoryModel;
  WalletModel? walletModel;
  BudgetModel? budgetModel;

  double amount = 0;

  List<UserModel> users = [];
  List<CategoryModel> categories = [];
  List<WalletModel> wallets = [];
  List<BudgetModel> budgets = [];
  List<ReccurenceModel> reccurences = [];

  CalcCashFlow({
    required this.amount,
  });

  void init(){
    users.add(UserModel(id: 1, email: "dimas@gmail.com", full_name: "dimas alamsyah", password: "123456"));
    users.add(UserModel(id: users.length + 1, email: "hilda@gmail.com", full_name: "hilda pratiwi", password: "123456"));

    categories.add(CategoryModel(id: categories.length + 1, category_name: "Shopping", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Internet", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "BBM", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Food", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "jajanku", type_category: "expenses", user_id: 1));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Bensinku", type_category: "expenses", user_id: 2));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Daganganku", type_category: "income", user_id: 1));

    wallets.add(WalletModel(id: wallets.length + 1, amount: 5000000, user_id: 1));
    wallets.add(WalletModel(id: wallets.length + 1, amount: 4500000, user_id: 1));

    budgets.add(BudgetModel(id: budgets.length + 1, budget_name: "BBM", user_id: 1, wallet_id: 1, budget_for_category_id: 0, reccurence_id: 1, start_date: "2022-10-10", amount: 1500000));
    budgets.add(BudgetModel(id: budgets.length + 1, budget_name: "Internet", user_id: 2, wallet_id: 2, budget_for_category_id: 0, reccurence_id: 1, start_date: "2022-10-10", amount: 500000));

    reccurences.add(ReccurenceModel(id: reccurences.length + 1, recurrance_name: "monthly", user_id: 0));
    reccurences.add(ReccurenceModel(id: reccurences.length + 1, recurrance_name: "year", user_id: 0));
  }

  void input(UserModel userModel, CategoryModel categoryModel, WalletModel walletModel, BudgetModel budgetModel){
    this.userModel = userModel;
    this.categoryModel = categoryModel;
    this.walletModel = walletModel;
    this.budgetModel = budgetModel;
  }

  double getWalletBalance(){
    return walletModel!.amount;
  }

  double getBudgetBalance(){
    return budgetModel!.amount;
  }

  @override
  String toString() {
    return 'CalcCashFlow{userModel: $userModel, categoryModel: $categoryModel, walletModel: $walletModel, budgetModel: $budgetModel}';
  }
}