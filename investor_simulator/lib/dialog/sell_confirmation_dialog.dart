import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:stroke_text/stroke_text.dart';

void openSellConfirmationDialog(
  BuildContext context,
  String name,
  int amount,
  double price,
) {
  showDialog(
    context: context,
    builder: (context) =>
        SellConfirmationDialog(name: name, amount: amount, price: price),
  );
}

// ignore: must_be_immutable
class SellConfirmationDialog extends StatefulWidget {
  final String name;
  final int amount;
  final double price;

  const SellConfirmationDialog({
    super.key,
    required this.name,
    required this.amount,
    required this.price,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SellConfirmationDialogState createState() => _SellConfirmationDialogState();
}

class _SellConfirmationDialogState extends State<SellConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(10), // Adjust padding as needed
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: darkPurple,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  letterSpacing: 0,
                  wordSpacing: 0,
                  fontSize: 20,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  const TextSpan(
                    text: 'You have',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const TextSpan(
                    text: ' sold ',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800, color: red),
                  ),
                  TextSpan(
                    text: widget.amount.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: purple),
                  ),
                  const TextSpan(
                    text: ' unit(s) of ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text: widget.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: purple),
                  ),
                  const TextSpan(
                    text: ' at ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text: '\$${widget.price.toStringAsFixed(2)}.',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800, color: red),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            confirmBuyButton(),
          ],
        ),
      ),
    );
  }

  Widget confirmBuyButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: darkRed,
            width: 4,
          ),
        ),
        child: const StrokeText(
          text: 'CLOSE',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
