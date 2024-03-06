import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 12),
      child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.amber)),
    );
  }
}
