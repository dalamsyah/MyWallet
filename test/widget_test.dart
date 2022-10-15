// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_budgets/repo/calc_cashflow.dart';

import 'package:my_budgets/main.dart';
import 'package:my_budgets/models/m_models.dart';

var printLog = [];
void print(String s) => printLog.add(s);

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });



  CalcCashFlow calc = CalcCashFlow(amount: 150000);
  calc.init();
  calc.input(calc.users[0], calc.categories[0], calc.wallets[0], calc.budgets[1]);
  calc.toString();

  // test('calc cashflow', () => {
  //
  //   Give
  //
  //   expect("1", "1")
  //
  // });

  group("Cash flow", () {
    test("cek balance wallet", () {
      expect(calc.getWalletBalance(), 5000000);
    });
    test("cek balance budget", () {
      expect(calc.getBudgetBalance(), 500000);
    });
    test("cek balance amount", () {
      expect(calc.amount, 150000);
    });
  });

}
