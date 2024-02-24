import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';
  const SnackbarScreen({super.key});

  void showCustomSnackba(BuildContext context) {
    //* Ocultamos los snackbar anteriores
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Hola Mundo'),
        action: SnackBarAction(
          label: 'OK!',
          onPressed: () {},
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  //* BuildContext es la información a mi aplicación
  void openDialog(BuildContext context) {
    //* builder quiere decir que es algo que se va a construir en tiempo de ejecución
    showDialog(
      //* Obligamos a que debe seleccionar algunas de las opciones
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(onPressed: () {
            //* Cerrar el dialogo
            context.pop();
          }, child: const Text('Cancelar')),
          FilledButton(onPressed: () {
             //* Cerrar el dialogo
             context.pop();
          }, child: const Text('Aceptar'))
        ],
        title: const Text('Estas Seguro?'),
        content: const Text(
            'Commodo fugiat ex non ut id mollit deserunt id duis magna aute aliquip aute Lorem. Nisi ut aute minim deserunt eiusmod qui anim aliquip occaecat minim culpa. Nostrud qui culpa pariatur non dolore reprehenderit ad duis excepteur minim. Deserunt culpa non occaecat exercitation sunt veniam excepteur laboris esse ullamco dolore. Tempor commodo aliquip velit pariatur deserunt fugiat irure amet reprehenderit aliquip tempor. Aute velit elit voluptate magna sunt dolore sit quis tempor minim sint eiusmod. Cillum eu qui proident laboris labore eiusmod reprehenderit reprehenderit eiusmod aliquip.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar y Dialogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  //* Ver las licencias que usa nuestra aplicación
                  showAboutDialog(context: context, children: [
                    const Text(
                        'Eiusmod est excepteur nisi voluptate aliquip cillum tempor ullamco ad.')
                  ]);
                },
                child: const Text('Licencias Usadas')),
            const SizedBox(
              height: 10,
            ),
            FilledButton.tonal(
                onPressed: () {
                  openDialog(context);
                },
                child: const Text('Mostra dialogo')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showCustomSnackba(context);
        },
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }
}
