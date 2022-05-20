import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key, 
    required this.route, 
    required this.title, 
    required this.subtitle
  }) : super(key: key);

  final String route;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
            fontWeight: FontWeight.w300
          ),
        ),
        const SizedBox(height: 10.0,),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}