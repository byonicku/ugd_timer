import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class BottomLayer extends ConsumerWidget {
  const BottomLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(alignment: Alignment.center,
        children: [
          Lottie.asset(
            'assets/lottie_pattern_bg.json',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.96),
              Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.96),
            ],
          ),
        ),
      ),
    ]);
  }
}
