import 'package:flutter/material.dart';
import 'package:vaccine_app_project/size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Center formErrorText({required String error}) {
    return Center(
      child: Text(error,
        style: TextStyle(
            color: Colors.redAccent,
            fontSize: getProportionateScreenWidth(40)
        ),
      )
    );
  }
}