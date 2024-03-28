import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Models/user_model.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Screens/Profile/Screens/update_address_page.dart';
import 'package:store_ui/Screens/Profile/Screens/update_name_page.dart';
import 'package:store_ui/Screens/Profile/Screens/update_phone_page.dart';
import 'package:store_ui/Screens/Profile/Widgets/update_item.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';

class UpdateMePage extends StatefulWidget {
  const UpdateMePage({super.key});

  @override
  State<UpdateMePage> createState() => _UpdateMePageState();
}

class _UpdateMePageState extends State<UpdateMePage> {
  UserModel user = UserModel();
  @override
  void initState() {
    UserDataProvider().getProfile().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cập nhật thông tin'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: white),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1709313428364-f64213f34a55?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8fA%3D%3D'))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: white),
                              color: Colors.blue),
                          child: Icon(
                            Icons.edit,
                            color: white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  // Kiểm tra xem name của UserDataProvider có trống không và profile không null
                  updateItem(
                    title: 'Tên',
                    value: (context.watch<UserDataProvider>().name.isEmpty &&
                            user.profile != null &&
                            user.profile!.name != null)
                        ? user.profile!.name as String
                        : context.watch<UserDataProvider>().name,
                    onTap: () => PageNavigator(ctx: context)
                        .nextPage(page: const UpdateNamePage()),
                  ),
                  // Kiểm tra profile không null trước khi hiển thị email
                  if (user.profile != null)
                    updateItem(
                      title: 'Email',
                      value: user.profile!.email as String,
                      disable: true,
                    ),
                  const SizedBox(height: 20),
                  // Kiểm tra xem phone của UserDataProvider có trống không và profile không null
                  updateItem(
                    title: 'Số điện thoại',
                    value: (context.watch<UserDataProvider>().phone.isEmpty &&
                            user.profile != null &&
                            user.profile!.address != null &&
                            user.profile!.address!
                                .isNotEmpty && // Kiểm tra nếu danh sách địa chỉ không rỗng
                            user.profile!.address![0].phone != null)
                        ? user.profile!.address![0].phone.toString()
                        : context.watch<UserDataProvider>().phone.isEmpty ||
                                user.profile!.address?.isEmpty == true ||
                                user.profile!.address![0].phone == null
                            ? 'Cập nhật'
                            : context.watch<UserDataProvider>().phone,
                    onTap: () => PageNavigator(ctx: context)
                        .nextPage(page: const UpdatePhonePage()),
                  ),

                  // Hiển thị phần cập nhật địa chỉ
                  updateItem(
                    title: 'Địa chỉ',
                    value: 'Cập nhật',
                    onTap: () => PageNavigator(ctx: context)
                        .nextPage(page: const UpdateAddressPage()),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
