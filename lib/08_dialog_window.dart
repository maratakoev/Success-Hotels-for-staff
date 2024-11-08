// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:hotels_clients_app/03_nav_bar.dart';
import 'package:hotels_clients_app/repository/api_service.dart';
import 'package:intl/intl.dart';
import './styles.dart';

class ServiceDetailPage extends StatefulWidget {
  final int id;
  final int clientRoomId;
  final String serviceName;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? finishedAt;
  final Function onBack; // Метод для возврата к списку

  const ServiceDetailPage({
    super.key,
    required this.id,
    required this.serviceName,
    required this.createdAt,
    this.finishedAt,
    this.acceptedAt,
    required this.clientRoomId,
    required this.onBack,
  });

  Future<void> handleAcceptOrder(BuildContext context) async {
    // Выполняем метод принятия заказа
    try {
      await ApiService().takeOrder(id);
      Navigator.of(context).pop(); // Закрываем окно после выполнения
      onBack(); // Возвращаемся к списку заказов
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при принятии заказа: $e')),
      );
    }
  }

  Future<void> handleDeclineOrder(BuildContext context) async {
    // Выполняем метод отклонения заказа
    try {
      await ApiService().declineOrder(id);
      Navigator.of(context).pop(); // Закрываем окно после выполнения
      onBack(); // Возвращаемся к списку заказов
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при отклонении заказа: $e')),
      );
    }
  }

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Этот метод будет вызываться при нажатии в любом месте экрана
  void _onTapOutside() {
    widget.onBack(); // Возвращаемся к списку
    //  Navigator.of(context).pop(); // Закрываем текущую страницу
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap:
              _onTapOutside, // Не делаем ничего при нажатии внутри контейнера
          child: Container(
            color: const Color.fromARGB(0, 38, 3, 240), // Прозрачный контейнер
            height: 500,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        // Основной контейнер с контентом
        Container(
          decoration: staffAppDialogWindowStyle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: [
                TitleAndLogo(
                  clientRoomId: widget.clientRoomId,
                ),
                const SizedBox(height: 1),
                ServiceNameLine(
                  createdAt: widget.createdAt,
                  serviceName: widget.serviceName,
                ),
                const SizedBox(height: 50),
                RowWithButtons(
                  id: widget.id,
                  onBack: widget.onBack,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // Прозрачный контейнер, который ловит нажатия за пределами основного контента
      ],
    );
  }
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

class ServiceNameLine extends StatefulWidget {
  final String serviceName;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? finishedAt;

  const ServiceNameLine({
    super.key,
    this.finishedAt,
    this.acceptedAt,
    required this.serviceName,
    required this.createdAt,
  });

  @override
  State<ServiceNameLine> createState() => _ServiceNameLineState();
}

class _ServiceNameLineState extends State<ServiceNameLine> {
  @override
  Widget build(BuildContext context) {
    String createdDateFormatted = DateFormat('HH:mm').format(widget.createdAt);
    String acceptedDateFormatted = widget.acceptedAt != null
        ? DateFormat('HH:mm').format(widget.acceptedAt!)
        : ''; // Если null, возвращаем пустую строку
    String finishedDateFormatted = widget.finishedAt != null
        ? DateFormat('HH:mm').format(widget.finishedAt!)
        : ''; // Если null, возвращаем пустую строку

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Добавлено для выравнивания элементов влево

          children: [
            Text(
              capitalize(widget.serviceName),
              style: scannerTextStyle,
            ),
            const SizedBox(height: 5),
            Text(
              createdDateFormatted, // Отображаем отформатированную дату
              style: scannerTextStyle,
            ),
            const SizedBox(height: 5),
            Text(
              acceptedDateFormatted, // Отображаем отформатированную дату
              style: scannerTextStyle,
            ),
            Text(
              finishedDateFormatted, // Отображаем отформатированную дату
              style: scannerTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAndLogo extends StatefulWidget {
  final int clientRoomId; // Добавляем переменную для номера комнаты

  const TitleAndLogo({super.key, required this.clientRoomId});

  @override
  State<TitleAndLogo> createState() => _TitleAndLogoState();
}

class _TitleAndLogoState extends State<TitleAndLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment:
                        Alignment.topCenter, // Центрирует текст по вертикали
                    child: Text(
                      '№ ${widget.clientRoomId}',
                      style: staffAppDialogWindowTitleStyle,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 0, // Размещает изображение справа
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset('assets/images/new.png',
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowWithButtons extends StatefulWidget {
  final int id;
  final Function onBack; // Добавляем onBack

  RowWithButtons({super.key, required this.id, required this.onBack});

  @override
  State<RowWithButtons> createState() => _RowWithButtonsState();
}

class _RowWithButtonsState extends State<RowWithButtons> {
  final ApiService _apiService = ApiService(); // Инициализация ApiService

  // Метод для открытия диалога
  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Округлые углы
          ),
          backgroundColor: Color(0xffeff1f3), // Цвет фона
          title: const Text('Укажите причину',
              textAlign: TextAlign.center, style: scannerTextStyle),
          content: Container(
            width: 300, // Ширина диалога
            height: 50, // Высота диалога
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    hintText: 'Комментарий',
                    fillColor:
                        Color.fromARGB(255, 255, 255, 255), // Задает цвет фона
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(203, 203, 203, 1),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (value) {
                    // Логика обработки текста (если нужно)
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, alignment: Alignment.center),
                onPressed: () async {
                  // Получаем текст из TextField (причина)
                  String reason =
                      "Причина отклонения"; // Замените на реальный текст
                  int id = widget.id;

                  try {
                    // Вызываем метод отклонения заказа с причиной
                    final response = await _apiService.cancelOrder(id, reason);
                    if (response != null) {
                      print('Заказ отклонен');
                      // Здесь можно вызвать onBack или выполнить другие действия
                      widget.onBack(); // Вызываем onBack для возврата назад
                      Navigator.of(context).pop(); // Закрываем диалог
                    } else {
                      print('Ошибка при отклонении заказа');
                    }
                  } catch (e) {
                    print('Ошибка при отправке запроса: $e');
                  } finally {
                    // Сбрасываем флаг после выполнения действия
                  }
                },
                child: Container(
                  width: 325,
                  height: 57,
                  decoration: staffAppOrderButtonStyle,
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Text(
                        'Отклонить',
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 73,
          height: 25,
          decoration: commonButtonStyle,
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero, alignment: Alignment.center),
            onPressed: () async {
              // Вызов метода takeOrder с нужным ID
              int id = widget.id;
              final response = await _apiService.takeOrder(id);
              if (response != null) {
                print('Заказ успешно принят');
                widget.onBack(); // Теперь можно вызвать onBack

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavBar()), // Новый экран
                );
              } else {
                print('Ошибка при принятии заказа');
              }
            },
            child: const Text(
              'Принять',
              style: staffAppOrderButtonTextStyle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 73,
          height: 25,
          decoration: staffAppOrderButtonStyle,
          child: Padding(
            padding: EdgeInsets.zero,
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, alignment: Alignment.center),
              onPressed: _showCancelDialog, // Открытие диалога по нажатию

              child: const Text(
                'Отклонить',
                style: staffAppOrderButtonTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
