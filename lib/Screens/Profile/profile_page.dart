import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Models/user_test.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Screens/Auth/login_page.dart';
import 'package:store_ui/Screens/Auth/register_page.dart';
import 'package:store_ui/Screens/Profile/Screens/setting_account_page.dart';
import 'package:store_ui/Screens/Profile/Widgets/my_button.dart';
import 'package:store_ui/Screens/Profile/Widgets/profile_item.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    print('profile');
    // UserDataProvider().getProfile().then((value) => print(value.profile!.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Container(
        color: primaryColor,
        padding:
            const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 20),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.person, size: 30, color: primaryColor),
                ),
                const SizedBox(width: 10),
                (context.watch<UserDataProvider>().name == '')
                    ? FutureBuilder<UserTest>(
                        future: UserDataProvider().getProfile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasData &&
                                snapshot.data!.profile != null) {
                              final profile = snapshot.data?.profile;

                              return Text(
                                profile!.name as String,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                ),
                              );
                            } else {
                              return const Text('');
                            }
                          }
                        })
                    : Text(
                        context.watch<UserDataProvider>().name.toString(),
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                        ),
                      ),
              ],
            ),
            const Spacer(),
            FutureBuilder<bool>(
                future: UserDataProvider().isLogin(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData && snapshot.data == true) {
                      return const Text('');
                    } else {
                      return Row(
                        children: [
                          myButton(
                              text: 'Đăng nhập',
                              backgroundColor: white,
                              textColor: primaryColor,
                              onTap: () => {
                                    PageNavigator(ctx: context)
                                        .nextPage(page: const LoginPage())
                                  }),
                          const SizedBox(
                            width: 10,
                          ),
                          myButton(
                            text: 'Đăng ký',
                            backgroundColor: primaryColor,
                            textColor: white,
                            onTap: () => {
                              PageNavigator(ctx: context)
                                  .nextPage(page: const RegisterPage())
                            },
                          ),
                        ],
                      );
                    }
                  }
                })
          ],
        ),
      ),
      const SizedBox(height: 8),
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              icon: Icons.settings,
              text: 'Thiết lập tài khoản',
              onTap: () => {
                UserDataProvider().isLogin().then((isLogin) => {
                      if (!isLogin)
                        {
                          PageNavigator(ctx: context)
                              .nextPage(page: const LoginPage()),
                        }
                      else
                        {
                          PageNavigator(ctx: context)
                              .nextPage(page: const SettingAccount())
                        }
                    }),
              },
            ),
          ),
          FutureBuilder<bool>(
              future: UserDataProvider().isLogin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Column(
                      children: [
                        Container(
                          color: white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              profileItem(
                                icon: Icons.delivery_dining,
                                text: 'Đơn mua',
                                onTap: () => {},
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      // voucher
                                      Icon(
                                        Icons.confirmation_num,
                                        color: grey,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Đã xác nhận',
                                        style: TextStyle(
                                            fontSize: 14, color: grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // voucher
                                      Icon(
                                        Icons.drive_file_move,
                                        color: grey,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Đang giao hàng',
                                        style: TextStyle(
                                            fontSize: 14, color: grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // voucher
                                      Icon(
                                        Icons.check_box_outlined,
                                        color: grey,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Đã giao',
                                        style: TextStyle(
                                            fontSize: 14, color: grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // voucher
                                      Icon(
                                        Icons.cancel_outlined,
                                        color: grey,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Đã hủy',
                                        style: TextStyle(
                                            fontSize: 14, color: grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: profileItem(
                        icon: Icons.delivery_dining,
                        text: 'Đơn hàng của tôi',
                        onTap: () => {},
                      ),
                    );
                  }
                }
              }),
          const SizedBox(height: 8),
          Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      color: primaryColor,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Tiện ích của tôi',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Color.fromARGB(255, 233, 229, 229),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Column(
                    children: [
                      // voucher
                      Icon(
                        Icons.card_giftcard,
                        color: Color.fromARGB(255, 221, 70, 70),
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Mã giảm giá',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ]);
  }
}
