import 'package:fuodz/constants/app_strings.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

extension NumberParsing on dynamic {
  //
  String currencyFormat() {

    final uiConfig = AppStrings.uiConfig;
    if (uiConfig != null && uiConfig["currency"] != null) {
      final thousandSeparator = uiConfig["currency"]["format"] ?? ",";
      final decimalSeparator = uiConfig["currency"]["decimal_format"] ?? ".";
      final decimals = uiConfig["currency"]["decimals"];
      final currencylOCATION = uiConfig["currency"]["location"] ?? 'left';
      final decimalsValue = "".padLeft(decimals.toString().toInt(), "0");

      NumberFormat oCcy;
      if (decimals.toString().toInt() > 0) {
        oCcy = new NumberFormat(
          "#${thousandSeparator}##0${decimalSeparator}${decimalsValue}",
          "en_US",
        );
      } else {
        oCcy = new NumberFormat("#${thousandSeparator}##0", "en_US");
      }

      //
      final values = this.toString().split(" ").join("").split(AppStrings.currencySymbol);
      final formattedAmount = oCcy.format(values[1].toDouble()).toString();
      //
      if (currencylOCATION.toLowerCase() == "left") {
        return "${AppStrings.currencySymbol} $formattedAmount";
      } else {
        return "$formattedAmount ${AppStrings.currencySymbol}";
      }
    } else {
      return this.toString();
    }
  }

  //
  String currencyValueFormat() {
    final uiConfig = AppStrings.uiConfig;
    if (uiConfig != null && uiConfig["currency"] != null) {
      final thousandSeparator = uiConfig["currency"]["format"] ?? ",";
      final decimalSeparator = uiConfig["currency"]["decimal_format"] ?? ".";
      final decimals = uiConfig["currency"]["decimals"];
      final decimalsValue = "".padLeft(decimals.toString().toInt(), "0");

      NumberFormat oCcy;
      if (decimals.toString().toInt() > 0) {
        oCcy = new NumberFormat(
          "#${thousandSeparator}##0${decimalSeparator}${decimalsValue}",
          "en_US",
        );
      } else {
        oCcy = new NumberFormat("#${thousandSeparator}##0", "en_US");
      }

      //
      final values = this.toString().split(" ").join("");
      final formattedAmount = oCcy.format(values.toDouble()).toString();
      return formattedAmount;
    } else {
      return this.toString();
    }
  }
}
