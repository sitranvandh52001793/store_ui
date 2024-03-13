import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/AuthProviders/auth_provider.dart';
import 'package:store_ui/Screens/Auth/register_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Utils/routers.dart';
import 'package:store_ui/Validators/auth_validator.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
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
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const RegisterPage());
                        },
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                    Consumer<AuthProvider>(builder: (context, auth, child) {
                      return customButton(
                          text: 'Đăng nhập',
                          context: context,
                          status: auth.isLoading,
                          tap: () => _login(auth));
                    }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Bạn chưa có tài khoản?'),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            PageNavigator(ctx: context)
                                .nextPage(page: const RegisterPage());
                          },
                          child: Text(
                            'Đăng ký ngay',
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

  void _login(AuthProvider auth) {
    if (_formKey.currentState!.validate()) {
      auth.login(
        email: _email.text,
        password: _password.text,
        context: context,
      );
    } else {
      errorMessage(
          context: context,
          message: 'Vui lòng kiểm tra lại thông tin nhập vào');
    }
  }
}
