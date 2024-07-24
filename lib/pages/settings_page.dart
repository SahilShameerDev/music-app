import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // dark mode
            const Text("Dark mode", style: TextStyle(fontWeight: FontWeight.bold)),
            //switch
            CupertinoSwitch(
                value:  Provider.of<ThemeProvider>(context, listen: false).isDarkMode(),
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme()),
          ],
        ),
      ),
    );
  }
}
