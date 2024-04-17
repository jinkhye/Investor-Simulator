import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';
import 'package:investor_simulator/provider/game_provider.dart';
import 'package:investor_simulator/provider/portfolio_provider.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

void openBuyDialog(BuildContext context, dynamic stock, String type) {
  showDialog(
    context: context,
    builder: (context) => BuyDialog(stock: stock, type: type),
  );
}

// ignore: must_be_immutable
class BuyDialog extends StatefulWidget {
  final dynamic stock;
  String type = '';

  BuyDialog({
    super.key,
    required this.stock,
    required this.type,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BuyDialogState createState() => _BuyDialogState();
}

class _BuyDialogState extends State<BuyDialog> {
  final textController = TextEditingController();
  double totalPrice = 0;
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    final portfolio = Provider.of<PortfolioProvider>(context, listen: false);
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
                'Price: \$${widget.stock.regularMarketPrice?.toStringAsFixed(2)}',
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
                  labelText: 'QUANTITY',
                  labelStyle: const TextStyle(
                    letterSpacing: 1,
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
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              confirmBuyButton(portfolio, amount),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal(int quantity) {
    return double.parse(
        (widget.stock.regularMarketPrice! * quantity).toStringAsFixed(2));
  }

  Widget confirmBuyButton(PortfolioProvider portfolioProvider, int quantity) {
    final provider = Provider.of<GameProvider>(context, listen: false);
    double balance = provider.money;
    return ElevatedButton(
      onPressed: () {
        if (quantity > 0 && totalPrice <= balance) {
          switch (widget.type) {
            case 'stock':
              portfolioProvider.addStockInvestment(widget.stock, quantity);
              break;
            case 'etf':
              portfolioProvider.addETFInvestment(widget.stock, quantity);
              break;
            case 'forex':
              portfolioProvider.addForexInvestment(widget.stock, quantity);
              break;
            case 'crypto':
              portfolioProvider.addCryptoInvestment(widget.stock, quantity);
              break;
          }
          provider.subtractMoney(totalPrice);
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
