import 'package:flutter/material.dart';
import 'package:practice_calculator/provider/main_text_provider.dart';
import 'package:provider/provider.dart';

import '../../object/btn_values.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key,required this.value});
  final String value;

  //tap buttons
  _onBtnTap(value, context) {
    if (value == Btn.del) {
      Provider.of<MainTextProvider>(context, listen: false).delete();
      return;
    }
    if (value == Btn.clr) {
      Provider.of<MainTextProvider>(context, listen: false).clearAll();
      return;
    }
    if (value == Btn.per) {
      Provider.of<MainTextProvider>(context, listen: false).convertToPercentage();
      return;
    }
    if (value == Btn.calculate) {
      Provider.of<MainTextProvider>(context, listen: false).calculate();
      return;
    }
    Provider.of<MainTextProvider>(context, listen: false).appendValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Material(
        color: Btn.getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.white24)),
        child: InkWell(
          onTap: () => _onBtnTap(value, context),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

}


