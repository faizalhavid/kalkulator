import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator/theme.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _input = '';
  String _result = '0';
  bool isclear = false;
  bool isdoubletap = false;
  bool issingle = true;

  void buttonPressed(String buttonText) {
    try {
      setState(() {
        if (buttonText == "C") {
          _result = "0";
          _input = "";
        } else if (buttonText == "+" ||
            buttonText == "-" ||
            buttonText == "x" ||
            buttonText == "/") {
          issingle = false;
          _input += " " + buttonText + " ";
        } else if (buttonText == "+/-") {
          if (issingle) {
            double currentInput = double.parse(_input);
            currentInput = -1 * currentInput;
            _input = currentInput
                .toStringAsFixed(0)
                .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
          }
        } else if (buttonText == "%") {
          double operand = double.parse(_input);
          double result = operand / 100;
          _result = result.toStringAsFixed(2);
        } else if (buttonText == "=") {
          List<String> inputList = _input.split(" ");
          double result = double.parse(inputList[0]);
          for (int i = 1; i < inputList.length; i += 2) {
            //operator index ganjil
            String operator = inputList[i];
            double operand = double.parse(inputList[i + 1]);
            if (operator == "+") {
              result += operand;
            } else if (operator == "-") {
              result -= operand;
            } else if (operator == "x") {
              result *= operand;
            } else if (operator == "/") {
              result /= operand;
            }
          }

          _result = result.toStringAsFixed(2);
          isclear = true;
        } else {
          if (isclear == true) {
            _input = '';
            isclear = false;
          }
          _input += buttonText;
        }

        _result = double.parse(_result).toStringAsFixed(2);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 1,
        backgroundColor: Colors.grey,
        content: Text("Format yang dimasukan salah",
            style: GoogleFonts.roboto(fontSize: 12, color: Colors.white)),
      ));
    }
  }

  void pop() {
    setState(() {
      if (_input.isNotEmpty) {
        if (_input.contains(" ")) {
          _input = _input.substring(
              0, _input.length - 3); // menghapus satu karakter terakhir
        } else {
          _input = _input.substring(0, _input.length - 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final field = TextFormField(
    //   style: GoogleFonts.roboto(fontSize: 27, color: cyan),
    //   controller: _result,
    //   autofocus: false,
    //   // keyboardType: TextInputType.number,
    //   textDirection: TextDirection.rtl,
    //   decoration: InputDecoration(border: InputBorder.none),
    // );

    return Scaffold(
      backgroundColor: black,
      body: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.only(top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            _input,
            style: GoogleFonts.roboto(fontSize: 27, color: cyan),
          ),
          Text(
            _result,
            style: GoogleFonts.roboto(
              fontSize: 17,
            ),
          ),
          Text(
            isclear.toString(),
            style: GoogleFonts.roboto(
              fontSize: 17,
            ),
          ),
          Spacer(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    splashRadius: 25,
                    onPressed: () {},
                    icon: Icon(Icons.access_time)),
                IconButton(
                    splashRadius: 25,
                    onPressed: () {},
                    icon: Icon(Icons.rectangle_outlined)),
                IconButton(
                    splashRadius: 25,
                    onPressed: () {},
                    icon: Icon(Icons.calculate_outlined)),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        pop();
                      },
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: red,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: grey,
              thickness: 2,
              height: 2,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button('C', warna: red, onTap: () => buttonPressed('C')),
              Button('()', warna: amber),
              Button('%', warna: amber, onTap: () => buttonPressed('%')),
              Button(
                '/',
                warna: amber,
                onTap: () => buttonPressed('/'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button('7', onTap: () => buttonPressed('7')),
              Button('8', onTap: () => buttonPressed('8')),
              Button('9', onTap: () => buttonPressed('9')),
              Button('x', warna: amber, onTap: () => buttonPressed('x')),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button('4', onTap: () => buttonPressed('4')),
              Button('5', onTap: () => buttonPressed('5')),
              Button('6', onTap: () => buttonPressed('6')),
              Button('-', warna: amber, onTap: () => buttonPressed('-')),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button('1', onTap: () => buttonPressed('1')),
              Button('2', onTap: () => buttonPressed('2')),
              Button('3', onTap: () => buttonPressed('3')),
              Button('+', warna: amber, onTap: () => buttonPressed('+')),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button('+/-', onTap: () => buttonPressed('+/-')),
              Button('0', onTap: () => buttonPressed('0')),
              Button(',', onTap: () => buttonPressed('.')),
              Button('=',
                  warna: black,
                  warna_bg: amber,
                  onTap: () => buttonPressed('=')),
            ],
          ),
        ]),
      ),
    );
  }
}

ElevatedButton Button(String angka,
    {Color? warna, Color? warna_bg, void Function()? onTap}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      backgroundColor: warna_bg ?? grey,
      padding: const EdgeInsets.all(10),
      minimumSize: const Size(56, 56),
      textStyle:
          GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.normal),
      foregroundColor: warna ?? cyan, // mengatur ukuran minimal button
    ),
    child: SizedBox(
      width: 56,
      height: 56,
      child: Center(child: Text(angka)),
    ),
  );
}
