import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
            child: Icon(Icons.music_note,
                size: 40, color: Theme.of(context).colorScheme.inversePrimary),
          )),
          //home button
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () {
                //pop drawer
                Navigator.pop(context);
              },
            ),
          ),

          //settings
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0),
            child: ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('S E T T I N G S'),
              leading: const Icon(Icons.settings),
              onTap: () {
                //pop drawer
                Navigator.pop(context);
                //navigate to settings
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
