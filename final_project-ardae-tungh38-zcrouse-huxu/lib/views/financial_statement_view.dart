import 'package:flutter/material.dart';
import '../models/transaction_entry.dart';



class FinancialStatementView extends StatelessWidget{
  const FinancialStatementView({required this.transactions, super.key});
  // background color from dashbord
  final Color _backgroundColor = Colors.white;
  // all transactions passed from dashboard
  final List<TransactionEntry> transactions;

  @override
  Widget build(BuildContext context) {
    // Creates the rows and columns for the app
    List<Widget> statements =_makeStatementList(transactions: transactions);
    return Scaffold(
      // Name of the app and back button
       appBar: AppBar(
        backgroundColor: Colors.white,
        title: Semantics(
          label: 'Financal Statement',
          child: const Row(
            children: [
              Text('Financal Statement', style: TextStyle(color: Colors.black),),
            ]
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _backgroundColor
        ),
        child: Column(
          // esnure equal spacing so the app looks tidy
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: statements
        ),
      ),
    );
  }

  /// Makes the statement list
  /// Parameters:
  ///   transactions - List of TransactionEntry
  _makeStatementList({required List<TransactionEntry> transactions}){
    List<Widget> revenueList = [];
    List<Widget> expenseList = [];
    List<Widget> returnList = [];
    double totalRevenue = 0;
    double totalExpense = 0;
    double taxExpense = 0;
    // iterate through each transaction
    for(int i = 0; i < transactions.length; i++){
      // determine if its an expense or not so we can adjust semantics and
      // add it to the relevant list
      if(transactions[i].category.toString().contains('Expense')){
        totalExpense += transactions[i].amount;
        taxExpense += transactions[i].taxAmount;
        expenseList.add(
        Semantics(
          label: 'Expense for ${transactions[i].name} at ${transactions[i].amount.toStringAsFixed(2)} dollars',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(transactions[i].name),
              Text(transactions[i].amount.toStringAsFixed(2)),
            ],
          ),
        )
      );
      } else { 
        totalRevenue += transactions[i].amount;
        revenueList.add(
        Semantics(
          label: 'Revenue for ${transactions[i].name} at ${transactions[i].amount.toStringAsFixed(2)} dollars',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(transactions[i].name),
              Text(transactions[i].amount.toStringAsFixed(2)),
            ],
          ),
        )
      );
    }
  }
    // Insert Titles
    expenseList.insert(0, Semantics(label: 'Expenses section', child: Container(alignment:Alignment.centerLeft, child: const Text('Expenses', style: TextStyle(fontSize: 30)))));
    // Insert Titles
    revenueList.insert(0, Semantics(label: 'Revenues section', child: Container(alignment:Alignment.centerLeft, child: const Text('Revenues', style: TextStyle(fontSize: 30)))));
    returnList.add(Column(crossAxisAlignment: CrossAxisAlignment.start, children: expenseList));
    returnList.add(Column(children: revenueList));
    // Insert Titles
    returnList.add(Semantics(label: 'Net change section', child: Container(alignment:Alignment.centerLeft, child: const Text('Net Change', style: TextStyle(fontSize: 30)))));
    returnList.add(
      Semantics(
        label: 'Net Revenue ${totalRevenue.toStringAsFixed(2)} dollars',
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Net Revenue'),
              Text(totalRevenue.toStringAsFixed(2)),
            ],
          ),
      )
    );
    // round the total expense and append it to the list
    returnList.add(
      Semantics(
        label: 'Net Expense ${(totalExpense).toStringAsFixed(2)} dollars',
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Net Expense'),
              Text((totalExpense).toStringAsFixed(2)),
            ],
          ),
      )
    );
    // round the tax expense and append it to the list
    returnList.add(
      Semantics(
        label: 'Net Tax ${(taxExpense).toStringAsFixed(2)} dollars',
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Net Tax'),
              Text((taxExpense).toStringAsFixed(2)),
            ],
          ),
      )
    );
    // calculate the net income by subtracting total expense from total revenue
    returnList.add(
      Semantics(
        label: 'Net Income ${(totalRevenue-totalExpense).toStringAsFixed(2)} dollars',
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Net Income'),
              Text((totalRevenue-totalExpense).toStringAsFixed(2)),
            ],
          ),
      )
    );
    return returnList;
  }

}