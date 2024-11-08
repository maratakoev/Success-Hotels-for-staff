import 'package:flutter/material.dart';
import 'package:hotels_clients_app/02_qr_scanner.dart';
import 'package:hotels_clients_app/03_nav_bar.dart';
import 'styles.dart';

void main() {
  runApp(const HotelsClientsApp());
}

class HotelsClientsApp extends StatelessWidget {
  const HotelsClientsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotels_Clients_App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffeff1f3),
        // colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 253, 255, 1),
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 24),
                  const Text(
                    'Работникам отеля',
                    style: navBarHeader,
                  ),
                  const SizedBox(height: 27),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      textAlign: TextAlign
                          .center, // Добавлено для выравнивания текста по центру
                      'Для входа в личный кабинет отсканируйте ваш QRcode',
                      style: scannerTextStyle,
                    ),
                  ),
                  const SizedBox(height: 64),
                  const Button(),
                ],
              )
            ],
          )),
    );
  }
}

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 57,
      decoration: commonButtonStyle,
      child: TextButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BarcodeScannerSimple()));
        },
        child: const Text(
          'Сканировать QR',
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
