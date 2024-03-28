import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/AuthProviders/auth_provider.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Widgets/button.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController _otp = TextEditingController();
  @override
  void initState() {
    // ignore: avoid_print
    UserDataProvider().getEmail().then((value) => print('Email: $value'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác thực tài khoản'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  Icons.email,
                  size: 100,
                  color: grey,
                ),
                const SizedBox(height: 20),
                Text(
                  'Một mã xác thực đã được gửi đến email của bạn, vui lòng kiểm tra email và nhập mã xác thực để xác thực tài khoản của bạn.',
                  style: TextStyle(fontSize: 14, color: grey),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _otp,
                  style:
                      TextStyle(fontSize: 40, color: grey, letterSpacing: 20),
                ),
                const SizedBox(height: 15),
                Consumer<AuthProvider>(builder: (context, auth, child) {
                  return GestureDetector(
                    onTap: () {
                      if (auth.isLoading == false) {
                        UserDataProvider().getEmail().then((value) =>
                            {auth.resendOtp(email: value, context: context)});
                      }
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Gửi lại mã',
                        style: TextStyle(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),
                Consumer<AuthProvider>(builder: (context, auth, child) {
                  return customButton(
                    context: context,
                    text: 'Xác thực',
                    status: auth.isLoading,
                    tap: () => {
                      if (_otp.text.isEmpty)
                        {
                          errorMessage(
                              context: context,
                              message: 'Mã xác thực không được để trống')
                        }
                      else
                        {
                          UserDataProvider().getEmail().then((value) => {
                                auth.verify(
                                    email: value,
                                    otp: _otp.text,
                                    context: context)
                              })
                        }
                    },
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
