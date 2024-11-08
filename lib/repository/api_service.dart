import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotels_clients_app/models/complete_orders.dart';
import 'package:hotels_clients_app/models/current.dart';
import 'package:hotels_clients_app/models/orders.dart';

class ApiService {
  final Dio _dio = Dio(); // Инициализация Dio
  final FlutterSecureStorage storage =
      const FlutterSecureStorage(); // Инициализация Secure Storage

  // Метод для получения списка завершенных заказов
  Future<CompletedOrders?> fetchCompletedOrders() async {
    try {
      // Логируем начало выполнения запроса
      debugPrint('Step 1: Начинаем получать токен');

      // Получаем токен
      String? token = await storage.read(key: 'token');
      debugPrint('Step 2: Получен токен: $token');

      // Логируем URL запроса
      debugPrint(
          'Step 3: Выполняем запрос к API по URL: https://app.successhotel.ru/api/staff/orders/archive');

      final response = await _dio.get(
        'https://app.successhotel.ru/api/staff/orders/archive',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Добавляем токен в заголовок
            'User-Agent': 'YourAppName/1.0.0', // Идентификация приложения
            'Accept': 'application/json', // Ожидаемый тип данных
          },
        ),
      );

      // Логируем ответ сервера
      debugPrint('Step 4: Ответ сервера: ${response.data}');

      if (response.statusCode == 200) {
        // Логируем успешный ответ
        debugPrint('Step 5: Ответ успешный, парсим данные');

        // Парсим JSON и создаем объект CompletedOrders
        return CompletedOrders.fromJson(response.data);
      } else {
        // Логируем код ошибки, если он не 200
        debugPrint('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, stackTrace) {
      // Логируем исключение и стек вызовов
      debugPrint('Error fetching completed orders: $e');
      debugPrint('Stack trace: $stackTrace');
    }

    return null; // Возвращаем null в случае ошибки
  }

  // Метод для получения списка текущих заказов
  Future<CurrentOrders?> fetchCurrentOrders() async {
    try {
      // Логируем начало выполнения запроса
      debugPrint('Step 1: Начинаем получать токен');

      // Получаем токен
      String? token = await storage.read(key: 'token');
      debugPrint('Step 2: Получен токен: $token');

      // Логируем URL запроса
      debugPrint(
          'Step 3: Выполняем запрос к API по URL: https://app.successhotel.ru/api/staff/orders/current');

      final response = await _dio.get(
        'https://app.successhotel.ru/api/staff/orders/current',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Добавляем токен в заголовок
            'User-Agent': 'YourAppName/1.0.0', // Идентификация приложения
            'Accept': 'application/json', // Ожидаемый тип данных
          },
        ),
      );

      // Логируем ответ сервера
      debugPrint('Step 4: Ответ сервера: ${response.data}');

      if (response.statusCode == 200) {
        // Логируем успешный ответ
        debugPrint('Step 5: Ответ успешный, парсим данные');

        // Парсим JSON и создаем объект CurrentOrders
        return CurrentOrders.fromJson(response.data);
      } else {
        // Логируем код ошибки, если он не 200
        debugPrint('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, stackTrace) {
      // Логируем исключение и стек вызовов
      debugPrint('Error fetching orders: $e');
      debugPrint('Stack trace: $stackTrace');
    }

    return null; // Возвращаем null в случае ошибки
  }

