import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/AuthProviders/auth_provider.dart';

import 'package:store_ui/Screens/Auth/login_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Utils/routers.dart';
import 'package:store_ui/Validators/auth_validator.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
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
                    const FlutterLogo(size: 100),
                    customTextField(
                      controller: _name,
                      title: 'Tên',
                      hint: 'Nhập tên của bạn',
                      validator: (value) => AuthValidator.name(value),
                    ),
                    customTextField(
                      controller: _email,
                      title: 'Email',
                      hint: 'Nhập email của bạn',
                      validator: (value) => AuthValidator.email(value),
                    ),
                    customTextField(
                      controller: _password,
                      title: 'Mật khẩu',
                      hint: 'Nhập mật khẩu của bạn',
                      validator: (value) => AuthValidator.password(value),
                    ),
                    customTextField(
                      title: 'Nhập lại mật khẩu',
                      hint: 'Nhập lại mật khẩu của bạn',
                      validator: (value) =>
                          AuthValidator.confirmPassword(value, _password.text),
                    ),
                    Consumer<AuthProvider>(builder: (context, auth, child) {
                      return customButton(
                        text: 'Đăng ký',
                        context: context,
                        status: auth.isLoading,
                        tap: () => _register(auth),
                      );
                    }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Bạn đã có tài khoản?'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            PageNavigator(ctx: context)
                                .nextPage(page: const LoginPage());
                          },
                          child: Text(
                            'Đăng nhập ngay',
                            style: TextStyle(color: primaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _register(AuthProvider auth) {
    if (_formKey.currentState!.validate()) {
      auth.register(
        name: _name.text,
        email: _email.text,
        password: _password.text,
        context: context,
      );
    } else {
      showCustomToast(
        context: context,
        msg: 'Vui lòng kiểm tra lại thông tin',
        type: ToastificationType.error,
        iconData: Icons.error,
      );
    }
  }
}
