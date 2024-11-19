import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;

  const ErrorMessage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              message!,
              style: TextStyle(color: Colors.red),
            ),
          )
        : SizedBox.shrink();
  }
}
