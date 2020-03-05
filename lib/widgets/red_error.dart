import 'package:flutter/material.dart';

class RedError extends StatelessWidget {
  final Error error;
  const RedError(this.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
