import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/loading_provider.dart';
import 'loading_animation.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({
    super.key, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<LoadingProvider>(
          builder: (context, loadingProvider, child) {
            return loadingProvider.isLoading
                ? const LoadingAnimation()
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
