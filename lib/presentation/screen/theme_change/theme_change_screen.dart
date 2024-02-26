import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangeScreen extends ConsumerWidget {
  static const name = 'theme_screen';
  const ThemeChangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Change'),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(isDarkModeProvider.notifier).update((state) => !state);
              },
              icon: Icon(isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined))
        ],
      ),
      body: const _ThemeChangeView(),
    );
  }
}

class _ThemeChangeView extends ConsumerWidget {
  const _ThemeChangeView();

  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colors = ref.read(colorListProvider);
    final int seletedColor = ref.watch(selectedColorProvider);

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];
        return RadioListTile(
          title: Text(
            'Este color',
            style: TextStyle(color: color),
          ),
          subtitle: Text('${color.value}'),
          //* Cambiar el color del boton del buler
          activeColor: color,
          value: index,
          groupValue: seletedColor,
          onChanged: (value) {
            //* Notificar el cambio
            ref.read(selectedColorProvider.notifier).state = index;
          },
        );
      },
    );
  }
}
