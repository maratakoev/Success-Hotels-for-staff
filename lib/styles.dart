import 'package:flutter/material.dart';

const TextStyle commonTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle dataClockTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(255, 255, 255, 1));

const firstButton = ButtonStyle(
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)))));

const TextStyle buttonTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontFamily: 'Philosopher',
    fontWeight: FontWeight.w700);

const BoxDecoration commonButtonStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(83, 232, 139, 1),
      Color.fromRGBO(21, 190, 119, 1),
    ],
  ),
);

BoxDecoration logOutButtonStyle = BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: const BorderRadius.all(Radius.circular(25)),
    color: Colors.white);

const TextStyle dropDownButtonText = TextStyle(
  fontFamily: 'Philosopher',
  fontSize: 14,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w400,
  color: Color.fromRGBO(59, 59, 59, 1),
);

const TextStyle newOrdersTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle navBarHeader = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle ordersHeaderText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle ordersTime = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle clientsNavBar = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle scannerTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle logOutButtonTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));

const TextStyle orderStatusTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(69, 69, 69, 1));

const TextStyle orderStatusDoneTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(71, 179, 110, 1));

const TextStyle orderCanceledTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(69, 69, 69, 1));

const TextStyle staffAppOrderButtonTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Philosopher',
    color: Colors.white);

const BoxDecoration staffAppOrderButtonStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(255, 123, 147, 1),
      Color.fromRGBO(250, 29, 29, 1),
    ],
  ),
);

BoxDecoration staffAppDialogWindowStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.2), // Цвет тени
      spreadRadius: 0.02, // Радиус распространения
      blurRadius: 10, // Размытие
      offset: const Offset(0, 3), // Смещение по оси X и Y
    ),
  ],
);

const TextStyle staffAppDialogWindowTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Philosopher',
    color: Color.fromRGBO(59, 59, 59, 1));
