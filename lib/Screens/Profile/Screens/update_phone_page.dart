import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Models/user_test.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class UpdatePhonePage extends StatefulWidget {
  const UpdatePhonePage({super.key});

  @override
  State<UpdatePhonePage> createState() => _UpdatePhonePageState();
}

class _UpdatePhonePageState extends State<UpdatePhonePage> {
  final TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cập nhật số điện thoại'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              customTextField(
                controller: _phone,
                title: 'Số điện thoại',
                hint: 'Nhập số điện thoại',
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
    if (_phone.text.isEmpty) {
      errorMessage(
          context: context, message: 'Số điện thoại không được để trống');
    } else {
      user.updateMe(phone: _phone.text, context: context);
      context.read<UserDataProvider>().runTimeProfile(phone: _phone.text);
    }
  }
}