  //Метод для отправки выбранного заказа на сервер
  Future<Response?> takeOrder(int Id) async {
    try {
      String? token = await storage.read(key: 'token'); // Получаем токен

      final response = await _dio.get(
        'https://app.successhotel.ru/api/staff/orders/$Id/take',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Добавляем токен в заголовок
            'User-Agent': 'YourAppName/1.0.0', // Идентификация приложения
            'Accept': 'application/json', // Ожидаемый формат данных
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Успешно взят заказ с ID: $Id');
        return response;
      } else {
        print('Ошибка при попытке взять заказ: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
    }
    return null;
  }

  //Метод для отмены заказа
  Future<Response?> cancelOrder(int Id, String reason) async {
    try {
      String? token = await storage.read(key: 'token'); // Получаем токен

      final response = await _dio.post(
        'https://app.successhotel.ru/api/staff/orders/$Id/cancel',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Добавляем токен в заголовок
            'User-Agent': 'YourAppName/1.0.0', // Идентификация приложения
            'Accept': 'application/json', // Ожидаемый формат данных
          },
        ),
        data: {
          'message': reason, // Используем переменную reason в теле запроса
        },
      );

      if (response.statusCode == 200) {
        print('Успешно отменен заказ с ID: $Id');
        return response;
      } else {
        print('Ошибка при попытке отменить заказ: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
    }
    return null;
  }

//Метод для завершения заказа
  Future<Response?> doneOrder(int id, String reason) async {
    try {
      String? token = await storage.read(key: 'token'); // Получаем токен

      final response = await _dio.post(
        'https://app.successhotel.ru/api/staff/orders/$id/finish',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Добавляем токен в заголовок
            'User-Agent': 'YourAppName/1.0.0', // Идентификация приложения
            'Accept': 'application/json', // Ожидаемый формат данных
          },
        ),
        data: {
          'message': reason, // Используем переменную reason в теле запроса
        },
      );

      if (response.statusCode == 200) {
        print('Успешно отменен заказ с ID: $id');
        return response;
      } else {
        print('Ошибка при попытке отменить заказ: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
    }
    return null;
  }

  // Метод для получения списка заказов
  Future<OrdersResponse?> fetchOrders() async {
    try {
      // Логируем начало выполнения запроса
      debugPrint('Step 1: Начинаем получать токен');

      // Получаем токен
      String? token = await storage.read(key: 'token');
      debugPrint('Step 2: Получен токен: $token');

      // Логируем URL запроса
      debugPrint(
          'Step 3: Выполняем запрос к API по URL: https://app.successhotel.ru/api/staff/orders/free');

      final response = await _dio.get(
        'https://app.successhotel.ru/api/staff/orders/free',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Добавляем токен в заголовок
            'User-Agent': 'YourAppName/1.0.0', // Идентификация приложения
            'Accept': 'application/json', // Ожидаемый тип данных
          },
        ),
      );

      // Логируем ответ сервера
      debugPrint('Step 4: Ответ сервера: ${response.data}');

      if (response.statusCode == 200) {
        // Логируем успешный ответ
        debugPrint('Step 5: Ответ успешный, парсим данные');

        // Парсим JSON и создаем объект OrdersResponse
        return OrdersResponse.fromJson(response.data);
      } else {
        // Логируем код ошибки, если он не 200
        debugPrint('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, stackTrace) {
      // Логируем исключение и стек вызовов
      debugPrint('Error fetching orders: $e');
      debugPrint('Stack trace: $stackTrace');
    }

    return null; // Возвращаем null в случае ошибки
  }

  // Метод для входа пользователя
  Future<Response> loginUser({
    required String barcode,
    required BuildContext context, // Контекст передается здесь
  }) async {
    const String loginUrl = 'https://app.successhotel.ru/api/staff/login';

    try {
      final Map<String, dynamic> loginData = {
        'code': barcode,
      };

      final Response response = await _dio.post(loginUrl, data: loginData);
      print('Response from server: ${response.data}'); // Полный ответ

      // Проверка успешности логина
      if (response.data['success'] == true) {
        String token = response.data['token']; // Извлекаем токен
        await TokenStorage().saveToken(token); // Сохраняем токен
        print('Token saved: $token'); // Выводим в консоль

        // Переход на другую страницу после успешного входа
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           NavBar(), // Замените NavBar на ваш целевой экран
        //     ),
        //   );
      } else {
        _showErrorDialog(context, response.data['message']); // Показать ошибку
      }

      return response;
    } catch (e) {
      print('Произошла ошибка: $e');
      _showErrorDialog(context,
          'Произошла ошибка при входе. Пожалуйста, попробуйте еще раз.'); // Показать ошибку
      rethrow; // Пробрасываем ошибку дальше
    }
  }

  // Метод для отображения диалогового окна с сообщением об ошибке
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  declineOrder(int id) {}
}

// Тут сохраним токен.
class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _key = 'token'; // Ключ для хранения токена

  // Метод для сохранения токена
  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  // Метод для получения токена
  Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

  // Метод для удаления токена
  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }

  // Новый метод для вывода токена в консоль
  Future<void> printToken() async {
    String? token = await getToken();
    if (token != null) {
      print('Токен: $token');
    } else {
      print('Токен не найден.');
    }
  }
}
