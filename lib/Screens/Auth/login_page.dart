import 'package:flutter/material.dart';
import 'package:store_ui/Screens/Auth/register_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Column(
                children: [
                  const FlutterLogo(size: 100),
                  customTextField(
                    title: 'Email',
                    hint: 'Nhập email của bạn',
                  ),
                  customTextField(
                    title: 'Mật khẩu',
                    hint: 'Nhập mật khẩu của bạn',
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
                  customButton(
                    text: 'Đăng nhập',
                    context: context,
                  ),
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
          )
        ],
      ),
    );
  }
}
