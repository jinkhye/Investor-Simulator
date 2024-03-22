import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

void openBuyDialog(
    BuildContext context, stockName, stockPrice, image, percentage) {
  showDialog(
    context: context,
    builder: (context) => BuyDialog(
        stockName: stockName,
        stockPrice: stockPrice,
        image: image,
        percentage: percentage),
  );
}

class BuyDialog extends StatefulWidget {
  final String stockName;
  final double stockPrice;
  final String image;
  final String percentage;

  const BuyDialog(
      {super.key,
      required this.stockName,
      required this.stockPrice,
      required this.image,
      required this.percentage});

  @override
  // ignore: library_private_types_in_public_api
  _BuyDialogState createState() => _BuyDialogState();
}

class _BuyDialogState extends State<BuyDialog> {
  final textController = TextEditingController();
  double totalPrice = 0; // Move totalPrice declaration here
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    final portfolio = Provider.of<GameProvider>(context, listen: false);
    return Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(10), // Adjust padding as needed
        width: 200,
        height: 240,
        decoration: BoxDecoration(
          border: Border.all(
            color: darkPurple,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              purchaseText(),
              Text(
                'Price: \$${widget.stockPrice}',
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    color: darkPurple,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      textController.clear();
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: darkPurple,
                      size: 25,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: darkPurple,
                      width: 4,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: darkPurple,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {
                    final quantity = int.tryParse(textController.text) ?? 0;
                    amount = quantity;
                    totalPrice = calculateTotal(quantity);
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Total: \$$totalPrice',
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              confirmBuyButton(
                  portfolio, amount, totalPrice, widget.percentage),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal(int quantity) {
    return double.parse((widget.stockPrice * quantity).toStringAsFixed(2));
  }

  Widget confirmBuyButton(
      GameProvider portfolio, quantity, totalPrice, percentage) {
    return ElevatedButton(
      onPressed: () {
        if (quantity > 0) {
          portfolio.subtractMoney(totalPrice);
          portfolio.insertPortfolio(widget.stockName, widget.image,
              widget.stockPrice, quantity, totalPrice, percentage);
          Navigator.pop(context); // Close the dialog after buying
        } else {
          // Show error or handle invalid quantity
        }
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
          color: lightGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: green,
            width: 4,
          ),
        ),
        child: const StrokeText(
          text: 'CONFIRM',
          textStyle: TextStyle(fontSize: 18, color: white),
          strokeColor: black,
          strokeWidth: 4,
        ),
      ),
    );
  }

  Widget purchaseText() {
    return const Center(
      child: StrokeText(
        text: "PURCHASE",
        textStyle: TextStyle(fontSize: 30, color: yellow),
        strokeColor: darkPurple,
        strokeWidth: 7,
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
