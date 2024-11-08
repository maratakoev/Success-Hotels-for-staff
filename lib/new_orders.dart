import 'package:flutter/material.dart';
import 'package:hotels_clients_app/08_dialog_window.dart';
import 'package:hotels_clients_app/models/orders.dart';
import 'package:hotels_clients_app/repository/api_service.dart';
import './styles.dart';
import 'package:intl/intl.dart'; // Пакет для форматирования времени

class Orders extends StatefulWidget {
  final ApiService apiService = ApiService();

  Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders; // Типизированный список заказов
  bool isLoading = true;
  Order? selectedOrder; // Для хранения выбранного заказа

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final fetchedOrders = await widget.apiService.fetchOrders();
      if (fetchedOrders != null) {
        setState(() {
          orders = fetchedOrders.orders;
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

// Функция для обновления данных при свайпе вниз
  Future<void> _onRefresh() async {
    await fetchOrders(); // Обновляем заказы
  }

  void showDetail(Order order) {
    setState(() {
      selectedOrder = order; // Устанавливаем выбранный заказ
    });
  }

  void goBack() {
    setState(() {
      selectedOrder = null; // Возвращаемся к списку заказов
    });
  }

  @override
  Widget build(BuildContext context) {
    // Если заказ не выбран, показываем список
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20.0, right: 20),
      height: 800,
      width: 370,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png'),
          const SizedBox(height: 24),
          const Text(
            'Новые заказы',
            style: navBarHeader,
          ),
          const SizedBox(height: 16),
          isLoading
              ? const CircularProgressIndicator(color: Colors.green)
              : selectedOrder != null
                  ? ServiceDetailPage(
                      serviceName: selectedOrder!.service.name,
                      createdAt: selectedOrder!.createdAt,
                      acceptedAt: selectedOrder!.acceptedAt,
                      finishedAt: selectedOrder!.finishedAt,
                      clientRoomId: selectedOrder!.clientRoomId,
                      onBack: goBack, // Метод для возврата
                      id: selectedOrder!.id,
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: Colors.green,
                        child: OrdersList(
                          orders: orders ?? [],
                          onTap:
                              showDetail, // Передаем метод для показа деталей
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

class OrdersUnit extends StatelessWidget {
  final int orderUnitId;
  final String serviceName;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? finishedAt;
  final int status;
  final int clientRoomId;
  final Function onTap; // Функция для обработки нажатия

  const OrdersUnit({
    super.key,
    required this.orderUnitId,
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

class OrdersList extends StatelessWidget {
  final List<Order> orders;
  final Function(Order) onTap; // Функция для обработки нажатия на элемент

  const OrdersList(
      {super.key,
      required this.orders,
      required this.onTap}); // Передаем функцию в конструкторе

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero, // Убирает внутренние отступы
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index == orders.length - 1 ? 0 : 16),
          child: OrdersUnit(
            orderUnitId: order.id,
            serviceName: order.service.name,
            createdAt: order.createdAt,
            status: order.status,
            clientRoomId: order.clientRoomId,
            acceptedAt: order.acceptedAt,
            finishedAt: order.finishedAt,
            onTap: () => onTap(order), // Передаем текущий заказ в функцию
          ),
        );
      },
    );
  }
}
