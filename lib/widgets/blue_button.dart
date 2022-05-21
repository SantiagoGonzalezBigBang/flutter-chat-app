import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {

  const BlueButton({
    Key? key, 
    required this.text,
    this.onPressed, 
  }) : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.blue,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(onPressed == null ? 1.0 : 2.0),
          shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder())
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55.0,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0
              ),
            ),
          ),
        )
      ),
    );
  }

}