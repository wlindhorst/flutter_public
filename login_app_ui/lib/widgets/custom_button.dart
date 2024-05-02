import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width, height;
  final bool isPrimary;
  final Function onPressed;
  final String text;

  const CustomButton(
      {super.key,
      required this.width,
      required this.height,
      required this.isPrimary,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color:
              isPrimary ? Theme.of(context).primaryColor : Colors.transparent,
          boxShadow: isPrimary
              ? const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isPrimary ? Colors.transparent : Theme.of(context).primaryColor,
          ),
        ),
        child: MaterialButton(
          onPressed: () => onPressed(),
          child: Text(text,
              style: TextStyle(
                  color: isPrimary
                      ? Colors.white
                      : Theme.of(context).primaryColor)),
        ));
  }
}
