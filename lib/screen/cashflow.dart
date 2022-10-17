import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_budgets/models/m_models.dart';
import 'package:my_budgets/repo/calc_cashflow.dart';
import 'package:my_budgets/repo/view_model.dart';


class CashFlowPage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  State<StatefulWidget> createState() => _CashFlowInput();

}

class _CashFlowInput extends State<CashFlowPage> {

  List<CashFlowModel> datas = [];

  List<UserModel> users = [];
  List<CategoryModel> categories = [];
  List<WalletModel> wallets = [];
  List<BudgetModel> budgets = [];
  List<ReccurenceModel> reccurences = [];

  late CategoryModel selectedCategoryValue;
  late UserModel selectedUserValue;
  late WalletModel selectedWalletValue;
  late BudgetModel selectedBudgetValue;
  late ReccurenceModel selectedReccurenceValue;

  TextEditingController _controllerAmount = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    users.add(UserModel(id: 1, email: "dimas@gmail.com", full_name: "dimas alamsyah", password: "123456"));
    users.add(UserModel(id: users.length + 1, email: "hilda@gmail.com", full_name: "hilda pratiwi", password: "123456"));

    categories.add(CategoryModel(id: categories.length + 1, category_name: "Shopping", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Internet", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "BBM", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Food", type_category: "expenses", user_id: 0));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "jajanku", type_category: "expenses", user_id: 1));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Bensinku", type_category: "expenses", user_id: 2));
    categories.add(CategoryModel(id: categories.length + 1, category_name: "Daganganku", type_category: "income", user_id: 1));

    wallets.add(WalletModel(id: wallets.length + 1, wallet_name: "dompet 1", amount: 5000000, user_id: 1));
    wallets.add(WalletModel(id: wallets.length + 1, wallet_name: "dompet 2", amount: 4500000, user_id: 1));

    budgets.add(BudgetModel(id: budgets.length + 1, budget_name: "BBM", user_id: 1, wallet_id: 1, budget_for_category_id: 0, reccurence_id: 1, start_date: "2022-10-10", amount: 1500000));
    budgets.add(BudgetModel(id: budgets.length + 1, budget_name: "Internet", user_id: 2, wallet_id: 2, budget_for_category_id: 0, reccurence_id: 1, start_date: "2022-10-10", amount: 500000));

    reccurences.add(ReccurenceModel(id: reccurences.length + 1, recurrance_name: "monthly", user_id: 0));
    reccurences.add(ReccurenceModel(id: reccurences.length + 1, recurrance_name: "year", user_id: 0));

    selectedCategoryValue = categories.first;
    selectedWalletValue = wallets.first;
    selectedBudgetValue = budgets.first;

  }

  @override
  Widget build(BuildContext context) {

    final topBar = Container(
      color: Colors.black.withAlpha(10),
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: List.generate(wallets.length, (index) {
            return Text('${wallets[index].wallet_name} ${ CurrencyFormat.convertToIdr(wallets[index].amount, 2) }');
          }),
      ),
    );

    final cashFlowList = Container(
      height: double.infinity,
      child: ListView.builder(
          itemCount: datas.length,

          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Container(
                color: Colors.white,
                child: IntrinsicHeight(
                  child:  Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Container(
                      width: 8,
                      color: categories.firstWhere((element) => element.id == datas[index].category_id).type_category == "income" ? Colors.green : Colors.red,
                    ),
                    Expanded(
                        child: 
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(CurrencyFormat.convertToIdr(datas[index].amount, 2)),
                                  Text('Budget: ${budgets.firstWhere((element) => element.id == datas[index].budget_id).budget_name}')
                                ],
                              ),
                              Text('Category: ${categories.firstWhere((element) => element.id == datas[index].category_id).category_name}'),
                            ],
                          ),
                        )
                    )
                    // Container(
                    //   color: Colors.red,
                    //
                    // ),

                    // Expanded(
                    //   child: Column(
                    //     children: [
                    //       Expanded(child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.stretch,
                    //         children: [
                    //           Text(CurrencyFormat.convertToIdr(datas[index].amount, 2)),
                    //           Text('Budget: ${budgets.firstWhere((element) => element.id == datas[index].budget_id).budget_name}')
                    //         ],
                    //       )),
                    //       Text('Category: ${categories.firstWhere((element) => element.id == datas[index].category_id).category_name}'),
                    //     ],
                    //   ),
                    // )

                  ]),
                ),
              ),
            );
          }
      ),
    );

    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [
            topBar,
            Expanded(
                child: cashFlowList
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomSheet(),
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );

  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    // _scaffoldKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void bottomSheet() {

    _controllerAmount.text = '';

    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          StatefulBuilder(builder: (BuildContext context, StateSetter setState2) {

            final amountInput = TextFormField(
              controller: _controllerAmount,
              onChanged: (value) {
                // _controllerAmount.text = CurrencyFormat.convertToIdr(double.parse(value), 2);
              },
              keyboardType: TextInputType.number,
              autofocus: false,
              // onFieldSubmitted: (amount) {
              //   final formattedPrice = CurrencyFormat.convertToIdr(amount, 2);
              //   debugPrint('Formatted $formattedPrice');
              //   _controllerAmount.value = TextEditingValue(
              //     text: formattedPrice,
              //     selection:
              //     TextSelection.collapsed(offset: formattedPrice.length),
              //   );
              // },
              decoration: InputDecoration(
                hintText: '123456',
                contentPadding: const EdgeInsets.fromLTRB(
                    20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            );

            final submitButton = Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.transparent)
                            )
                        )
                    ),
                    onPressed: () {

                      CashFlowModel data = CashFlowModel(
                          id: datas.length + 1,
                          user_id: users.first.id,
                          category_id: selectedCategoryValue.id,
                          wallet_id: selectedWalletValue.id,
                          budget_id: selectedBudgetValue.id,
                          balance_budget: 0,
                          balance_wallet: 0,
                          amount: 123,
                          note: "-"

                      );

                      ViewModelCashFlow().submitForm(data, (String response) {
                        print("Response: $response");

                        if (response == "SUCCESS") {
                          // Feedback is saved succesfully in Google Sheets.
                          _showSnackbar("Submitted");
                        } else {
                          // Error Occurred while saving data in Google Sheets.
                          _showSnackbar("Error Occurred!");
                        }
                      });

                      setState(() =>
                      {
                        datas.add(
                            data
                        )

                      });
                      print(datas.last);

                      // WalletModel walletModel = wallets.firstWhere((element) => element.id == selectedWalletValue.id);
                      // walletModel.amount = walletModel.amount - double.parse(_controllerAmount.text);
                      //
                      // wallets.remove(walletModel);
                      // wallets.add(walletModel);
                      //
                      // wallets.sort((a, b) => a.id.compareTo(b.id));

                      _controllerAmount.text = '';
                      Navigator.pop(context);

                    },
                    child: const Text('Submit'),
                  ),
                )
            );

            final dropDownCategory = SizedBox(
              width: double.infinity,
              child: DropdownButton(
                  value: selectedCategoryValue,
                  onChanged: (CategoryModel? newValue) =>
                      setState2(() => selectedCategoryValue = newValue!),
                  items: categories.map<DropdownMenuItem<CategoryModel>>((CategoryModel value) {
                    return DropdownMenuItem<CategoryModel>(
                      value: value,
                      child: Text('${value.category_name}'),
                    );
                  }).toList()
              ),
            );

            final dropDownWallet = Container(
              width: double.infinity,
              child: DropdownButton(
                  value: selectedWalletValue,
                  onChanged: (WalletModel? newValue) {
                    setState2(() {
                      selectedWalletValue = newValue!;
                    });
                  },
                  items: wallets.map<DropdownMenuItem<WalletModel>>((WalletModel value) {
                    return DropdownMenuItem<WalletModel>(
                      value: value,
                      child: Text('${value.wallet_name}'),
                    );
                  }).toList()
              ),
            );

            final dropDownBudget = SizedBox(
              width: double.infinity,
              child: DropdownButton(
                  value: selectedBudgetValue,
                  onChanged: (BudgetModel? newValue) {
                    setState2(() {
                      selectedBudgetValue = newValue!;
                    });
                  },
                  items: budgets.map<DropdownMenuItem<BudgetModel>>((BudgetModel value) {
                    return DropdownMenuItem<BudgetModel>(
                      value: value,
                      child: Text('${value.budget_name}'),
                    );
                  }).toList()
              ),
            );

            return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
                ),
                padding: const EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Column(
                    children: [
                      dropDownCategory,
                      dropDownWallet,
                      dropDownBudget,
                      amountInput,
                      submitButton,
                    ],
                  ),
                )
            );

          })
    );
  }

}

class CashFlowListPage extends StatefulWidget {
  CashFlowListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CashFlowList();
}

class _CashFlowList extends State<CashFlowListPage> {

  final datas = ['Albania', 'Andorra'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Container(
            color: Colors.blue,
            child: SafeArea(
              child: ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(datas[index]),
                    );
                  }
              ),
            )
        ),
      ),
    );
    
  }
  
}