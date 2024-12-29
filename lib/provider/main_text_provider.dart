import 'dart:io';

import 'package:flutter/material.dart';

import '../object/btn_values.dart';

class MainTextProvider extends ChangeNotifier {
  String numberOne = '';
  String numberTwo = '';
  String operand = '';
  String a = '';
  String b = '';
  String c = '';
  String d = '';

  //Delete one text
  void delete() {
    if (numberTwo.isNotEmpty) {
      numberTwo = numberTwo.substring(0, numberTwo.length - 1);
      if (!numberTwo.contains(Btn.add) && !numberTwo.contains(Btn.subtract)) {
        c = '';
        d = '';
      }
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (numberOne.isNotEmpty) {
      numberOne = numberOne.substring(0, numberOne.length - 1);
      if (!numberOne.contains(Btn.add) && !numberOne.contains(Btn.subtract)) {
        a = '';
        b = '';
      }
    }
    notifyListeners();
  }

  // Clear All Text
  void clearAll() {
    numberOne = "";
    numberTwo = "";
    operand = "";
    a = '';
    b = '';
    c = '';
    d = '';
    notifyListeners();
  }

  //Convert To Percentage %
  void convertToPercentage() {
    if (numberOne.isNotEmpty && operand.isNotEmpty && numberTwo.isNotEmpty) {
      calculate();
    }
    if (operand.isNotEmpty) {
      // cannot be converted
      return;
    }
    final number = double.parse(numberOne);
    numberOne = "${(number / 100)}";
    numberTwo = "";
    operand = "";
    notifyListeners();
  }

//Calculate
  void calculate() {
    if (numberOne.isEmpty) return;
    if (numberTwo.isEmpty) return;
    if (operand.isEmpty) return;
    if (numberTwo == Btn.add || numberTwo == Btn.subtract) return;
    final double num1 = double.parse(numberOne);
    final double num2 = double.parse(numberTwo);

    var result = 0.0;

    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
    }
    numberOne = "$result";

    if (numberOne.endsWith(".0")) {
      numberOne = numberOne.substring(0, numberOne.length - 2);
    }
    numberTwo = "";
    operand = "";
    a = '';
    b = '';
    c = '';
    d = '';
    notifyListeners();
  }

  // append value to text
  void appendValue(value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && numberTwo.isNotEmpty) {
        calculate();
        operand = value;
        return;
      }
      if (([Btn.add, Btn.subtract].contains(value))) {
        if (numberOne == value) return;
        if ((numberOne.isEmpty || numberOne == '0')) {
          numberOne = value;
          a = '(';
          b = ')';
          notifyListeners();
          return;
        }
      }
      if (numberOne.isNotEmpty &&
          operand.isNotEmpty &&
          ([Btn.add, Btn.subtract].contains(value))) {
        if (numberTwo == value) return;

        if ((numberTwo.isEmpty || numberTwo == '0')) {
          numberTwo = value;
          c = '(';
          d = ')';
          notifyListeners();
          return;
        }
      }
      if (numberOne == Btn.add || numberOne == Btn.subtract) return;
      operand = value;
    } else if (numberOne.isEmpty || operand.isEmpty) {
      if (numberOne == "0" && value == Btn.n0) {
        numberOne = "0";
        notifyListeners();
        return;
      }
      if (value == Btn.dot && numberOne.contains(Btn.dot)) return;
      if (value == Btn.dot && (numberOne.isEmpty || numberOne == Btn.n0)) {
        numberOne = "0.";
        notifyListeners();
        return;
      }
      if ([
            Btn.n1,
            Btn.n2,
            Btn.n3,
            Btn.n4,
            Btn.n5,
            Btn.n6,
            Btn.n7,
            Btn.n8,
            Btn.n9,
          ].contains(value) &&
          numberOne == '0') {
        numberOne = value;
        notifyListeners();
        return;
      }

      numberOne += value;
    } else if (numberTwo.isEmpty || operand.isNotEmpty) {
      if (numberTwo == "0" && value == Btn.n0) {
        numberTwo = "0";
        notifyListeners();
        return;
      }
      if (value == Btn.dot && numberTwo.contains(Btn.dot)) return;
      if (value == Btn.dot && (numberTwo.isEmpty || numberTwo == Btn.n0)) {
        numberTwo = '0.';
        notifyListeners();
        return;
      }

      if ([
        Btn.n1,
        Btn.n2,
        Btn.n3,
        Btn.n4,
        Btn.n5,
        Btn.n6,
        Btn.n7,
        Btn.n8,
        Btn.n9,
      ].contains(value) &&
          numberTwo == '0') {
        numberTwo = value;
        notifyListeners();
        return;
      }

      numberTwo += value;
    }

    notifyListeners();
  }
}
