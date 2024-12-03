import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function function;
  final Color textColor;
  final Color colorButton;
  final double raduis;
  final double widthButton;
  final bool loading;
  const CustomButtonWidget(
      {super.key,
      required this.text,
      required this.function,
      this.textColor = Colors.white,
      this.colorButton = Colors.brown,
      this.raduis = 10,
      this.widthButton = double.infinity,
      this.loading = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: widthButton,
      decoration: BoxDecoration(
          color: colorButton, borderRadius: BorderRadius.circular(raduis)),
      child: MaterialButton(
        onPressed: () => function(),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white))
            : Text(
                text,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
      ),
    );
  }
}
