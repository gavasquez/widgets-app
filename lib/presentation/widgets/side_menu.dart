import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideManu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideManu({super.key, required this.scaffoldKey});

  @override
  State<SideManu> createState() => _SideManuState();
}

class _SideManuState extends State<SideManu> {
  int navdrawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
        selectedIndex: navdrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navdrawerIndex = value;
          });
          final menuItem = MenuItem.appMenuItems[value];
          context.push(menuItem.link);
          //* Cerramos el drawer
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Main'),
          ),
          ...MenuItem.appMenuItems
              //* Sacamos de la posicion 0 a la 3
              .sublist(0, 3)
              .map((item) => NavigationDrawerDestination(
                    icon: Icon(item.icon),
                    label: Text(item.title),
                  )),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('More Options'),
          ),
          ...MenuItem.appMenuItems
              //* Sacamos 3 en adelante
              .sublist(3)
              .map((item) => NavigationDrawerDestination(
                    icon: Icon(item.icon),
                    label: Text(item.title),
                  )),
        ]);
  }
}
