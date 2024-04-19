import 'package:flutter/material.dart';
import 'package:investor_simulator/constant/color.dart';

class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc({
    super.key,
    required this.text,
    this.skip = "Skip",
    this.next = "Next",
    this.onSkip,
    this.onNext,
  });

  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;

  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}

class _CoachmarkDescState extends State<CoachmarkDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
      decoration: BoxDecoration(
        color: darkPurple,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: white,
          width: 3,
        ),
      ),
      child: Column(
        children: [
          Text(widget.text,
              style: const TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: yellow,
              )),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: widget.onSkip,
                child: const SizedBox(
                  width: 50,
                  height: 30,
                  child: Center(
                    child: Text(
                      'SKIP',
                      style: TextStyle(fontSize: 20, color: white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: widget.onNext,
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
