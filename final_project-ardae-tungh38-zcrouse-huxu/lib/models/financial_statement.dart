import 'package:finance_tracker/category.dart';
import 'package:finance_tracker/models/account.dart';
import 'package:finance_tracker/models/transaction_entry.dart';



class FinancialStatement {

  /// statement is a map that represent the financial statement
  /// every other functions except the constructor update this statement.
  var expenses =
  {
  'Expense': 0.0,
  'Tax Expense': 0.0,
  'Food Expense': 0.0,
  'Entertainment Expense': 0.0,
  'Transportation Expense': 0.0,
  'Housing Expense': 0.0,
  'Business Expense': 0.0,
  'Insurance Expense' : 0.0,
  'Miscelenoues Expense': 0.0,
  };

  var revenues = {
  'Revenue': 0.0,
  'Wage Income': 0.0,
  'Sale Income': 0.0,
  'Net Income': 0.0,
  'Business Income': 0.0,
  'Housing Income': 0.0,
  'Miscelenoues Income': 0.0,
  };

  var expenseEnum = [Category.foodExpense];

  // Revenues - Expense = Net Income.
  double netIncome = 0.0;

  /// This is the main constructor of the JournalStatement.
  FinancialStatement(Account account);

  /// Traverses over the revenues and expense, and add every income together,
  /// then subtract any expenses to get net income.
  /// Update net income in the statement as well
  /// @Return int - Net income.
  void updateNetIncome() {
    netIncome = expenses['Expense']! + revenues['Revenue']!;
  }

  /// This function iterate through the list of journal entry, then update the entry accordingly
  void generateFinancialStatement(Account account) {
    var transactions = account.entries;

    for (TransactionEntry transaction in transactions) {
      Category transactionCategory = transaction.category;
      double? amount = transaction.amount;

      if (transaction.isExpense) {
        double? currExpense =  expenses['Expense'];
        expenses['Expense'] = (currExpense! + amount);
      } else {
        double? currIncome =  revenues['Revenue'];
        revenues['Revenue'] = (currIncome! + amount);
      }

      switch (transactionCategory) {
        case Category.foodExpense:
          double? curr = expenses['Food Expense'];
          expenses['Food Expense'] = (curr! + amount);
          break;
        case Category.transportationExpense:
          double? curr = expenses['Transporation Expense'];
          expenses['Transaction Expense'] = (curr! + amount);
          break;
        case Category.entertainmentExpense:
          double? curr = expenses['Entertainment Expense'];
          expenses['Entertainment Expense'] = (curr! + amount);
          break;
        case Category.businessIncome:
          double? curr = revenues['Business Income'];
          revenues['Business Income'] = (curr! + amount);
          break;
        case Category.taxExpense:
          double? curr = expenses['Tax Expense'];
          expenses['Tax Expense'] = (curr! + amount);
          break;
        case Category.housingExpense:
          double? curr = expenses['Housing Expense'];
          expenses['Housing Expense'] = (curr! + amount);
          break;
        case Category.housingIncome:
          double? curr = revenues['Housing Income'];
          revenues['Housing Income'] = (curr! + amount);
          break;
        case Category.insuranceExpense:
          double? curr = expenses['Insurance Expense'];
          expenses['Insurance Expense'] = (curr! + amount);
          break;
        case Category.miscellaneousExpense:
          double? curr = expenses['Miscellaneous Expense'];
          expenses['Miscellaneous Expense'] = (curr! + amount);
          break;
        case Category.miscellaneousIncome:
          double? curr = expenses['Miscellaneous Income'];
          expenses['Miscellaneous Income'] = (curr! + amount);
          break;
        case Category.wageIncome:
          double? curr = revenues['Wage Income'];
          revenues['Wage Income'] = (curr! + amount);
          break;
        case Category.none:
          print('Unexpected Category');
          break;
        default:
          Category.none;
      }
    }
  }
}