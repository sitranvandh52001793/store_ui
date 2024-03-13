import 'package:flutter/material.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print('Home page init');
    UserProvider().getMe().then((value) => {print(value.profile)});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ'),
        ),
        body: const Center(
          child: Text('Trang chủ'),
        ));
  }
}
