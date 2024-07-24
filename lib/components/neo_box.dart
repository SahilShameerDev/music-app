import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class NeoBox extends StatelessWidget {
  final Widget? child;

  const NeoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    //is dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode();
    
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
          //darker shadow on right
          BoxShadow(color: isDarkMode ? Colors.black : Colors.grey.shade500, blurRadius: 15, offset: const Offset(4,4)),
          //lighter shadow on left
          BoxShadow(color: isDarkMode ? Colors.grey.shade800 : Colors.white, blurRadius: 15, offset: Offset(-4,-4)),
        ]),
        padding: const EdgeInsets.all(20),
        child: child,
        );
  }
}
