import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: _HomeView(),
      drawer: SideManu(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: MenuItem.appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = MenuItem.appMenuItems[index];
        return _CustomListTitle(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTitle extends StatelessWidget {
  final MenuItem menuItem;

  const _CustomListTitle({
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      //* widget antes del widget
      leading: Icon(
        menuItem.icon,
        color: colors.primary,
      ),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      //* widget que vamos a ponerlo al final
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: colors.primary,
      ),
      //* Evento al dar click
      onTap: () {
        context.push(menuItem.link);
        //* Navegar por nombre
        //context.pushNamed(CardScreen.name);
        //* Navegar a otra pantalla otra forma
        // Navigator.of(context).push(
        //  MaterialPageRoute(
        //    builder: (context) => const ButtonsScreen(),
        //  ),
        //);
        //Navigator.pushNamed(context, menuItem.link);
      },
    );
  }
}
