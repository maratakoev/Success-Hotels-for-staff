import 'package:flutter/material.dart';
import 'package:hotels_clients_app/models/complete_orders.dart';
import 'package:intl/intl.dart';
import './styles.dart';
import './repository/api_service.dart';

class CompletedOrdersPage extends StatefulWidget {
  final ApiService apiService = ApiService(); // Создаем экземпляр ApiService

  CompletedOrdersPage({super.key});

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  List<CompletedOrder>?
      orders; // Переменная для хранения списка завершенных заказов
  bool isLoading = true; // Флаг для отображения загрузки

  @override
  void initState() {
    super.initState();
    fetchCompletedOrders(); // Вызываем метод для загрузки заказов
  }

  Future<void> fetchCompletedOrders() async {
    try {
      final fetchedCompletedOrders =
          await widget.apiService.fetchCompletedOrders();
      if (fetchedCompletedOrders != null) {
        setState(() {
          orders =
              fetchedCompletedOrders.orders; // Теперь используем правильный тип
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
        SnackBar(content: Text('Ошибка загрузки завершенных заказов: $e')),
      );
    }
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
            'Завершенные заказы',
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
                    onRefresh:
                        fetchCompletedOrders, // Обновление данных при свайпе вниз
                    child: CompletedOrdersList(
                      orders: orders ?? [], // Используем загруженные данные
                      onTap: (order) {},
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class CompletedOrdersUnit extends StatelessWidget {
  final int orderUnitId;
  final String serviceName;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? finishedAt;
  final int status;
  final int clientRoomId;
  final Function onTap; // Функция для обработки нажатия

  const CompletedOrdersUnit({
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

class CompletedOrdersList extends StatelessWidget {
  final List<CompletedOrder>
      orders; // Список завершенных заказов с правильным типом
  final Function(CompletedOrder)
      onTap; // Функция для обработки нажатия на элемент

  const CompletedOrdersList(
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
          child: CompletedOrdersUnit(
            orderUnitId: order.id,
            serviceName: order.service.name, // Выводим название услуги
            createdAt: order.createdAt,
            onTap: () => onTap(order),
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
