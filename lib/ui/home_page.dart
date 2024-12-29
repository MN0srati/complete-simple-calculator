import 'package:flutter/material.dart';
import 'package:practice_calculator/provider/main_text_provider.dart';
import 'package:practice_calculator/object/btn_values.dart';
import 'package:practice_calculator/ui/helper/build_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(16),
                    child: Consumer<MainTextProvider>(
                      builder: (context, data, child) {

                        return Text(
                          '${data.numberOne}${data.operand}${data.numberTwo}'
                                  .isEmpty
                              ? "0"
                              : '${data.a}${data.numberOne}${data.b}${data.operand}${data.c}${data.numberTwo}${data.d}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 46,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        );
                      },
                    )),
              ),
            ),
            Wrap(
              children: Btn.btnValues
                  .map((value) => SizedBox(
                        width: value == Btn.n0
                            ? screenSize.width / 2
                            : screenSize.width / 4,
                        height: screenSize.width / 5,
                        child: BuildButton(value: value),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
