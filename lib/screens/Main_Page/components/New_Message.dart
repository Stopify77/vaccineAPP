import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class NewMessage extends StatelessWidget{
  const NewMessage({
    Key? key,
    required this.message,
    required this.press,
    required this.label,
    required this.whatColor,
  }) : super(key: key);

  final String message;
  final String label;
  final GestureTapCallback press;
  final Color whatColor;

  @override
  Widget build(BuildContext context){
    return RichText(
        overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: ' ● ',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.02,
                    color: whatColor,
                  height: 1.2,

                ),
              ),
              TextSpan(
                  text: '$label - ',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02,
                      color: whatColor,
                      height: 1.5
                  ),
                  recognizer: TapGestureRecognizer()..onTap = press
              ),
              TextSpan(
                  text: '$message',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02,
                      color: whatColor,
                    height: 1.5
                  ),
                  recognizer: TapGestureRecognizer()..onTap = press
              ),
            ],
          )
      );
  }
}