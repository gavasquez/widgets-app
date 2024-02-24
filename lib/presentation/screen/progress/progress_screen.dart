
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = 'tutorial_screen';
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicator'),
      ),
      body: const _Porgressview(),
    );
  }
}

class _Porgressview extends StatelessWidget {
  const _Porgressview();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox( height: 30,),
          Text('Circular Progress Indicator'),
          CircularProgressIndicator( strokeWidth: 2, backgroundColor: Colors.black26,),
          SizedBox(height: 20,),
          Text('Circular y Linear indicator controlado'),
          SizedBox(height: 10,),
          _ControllerPogressIndicator()
        ],
      ),
    );
  }
}

class _ControllerPogressIndicator extends StatelessWidget {
  const _ControllerPogressIndicator();

  @override
  Widget build(BuildContext context) {
    //* Emitir valores
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 300), (value){
        return (value *2)/100; //0.0, 1.0
        //* takeWhile se pare cuando el valor sea menor a 100
      }).takeWhile((value) => value<100),
      builder: (context, snapshot) {
        final progressValue = snapshot.data ?? 0;
        return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(value: progressValue,strokeWidth: 2, backgroundColor: Colors.black12,),
            const SizedBox(width: 20,),
            //* Expanded toma todo el espacio que el padre te esta dando
            Expanded(child: LinearProgressIndicator(value: progressValue,))
          ],
        ),
      );
      },
    );
  }
}