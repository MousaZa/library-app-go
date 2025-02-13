import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OfflinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/images/error_404_page.riv',
          fit: BoxFit.fitHeight,
          stateMachines: [
            'State Machine 1',
          ],
          speedMultiplier: 2,
        ),
      ),
    );
  }
}