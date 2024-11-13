import 'package:flutter/material.dart';

class BuyNowScreen extends StatelessWidget {
  const BuyNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buy Now Page",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text("Buy now page..."),
      ),
    );
  }
}
