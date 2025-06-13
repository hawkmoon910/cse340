import 'package:finance_tracker/providers/tax_provider.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/models/transaction_entry.dart';
import 'package:finance_tracker/category.dart';

/// Widget that is used to edit a entry. Meant to be pushed onto the screen, will return new entry 
/// when poped from navigator if the user decides to save any information. Else null will be 
/// returned. Does not modify the given entry's createdAt date. 
class TransactionView extends StatefulWidget {
  final TransactionEntry entry;

  final TaxProvider taxProvider;

  const TransactionView({super.key, required this.entry, required this.taxProvider});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

/// State for TransactionView
class _TransactionViewState extends State<TransactionView>{

  String currentName = '';
  TextEditingController nameCon = TextEditingController();
  bool currentIsExpense = false;
  double currentAmount = 0.0;
  TextEditingController amountCon = TextEditingController();
  Category currentCategory = Category.none;
  String currentDescription = '';
  TextEditingController descriptionCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentName = widget.entry.name;
    currentIsExpense = widget.entry.isExpense;
    currentAmount = widget.entry.amount;
    currentCategory = widget.entry.category;
    currentDescription = widget.entry.description;

    // Initializing controllers for the editable fields.
    nameCon = TextEditingController(text: currentName);
    descriptionCon = TextEditingController(text: currentDescription);
    String defaultAmountText = (currentAmount == 0) ? '' : currentAmount.toString();
    amountCon = TextEditingController(text: defaultAmountText);
  }

  /// Builds transaction view
  /// Parameters:
  ///   context - BuildContext of the current build
  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyles = TextStyle(fontSize: 20);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) _popBack(context, save: false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Transaction'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                _popBack(context, save: true);
              },
              tooltip: 'Save',
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('Name:', style: labelStyles)
                ),
                Expanded(
                  flex: 2,
                  child: Semantics(
                    label:'name field, current text: $currentName',
                    excludeSemantics: true,
                    child: TextField(onChanged: (value) => setState(() => currentName = value), controller: nameCon, decoration: const InputDecoration(hintText: 'Enter Name'))
                  )
                )
              ]
            ),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('Amount:', style: labelStyles)
                ),
                Expanded(
                  flex: 2,
                  child: Semantics(
                    label:'amount field, current amount: ${currentAmount.toString()}',
                    excludeSemantics: true,
                    child: TextField(onChanged: (value) => setState(() => currentAmount = double.tryParse(value) ?? 0), controller: amountCon, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'Enter Amount'))
                  )
                )
              ]
            ),
            Row(
              children: [
                const Expanded(flex: 1, child: Text('Category: ', style: labelStyles)),
                Expanded(
                  flex: 2,
                  child: Semantics(
                    label: 'categories field, select dropdown',
                    excludeSemantics: true,
                    child: DropdownButton<Category>(
                      value: currentCategory,
                      items: Category.values.map((Category category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Semantics(label: category.toString(), child: Text(category.toString())),
                        );
                      }).toList(),
                      onChanged: (Category? newCategory) {
                        setState(() {
                          currentCategory = newCategory!;
                        });
                      },
                    ),
                  )
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 1, child: Text('Description: ', style: labelStyles)),
                Expanded(
                  flex: 2,
                  child: Semantics(
                    label: 'description field, current description: $currentDescription',
                    excludeSemantics: true,
                    child: TextFormField(
                      initialValue: currentDescription,
                      style: const TextStyle(fontSize: 16.0),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          currentDescription = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2), gapPadding: 2.0),
                        hintText: '(Optional) Enter Description'
                      ),
                    ),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Callback for back and save button. On the event we want to not save the entry then it
  /// will pop the current view from the navigator and return null. In the event that we do 
  /// want to save then it will determine if all fields are filled, if not it will give
  /// the user a warning, else it will create a new transaction entry with the given fields
  /// and pop the current view from the navigator, returning the newly created entry.
  /// Parameters:
  ///   save - Boolean value for if to save the current information into a new transaction
  _popBack(BuildContext context, {required bool save}){
    if (save) {
      if (currentName == '' || currentAmount == 0.0 || currentCategory == Category.none) {
        _createWarningPopUp(context, _getWarning());
        return;
      }

      late TransactionEntry newEntry;
      if (currentCategory.isTaxedExpense) {
        double newTax = (currentAmount - (currentAmount/(widget.taxProvider.taxRate + 1)) ); // Gets tax amount given current tax rate
        newEntry = TransactionEntry.withUpdatedFields(widget.entry, currentName, currentDescription, currentCategory, newTax, currentAmount, true);
      } else {
        newEntry = TransactionEntry.withUpdatedFields(widget.entry, currentName, currentDescription, currentCategory, 0.0, currentAmount, currentCategory.isExpense);
      }
      Navigator.pop(context, newEntry);
    } else {
      Navigator.pop(context, null);
    }
  }

  /// Creates a pop up warning on the current view with a given warning. Has a title with
  /// the text 'Required Fields' and a button that exits the pop up with the text 'OK'.
  /// Parameters:
  ///   context - BuildContext of the current view
  ///   warning - The warning to give the user
  _createWarningPopUp(BuildContext context, String warning) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Required Fields'),
        content: Text(warning),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      )
    );
  }

  /// Gets the current warning used give to the user based off of the current state of the
  /// text fields. It frist checks for no name given, then no amount and finally if a
  /// category is not selected. If no warning is needed to be given then an error message
  /// will be returned.
  String _getWarning() {
    if (currentName == '') {
      return 'Please enter a name for the transaction.';
    } else if (currentAmount == 0.0) {
      return 'Please enter an amount for the transaction.';
    } else if (currentCategory == Category.none) {
      return 'Please select a category for the transaction';
    } else {
      return 'Error: No Warning To Give';
    }
  }
}

