import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});

  static const appMenuItems = <MenuItem>[
    MenuItem(
        title: 'Botones',
        subTitle: 'Varios botones en Flutter',
        link: '/buttons',
        icon: Icons.smart_button_outlined),
    MenuItem(
        title: 'Tarjetas',
        subTitle: 'Un contenedor estilizado',
        link: '/cards',
        icon: Icons.credit_card),
    MenuItem(
        title: 'ProgressIndicators',
        subTitle: 'Generales y controlados',
        link: '/progress',
        icon: Icons.refresh_rounded),
    MenuItem(
        title: 'Snackbars y dialogos',
        subTitle: 'Indicadores en pantalla',
        link: '/snackbars',
        icon: Icons.info_outline),
    MenuItem(
        title: 'Animated Container',
        subTitle: 'Stafull widget animado',
        link: '/animated',
        icon: Icons.check_box_outlined),
    MenuItem(
        title: 'Ui Controls + titles',
        subTitle: 'Una serie de controles de Flutter',
        link: '/ui-controlls',
        icon: Icons.car_rental_outlined),
    MenuItem(
        title: 'Introducción a la aplicación',
        subTitle: 'Pequeño tutorial de la aplicación',
        link: '/tutotial',
        icon: Icons.accessibility_rounded),
  ];
}
