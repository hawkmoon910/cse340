import 'package:flutter/material.dart';

/// Provider for a tax rate. Includes a method to update the current tax
/// rate stored and a field to get if the provider has a tax rate.
class TaxProvider extends ChangeNotifier {
  double taxRate = 0.0; // Should be a percentage from 0.0 to 1.0
  bool hasTaxRate = false;

  /// Update the stored tax for the tax provider. Updates hasTaxRate to true.
  /// Notifies listeners to changes.
  /// Parameters:
  ///   newTaxRate - the new tax rate to update the provider to
  updateTax(double newTaxRate){
    taxRate = newTaxRate;
    hasTaxRate = true;
    notifyListeners();
  }
}