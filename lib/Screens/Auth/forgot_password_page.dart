import 'package:flutter/material.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu?'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const FlutterLogo(size: 80),
                  customTextField(
                    title: 'Email',
                    hint: 'Nhập email của bạn',
                  ),
                  customButton(
                    text: 'Gửi yêu cầu',
                    context: context,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
