import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_providers.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int clickCounter = ref.watch(counterProvider);
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
              onPressed: () {
                //* Dentro de los metodos se utiliza el read no el watch
                ref.read(isDarkModeProvider.notifier).update((state) => !state);
              },
              icon: Icon(isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined))
        ],
      ),
      body: Center(
        child: Text(
          'Valor: $clickCounter',
          style: const TextStyle(fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //* Segunda alternativa
            /* ref.read(counterProvider.notifier).update((state) => state+1); */
            ref.read(counterProvider.notifier).state++;
          },
          child: const Icon(Icons.add)),
    );
  }
}
