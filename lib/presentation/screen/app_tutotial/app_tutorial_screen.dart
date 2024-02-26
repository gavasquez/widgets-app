import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
      'Busca la comida',
      'Reprehenderit nisi ut non labore cillum ipsum et pariatur aliqua laborum adipisicing mollit.',
      'assets/images/1.png'),
  SlideInfo(
      'Entrega rapida',
      'Aliquip proident excepteur nisi enim Lorem magna nisi proident est adipisicing ipsum culpa sunt dolore.',
      'assets/images/2.png'),
  SlideInfo(
      'Disfruta la comida',
      'Excepteur laboris aliqua esse magna magna quis pariatur consequat.',
      'assets/images/3.png'),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  final PageController pageViewController = PageController();
  bool enReached = false;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;
      if (!enReached && page >= (slides.length - 1.5)) {
        setState(() {
          enReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            //* Hacer el efecto de ios
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                    title: slideData.title,
                    caption: slideData.caption,
                    imageUrl: slideData.imageUrl))
                .toList(),
          ),
          Positioned(
              top: 30,
              right: 20,
              child: TextButton(
                child: const Text('Salir'),
                onPressed: () {
                  context.pop();
                },
              )),
          enReached
              ? Positioned(
                  bottom: 30,
                  right: 30,
                  //* FadeInRight animaciones: animate_do
                  child: FadeInRight(
                    //* que se mueva 15 posiciob
                    from: 15,
                    //* que se demore un segundo
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Comenzar')),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;
  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          //* Alinear de forma vertical
          mainAxisAlignment: MainAxisAlignment.center,
          //* Alinear de forma horizontal
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              caption,
              style: captionStyle,
            )
          ],
        ),
      ),
    );
  }
}
