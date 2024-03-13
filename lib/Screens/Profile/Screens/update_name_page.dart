import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Models/user_test.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({super.key});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cập nhật tên'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              customTextField(
                controller: _name,
                title: 'Tên của bạn',
                hint: 'Nhập tên của bạn',
              ),
              Consumer<UserProvider>(builder: (context, user, child) {
                return customButton(
                    text: 'Cập nhật',
                    context: context,
                    status: user.isLoading,
                    tap: () => _updateMe(user));
              }),
            ],
          ),
        ));
  }

  void _updateMe(UserProvider user) {
    if (_name.text.isEmpty) {
      errorMessage(context: context, message: 'Tên không được để trống');
    } else {
      user.updateMe(name: _name.text, context: context);
      context.read<UserDataProvider>().runTimeProfile(name: _name.text);
    }
  }
}
