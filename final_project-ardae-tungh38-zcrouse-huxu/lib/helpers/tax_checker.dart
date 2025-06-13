import 'package:finance_tracker/providers/position_provider.dart';
import 'package:finance_tracker/providers/tax_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

/// Handler object for the Washington State Sales Tax API. Stores a position
/// provider to get the user's current address when checking the api. In the
/// event that the object calls the tax API and gets back a new tax rate it
/// will update the tax provider.
class TaxChecker {
  final TaxProvider taxProvider;
  final PositionProvider positionProvider;
  final taxRate = 0.0;
  Placemark? address; 

  TaxChecker(this.taxProvider, this.positionProvider);

  /// Checks if the tax checker has an address and tax rate, if it does not
  /// have an address it will attempt to get one from the position provider.
  /// If successful it will then attempt to get a tax rate only if there is
  /// currently no tax rate stored (meaning it is 0.0). This is meant to only
  /// call the tax api if absolutely necessary to get new info.
  checkAndUpdateTax() {
    if (_updateAddress() && taxRate == 0.0) {
      _fetchAndUpdateCurrentTax();
    }
  }

  /// Updates location of where to check the weather at.
  bool _updateAddress() {
    if (positionProvider.addressIsKnown) {
      address = positionProvider.address;
      print('TaxChecker: Updated address');
      return true;
    } else {
      print('TaxChecker: Could not update address');
      return false;
    }
  }

  /// Updates the address and recalls the tax API to get any new information 
  /// about the tax rate.
  updateTaxes() async {
    _updateAddress();
    _fetchAndUpdateCurrentTax();
  }

  /// Calls the tax API with the current address and updates the tax rate 
  /// information to the new tax rate given back.
  _fetchAndUpdateCurrentTax() async {
    print('TaxChecker: Attempting to fetch tax data');
    if (address != null) {
      print('TaxChecker: Address Found');
      var client = http.Client();
      try {
        print('TaxChecker: Calling API for tax rate');
        final response = await client.get(
            Uri.parse('http://webgis.dor.wa.gov/webapi/AddressRates.aspx?output=xml&addr=${address!.street}&city=${address!.locality}&zip=${address!.postalCode}')
        );
        final parsedResponse = XmlDocument.parse(response.body);
        double taxRate = double.parse(parsedResponse.getElement('response')?.getAttribute('rate') ?? '0.0');
        if (taxRate != 0.0) {
          print('TaxChecker: Acquired tax rate');
          taxProvider.updateTax(taxRate);
          print('TaxChecker: New tax rate: $taxRate');
        }
      } catch (e) {
        print(e.toString());
      } finally {
        client.close();
      }
    } else {
      print("TaxChecker: No address provided, can't find tax rate");
    }
  }
}
