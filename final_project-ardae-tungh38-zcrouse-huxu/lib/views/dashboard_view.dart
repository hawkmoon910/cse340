import 'dart:async';
import 'package:finance_tracker/category.dart';
import 'package:finance_tracker/helpers/tax_checker.dart';
import 'package:finance_tracker/providers/position_provider.dart';
import 'package:finance_tracker/providers/tax_provider.dart';
import 'package:finance_tracker/views/transaction_view.dart';
import 'package:finance_tracker/views/financial_statement_view.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/models/transaction_entry.dart';
import 'package:finance_tracker/providers/account_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

/// View to see all transaction entries currently stored in the 
/// Dashboard with the ability to add and edit past entries.
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}


class _DashboardViewState extends State<DashboardView> {
  late final Timer _checkerTimer;
  late final TaxChecker _taxChecker;

  final Color _backgroundColor = Colors.white;
  final Color _topBarColor = Colors.black;
  final Color _buttonColor = const Color.fromRGBO(110, 129, 196, 1);

  @override
  initState() {
    super.initState();

    final singleUseTaxProvider = Provider.of<TaxProvider>(context, listen: false);
    final singleUsePositionProvider = Provider.of<PositionProvider>(context, listen: false);
    _taxChecker = TaxChecker(singleUseTaxProvider, singleUsePositionProvider);

    _checkerTimer = Timer.periodic(
      const Duration(minutes: 5), 
      (timer) => _taxChecker.updateTaxes()
    );

    _taxChecker.updateTaxes(); // Will probably not work since position provider is slow
  }

  @override
  dispose() {
    super.dispose();
    _checkerTimer.cancel();
  }

