import 'package:flutter/material.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
              child: Column(
                children: [
                  const FlutterLogo(size: 80),
                  customTextField(
                    title: 'Mật khẩu cũ',
                    hint: 'Nhập mật khẩu cũ của bạn',
                  ),
                  customTextField(
                    title: 'Mật khẩu mới',
                    hint: 'Nhập mật khẩu mới của bạn',
                  ),
                  customTextField(
                    title: 'Nhập lại mật khẩu mới',
                    hint: 'Nhập lại mật khẩu mới của bạn',
                  ),
                  customButton(
                    text: 'Xác nhận',
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
