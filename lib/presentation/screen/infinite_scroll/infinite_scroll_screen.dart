import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';
  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  void addFiveImages() {
    //* obtener el ultimo valor de la lista .last
    final lastId = imagesIds.last;
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastId + e));
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //* Validación antes de llegar a la posicion maxima del scroll
      //* scrollController.position.pixels = obtenemos posicion actual
      //* scrollController.position.maxScrollExtent = obtenemos lo maximo del scroll osea el final
      //* Le sumamos + 500 a la posicion actual y hacemos la condicion
      if (scrollController.position.pixels + 500 >=
          scrollController.position.maxScrollExtent) {
        //* cargar la nueva pagina
        loadNextPage();
      }
    });
  }

  //* Limpiar scrollController
  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false;
    super.dispose();
  }

  Future loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    //* revisar si esta montado el componente / widget
    if (!isMounted) return;
    setState(() {});
    //* Mover Scroll
    moveScrollToBottom();
  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    isLoading = false;
    //* Obtenemos el ultimo id
    final lasId = imagesIds.last;
    //* Borramos todos los elementos de ese listado
    imagesIds.clear();
    imagesIds.add(lasId + 1);
    addFiveImages();
    setState(() {});
  }

  void moveScrollToBottom() {
    if (scrollController.position.pixels + 150 <=
        scrollController.position.maxScrollExtent) return;

    scrollController.animateTo(scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //* MediaQuery.removePadding = remover el padding en la parte arriba removeTop: true
      body: MediaQuery.removePadding(
        removeTop: true,
        removeBottom: true,
        context: context,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: ListView.builder(
            controller: scrollController,
            //* Poner el efecto de IOS cuando se llega al final o al comienzo de la pantalla
            physics: const BouncingScrollPhysics(),
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              //* FadeInImage nos permite cargar imagenes y mientras carga podemos mostrar placeholder
              return FadeInImage(
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                  placeholder:
                      const AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(
                      'https://picsum.photos/id/${imagesIds[index]}/500/300'));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        //* Hacer girar un widget
        child: isLoading
            ? SpinPerfect(
                infinite: true, child: const Icon(Icons.refresh_rounded))
            //* Animacion FadeIn
            : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
    );
  }
}