  /// Builds dashboard view
  /// Parameters:
  ///   context - BuildContext of the current build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _topBarColor,
        title: Semantics(
          label: 'Finance Tracker',
          child: const Row(
            children: [
              Text('Finance Tracker', style: TextStyle(color: Colors.white),),
            ]
          ),
        ),
        actions: [
          Semantics(
            label: 'Generate Statement', 
            excludeSemantics: true,
            child: IconButton(
              onPressed: () => _navigateToFinance(context), 
              icon: const Icon(Icons.article, color: Colors.white,)
            )
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _backgroundColor
        ),
        child: Column(
          children: <Widget>[
            _buildSecondAppBar(context),
            Expanded(
              child: Consumer<AccountProvider>(
                builder: (context, provider, _) {
                  List<TransactionEntry> entries = provider.account.entries;
                  entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: entries.length,
                    itemBuilder: (context, index) => _createListElementForEntry(context, entries[index]),
                  );
                }
              )
            ),
            _buildBottomBar(context)
          ],
        ),
      ),
    );
  }

  /// Creates a list element from an entry. Each element will have semantics and
  /// on tap will call _navigateToEntry for its entry.
  /// Parameters:
  ///   context - BuildContext of the current build
  ///   entry - The entry to make a list entry for
  Widget _createListElementForEntry(BuildContext context, TransactionEntry entry) {
    TextStyle titleStyle = const TextStyle(fontSize: 20, color: Colors.black);
    TextStyle categoryStyle = const TextStyle(fontSize: 18, color: Colors.black54);

    String amountString = (entry.amount > 10000) ? entry.amount.toStringAsExponential() : entry.amount.toStringAsFixed(2);

    return Semantics(
      label: 'Button to edit Transaction Entry with Name ${entry.name}, Amount ${entry.amount}, Category ${entry.category}, and created at ${_formatDateTime(entry.createdAt)}',
      excludeSemantics: true,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () => _navigateToTransaction(context, entry),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: _buttonColor,
                  border: Border.all(color: Colors.transparent)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(alignment: Alignment.centerLeft, child: Text(_truncate(entry.name, length: 10), style: titleStyle,)),
                              Align(alignment: Alignment.centerLeft, child: Text('\$$amountString', style: titleStyle))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(alignment: Alignment.centerRight, child: Text(entry.category.toString(), style: categoryStyle,)),
                              Align(alignment: Alignment.centerRight, child: Text(_formatDateTime(entry.createdAt), style: categoryStyle))
                            ]
                          ),
                        )
                      ],
                    ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.close, color: Color.fromARGB(255, 152, 10, 0)),
              onPressed: () {
                _deleteEntry(context, entry);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Creates a second AppBar-like row with "Account" label and add transaction button.
  /// Parameters:
  ///   context - BuildContext of the current build
  Widget _buildSecondAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<AccountProvider>(
            builder: (context, provider, _) {
              return Semantics(label: 'Account Balance: ${provider.balance.toStringAsFixed(2)}',child: Text('Account Balance: ${_truncate(provider.balance.toStringAsFixed(2), length: 8)}', style: const TextStyle(color: Colors.black, fontSize: 24)));
            }
          ),
          Semantics(
            label: 'Add Transaction',
            child: IconButton(
              onPressed: () => _navigateToTransaction(context, TransactionEntry.now()),
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the bottom bar with pie charts showing income and expenses.
  /// Parameters:
  ///   context - BuildContext of the current build
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      height: 225,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPieChart(context, isExpense: false),
          _buildPieChart(context, isExpense: true)
        ],
      ),
    );
  }

  /// Builds a pie chart for either income or expenses.
  /// Parameters:
  ///   context - BuildContext of the current build
  ///   isExpense - bool value for type of pie chart
  Widget _buildPieChart(BuildContext context, {required bool isExpense}) {
    return Consumer<AccountProvider>(
      builder: (context, provider, _) {
        final entries = provider.account.entries;
        final data = _getPieChartData(entries, isExpense: isExpense);
        final chartType = isExpense ? 'Income' : 'Expenses';
        
        return Semantics(
          label: '$chartType Pie Chart',
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(isExpense ? 'Income' : 'Expenses', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: PieChart(
                  PieChartData(
                    sections: data,
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Gets the pie chart data for income or expenses.
  /// Parameters:
  ///   entries - List of entries to get data from
  ///   isExpense - bool value to filter entries for expenses (true) or income (false)
  List<PieChartSectionData> _getPieChartData(List<TransactionEntry> entries, {required bool isExpense}) {
    final filteredEntries = entries.where((entry) => isExpense ? entry.isExpense == false : entry.isExpense == true).toList();

    final Map<Category, double> categoryTotals = {};
    for (var entry in filteredEntries) {
      categoryTotals.update(entry.category, (value) => value + entry.amount.abs(), ifAbsent: () => entry.amount.abs());
    }

    final totalAmount = categoryTotals.values.fold(0.0, (sum, amount) => sum + amount);
    
    if (totalAmount == 0) {
      return [PieChartSectionData(
        color: Colors.grey,
        value: 100,
        title: 'No data',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      )];
    }

  // Map category to color
  final categoryColors = {
    Category.miscellaneousExpense: Colors.blue,
    Category.foodExpense: Colors.green,
    Category.entertainmentExpense: Colors.orange,
    Category.taxExpense: Colors.red,
    Category.housingExpense: Colors.purple,
    Category.insuranceExpense: Colors.yellow,
    Category.transportationExpense: Colors.teal,
    Category.miscellaneousIncome: Colors.lightBlue,
    Category.housingIncome: Colors.lightGreen,
    Category.businessIncome: Colors.amber,
    Category.wageIncome: Colors.pink,
    Category.none: Colors.grey,
  };

    return categoryTotals.entries.map((entry) {
      final percentage = (entry.value / totalAmount) * 100;
      return PieChartSectionData(
        color: categoryColors[entry.key] ?? Colors.grey,
        value: percentage,
        title: entry.key.shortToString(),
        radius: 50,
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        badgeWidget: Semantics(
          label: 'Category: ${entry.key}, Amount: ${entry.value}, Percentage: ${percentage.toStringAsFixed(1)}%'
        ),
      );
    }).toList();
  }

  /// Pushes a given transaction view onto the screen and once done editing, updates 
  /// the entry. If the transaction view cancel button is hit it will return null and
  /// so nothing gets added to the provider.
  /// Parameters:
  ///   context - BuildContext of the current build
  ///   entry - The entry to edit or the new entry to add to the provider.
  Future<void> _navigateToTransaction(BuildContext context, TransactionEntry entry) async {
    print('Navigating to entry: $entry');
    
    // We want to check to make sure we have tax information for the tax provider
    // before entering the transaction view.
    _taxChecker.checkAndUpdateTax();
    
    // Get tax provider and push on a new transaction view to the screen.
    TaxProvider taxProvider = Provider.of<TaxProvider>(context, listen: false);
    final newEntry = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => TransactionView(entry: entry, taxProvider: taxProvider))
    );

    // This statement will return only if the context passed to _navigateToEntry is not currently being displayed
    // The reason for this could be that there was for some reason two edits opend at once, in that case it would
    // be a bug and we should ignore it. This only works if newEntry isn't null.
    if (newEntry != null) {
      if (!context.mounted) return; 
      AccountProvider provider = Provider.of<AccountProvider>(context, listen: false);
      provider.upsertEntry(newEntry);
    }

  }

  /// Pushes a given financial statement view onto the screen
  /// Parameters:
  ///   context - BuildContext of the current build
  Future<void> _navigateToFinance(BuildContext context) async {
    AccountProvider provider = Provider.of<AccountProvider>(context, listen: false);
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => FinancialStatementView(transactions: provider.account.entries))
    );
  }

  /// Method to delete an entry from the provider
  /// Parameters:
  ///   context - BuildContext of the current build
  ///   entry - The entry to delete from the provider
  void _deleteEntry(BuildContext context, TransactionEntry entry) {
    AccountProvider provider = Provider.of<AccountProvider>(context, listen: false);
    provider.deleteEntry(entry);
  }

  /// Formats a datetime to be showned on the screen.
  /// Parameters:
  ///   when - The datetime to format
  _formatDateTime(DateTime when){
    // Changed to remove hours/minutes
    if (when.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return DateFormat.Md().add_jm().format(when);
    }
    return DateFormat.jm().format(when);
  }

  /// Truncates a string text if it is longer than given length. Will append the given 
  /// omission string to the end. leaves text unchanges if it is shorter than length
  /// Paremeters
  ///   text - The string to truncate
  ///   length - max length before truncating
  ///   omission - string to append if truncated
  String _truncate(String text, { required int length, omission = '...' }) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
}

}