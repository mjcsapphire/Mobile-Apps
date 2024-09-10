import 'package:flutter/material.dart';

import '../theme/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onTap;

  const MyButton({Key? key, required this.text, this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.white),),
          
          const SizedBox(width: 10,),

          icon,
        ],
      ),
    )
    );
  }
}
