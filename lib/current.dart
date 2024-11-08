import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './styles.dart';
import './repository/api_service.dart';
import 'models/current.dart';

class CurrentOrders extends StatefulWidget {
  final int? id;
  final ApiService apiService = ApiService(); // Создаем экземпляр ApiService

  CurrentOrders({super.key, this.id});

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  List<CurrentOrder>? orders; // Переменная для хранения списка заказов
  bool isLoading = true; // Флаг для отображения загрузки

  @override
  void initState() {
    super.initState();
    fetchCurrentOrders(); // Вызываем метод для загрузки заказов
  }

  Future<void> fetchCurrentOrders() async {
    try {
      final fetchedCurrentOrders = await widget.apiService.fetchCurrentOrders();
      if (fetchedCurrentOrders != null) {
        setState(() {
          orders =
              fetchedCurrentOrders.orders; // Теперь используем правильный тип
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки заказов: $e')),
      );
    }
  }

  // Метод для обновления данных при свайпе вниз
  Future<void> _onRefresh() async {
    await fetchCurrentOrders(); // Обновляем заказы
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20.0, right: 20),
      height: MediaQuery.of(context).size.height * 0.8, // 80% высоты экрана
      width: MediaQuery.of(context).size.width * 0.9, // 90% ширины экрана
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png'),
          const SizedBox(height: 24),
          const Text(
            'В процессе',
            style: navBarHeader,
          ),
          const SizedBox(height: 16),
          isLoading
              ? const CircularProgressIndicator(
                  color: Colors.green,
                )
              : Expanded(
                  child: RefreshIndicator(
                    color: Colors.green,
                    onRefresh: _onRefresh, // Обновление данных при свайпе вниз

                    child: CurrentOrdersList(
                      orders: orders ?? [], // Используем загруженные данные
                      onTap: (order) {}, id: widget.id ?? 0,
                      fetchCurrentOrders:
                          fetchCurrentOrders, // Передаем функцию
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class CurrentOrdersUnit extends StatelessWidget {
  final int? id;
  final String serviceName;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? finishedAt;
  final int status;
  final int clientRoomId;
  final Function onTap; // Функция для обработки нажатия

  const CurrentOrdersUnit({
    super.key,
    this.id,
    required this.serviceName,
    required this.createdAt,
    required this.status,
    required this.clientRoomId,
    required this.acceptedAt,
    required this.finishedAt,
    required this.onTap, // Передаем функцию в конструкторе
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm').format(createdAt);

    return GestureDetector(
      onTap: () => onTap(), // Вызываем функцию при нажатии
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: const Color.fromRGBO(244, 244, 244, 1)),
        ),
        width: 350,
        height: 98,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 14),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName.capitalize(),
                    style: scannerTextStyle,
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '№ ${clientRoomId.toString()}',
                    style: ordersHeaderText,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Центрирует по вертикали
                children: [
                  Text(formattedTime),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Расширение для метода capitalize
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class CurrentOrdersList extends StatefulWidget {
  final ApiService apiService = ApiService(); // Экземпляр ApiService

  final int id;
  final List<CurrentOrder> orders; // Список заказов с правильным типом
  final Function(CurrentOrder)
      onTap; // Функция для обработки нажатия на элемент
  final Future<void> Function()
      fetchCurrentOrders; // Метод для обновления списка заказов

  CurrentOrdersList(
      {super.key,
      required this.orders,
      required this.onTap,
      required this.id,
      required this.fetchCurrentOrders});
  @override
  State<CurrentOrdersList> createState() => _CurrentOrdersListState();
}

class _CurrentOrdersListState extends State<CurrentOrdersList> {
  // Передаем функцию в конструкторе
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero, // Убирает внутренние отступы
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        final order = widget.orders[index];
        return Padding(
          padding: EdgeInsets.only(
              bottom: index == widget.orders.length - 1 ? 0 : 16),
          child: CurrentOrdersUnit(
            id: order.id,
            serviceName: order.service.name, // Выводим название услуги
            createdAt: order.createdAt,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController reasonController =
                      TextEditingController(); // Контроллер для поля ввода
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
                            controller: reasonController,
                            decoration: const InputDecoration(
                              hintText: 'Комментарий',
                              fillColor: Color.fromARGB(
                                  255, 255, 255, 255), // Задает цвет фона
                              filled: true,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
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
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center),
                          onPressed: () async {
                            // Получаем текст из TextField (причина)
                            String reason = reasonController
                                .text; // Получаем текст из TextField
                            int id = order.id; // Получаем ID заказа

                            try {
                              // Вызываем метод завершения заказа с причиной
                              final response =
                                  await widget.apiService.doneOrder(id, reason);
                              if (response != null) {
                                print('Заказ завершен');
                                // Здесь можно вызвать onBack или выполнить другие действия
                                Navigator.of(context).pop(); // Закрываем диалог
                                // После закрытия диалога обновляем список заказов
                                setState(() {
                                  // Здесь вызываем метод для обновления списка заказов
                                  widget
                                      .fetchCurrentOrders(); // Используем widget.fetchCurrentOrders()
                                });
                              } else {
                                print('Ошибка при завершении заказа');
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
                            decoration: commonButtonStyle,
                            child: const Padding(
                              padding: EdgeInsets.zero,
                              child: Center(
                                child: Text(
                                  'Завершить',
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
            },
            status: order.status,
            clientRoomId: order.clientRoomId,
            acceptedAt: order.acceptedAt,
            finishedAt: order.finishedAt, // Передаем текущий заказ в функцию
          ),
        );
      },
    );
  }
}
