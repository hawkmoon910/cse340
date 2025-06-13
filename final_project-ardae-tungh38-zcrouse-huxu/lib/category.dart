import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
enum Category {
  @HiveField(0)
  miscellaneousExpense, 
  @HiveField(1)
  foodExpense, 
  @HiveField(2)
  entertainmentExpense, 
  @HiveField(3)
  taxExpense, 
  @HiveField(4)
  housingExpense, 
  @HiveField(5)
  insuranceExpense, 
  @HiveField(6)
  transportationExpense, 
  @HiveField(7)
  miscellaneousIncome, 
  @HiveField(8)
  housingIncome, 
  @HiveField(9)
  businessIncome, 
  @HiveField(10)
  wageIncome, 
  @HiveField(11)
  none;

  /// Converts category enum to a user-friendly string.
  @override
  String toString() {
    switch (this) {
      case Category.miscellaneousExpense:
        return 'Miscellaneous Expense';
      case Category.foodExpense:
        return 'Food Expense';
      case Category.entertainmentExpense:
        return 'Entertainment Expense';
      case Category.taxExpense:
        return 'Tax Expense';
      case Category.housingExpense:
        return 'Housing Expense';
      case Category.insuranceExpense:
        return 'Insurance Expense';
      case Category.transportationExpense:
        return 'Transportation Expense';
      case Category.miscellaneousIncome:
        return 'Miscellaneous Income';
      case Category.housingIncome:
        return 'Housing Income';
      case Category.businessIncome:
        return 'Business Income';
      case Category.wageIncome:
        return 'Wage Income';
      case Category.none:
        return 'None';
    }
  }

  /// Converts user-friendly string to a short string.
  String shortToString() {
    switch (this) {
      case Category.miscellaneousExpense:
      case Category.miscellaneousIncome:
        return 'Miscellaneous';
      case Category.foodExpense:
        return 'Food';
      case Category.entertainmentExpense:
        return 'Entertainment';
      case Category.taxExpense:
        return 'Tax';
      case Category.housingExpense:
        return 'Housing';
      case Category.insuranceExpense:
        return 'Insurance';
      case Category.transportationExpense:
        return 'Transportation';
      case Category.housingIncome:
        return 'Housing';
      case Category.businessIncome:
        return 'Business';
      case Category.wageIncome:
        return 'Wage';
      case Category.none:
        return 'None';
    }
  }

  /// Sets category to expense or income.
  bool get isExpense {
    switch (this) {
      case Category.miscellaneousExpense:
      case Category.foodExpense:
      case Category.entertainmentExpense:
      case Category.taxExpense:
      case Category.housingExpense:
      case Category.insuranceExpense:
      case Category.transportationExpense:
        return true;
      default:
        return false;
    }
  }

  /// Sets expense category to taxed or not.
  bool get isTaxedExpense {
    switch (this) {
      case Category.foodExpense:
      case Category.entertainmentExpense:
        return true;
      default:
        return false;
    }
  }
}