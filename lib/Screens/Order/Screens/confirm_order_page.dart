import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Providers/OrderProviders/order_provider.dart';
import 'package:store_ui/Screens/Profile/Screens/update_me_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Gọi phương thức getProfile() để lấy thông tin người dùng
    UserDataProvider().getProfile().then((value) {
      final address =
          '${value.profile!.address?[0].province}, ${value.profile!.address?[0].district}, ${value.profile!.address?[0].village}, ${value.profile!.address?[0].shortDescription}';

      _address.text = address;
      _phone.text = value.profile!.address![0].phone!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Xác nhận đơn hàng'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              customTextField(
                  controller: _address,
                  title: 'Địa chỉ nhận hàng',
                  maxLines: 3,
                  readOnly: true),
              customTextField(
                controller: _phone,
                title: 'Số điện thoại',
                readOnly: true,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => PageNavigator(ctx: context)
                        .nextPage(page: const UpdateMePage()),
                    child: Text(
                      'Thay đổi thông tin nhận hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  )),
              customTextField(
                controller: _note,
                title: 'Ghi chú',
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              // Phương thức thanh toán
              Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Thanh toán khi nhận hàng',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: grey,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Nút đặt hàng
              Consumer<OrderProvider>(builder: (context, orderProvider, _) {
                return customButton(
                  text: 'Đặt hàng',
                  context: context,
                  status: orderProvider.isLoading,
                  tap: () {
                    orderProvider.createOrder(
                        context: context, note: _note.text);
                  },
                );
              })
            ],
          ),
        ));
  }
}
