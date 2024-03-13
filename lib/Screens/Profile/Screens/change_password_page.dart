import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Validators/auth_validator.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _reNewPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thay đổi mật khẩu'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const FlutterLogo(size: 80),
                    customTextField(
                      controller: _oldPassword,
                      title: 'Mật khẩu cũ',
                      hint: 'Nhập mật khẩu cũ của bạn',
                      validator: (value) => AuthValidator.password(value),
                    ),
                    customTextField(
                      controller: _newPassword,
                      title: 'Mật khẩu mới',
                      hint: 'Nhập mật khẩu mới của bạn',
                      validator: (value) => AuthValidator.password(value),
                    ),
                    customTextField(
                      controller: _reNewPassword,
                      title: 'Nhập lại mật khẩu mới',
                      hint: 'Nhập lại mật khẩu mới của bạn',
                      validator: (value) => AuthValidator.confirmPassword(
                          value, _newPassword.text),
                    ),
                    Consumer<UserProvider>(builder: (context, user, child) {
                      return customButton(
                        text: 'Xác nhận',
                        status: user.isLoading,
                        context: context,
                        tap: () => _changePassword(user),
                      );
                    }),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changePassword(UserProvider user) {
    if (_formKey.currentState!.validate()) {
      // Call API to change password
      user.changePassword(
        oldPassword: _oldPassword.text,
        newPassword: _newPassword.text,
        context: context,
      );
    } else {
      errorMessage(
          context: context,
          message: 'Vui lòng kiểm tra lại thông tin nhập vào');
    }
  }
}
