import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';
import 'package:store_ui/Screens/Profile/Screens/change_password_page.dart';
import 'package:store_ui/Screens/Profile/Screens/update_me_page.dart';
import 'package:store_ui/Screens/Profile/Widgets/profile_item.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';

class SettingAccount extends StatefulWidget {
  const SettingAccount({super.key});

  @override
  State<SettingAccount> createState() => _SettingAccountState();
}

class _SettingAccountState extends State<SettingAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt tài khoản'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tài khoản và thông tin',
                  style: TextStyle(color: grey),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 233, 229, 229),
                      width: 0.5,
                    ),
                  ),
                ),
                child: profileItem(
                  icon: Icons.password_outlined,
                  text: 'Thay đổi mật khẩu',
                  onTap: () => {
                    PageNavigator(ctx: context)
                        .nextPage(page: const ChangePasswordPage())
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: profileItem(
                  icon: Icons.person_outline_rounded,
                  text: 'Cập nhật thông tin cá nhân',
                  onTap: () => {
                    PageNavigator(ctx: context)
                        .nextPage(page: const UpdateMePage())
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: profileItem(
                  icon: Icons.warning_amber_rounded,
                  text: 'Yêu cầu xóa tài khoản',
                  onTap: () => {},
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cài đặt',
                  style: TextStyle(color: grey),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 233, 229, 229),
                      width: 0.5,
                    ),
                  ),
                ),
                child: profileItem(
                  icon: Icons.notification_add_rounded,
                  text: 'Cài đặt thông báo',
                  onTap: () => {},
                ),
              ),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: profileItem(
                  icon: Icons.language,
                  text: 'Cài đặt ngôn ngữ',
                  onTap: () => {},
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 44,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Consumer<UserProvider>(builder: (context, user, child) {
              return OutlinedButton(
                onPressed: () {
                  user.logout(context: context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: Color.fromRGBO(206, 206, 206, 1), width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text('Đăng xuất'),
              );
            }),
          )
        ],
      ),
    );
  }
}
