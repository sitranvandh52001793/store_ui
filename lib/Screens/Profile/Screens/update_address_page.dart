import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Providers/UserProviders/user_provider.dart';
import 'package:store_ui/Utils/notify.dart';
import 'package:store_ui/Widgets/button.dart';
import 'package:store_ui/Widgets/text_field.dart';

class UpdateAddressPage extends StatefulWidget {
  const UpdateAddressPage({super.key});

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  final TextEditingController _province = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _village = TextEditingController();
  final TextEditingController _shortDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserDataProvider().getProfile().then((value) => {
          _province.text = value.profile!.address?[0].province as String,
          _district.text = value.profile!.address?[0].district as String,
          _village.text = value.profile!.address?[0].village as String,
          _shortDescription.text =
              value.profile!.address?[0].shortDescription as String
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cập nhật địa chỉ'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              customTextField(
                controller: _province,
                title: 'Tỉnh/Thành phố ',
                hint: 'Nhập tỉnh/thành phố',
              ),
              customTextField(
                controller: _district,
                title: 'Quận/Huyện ',
                hint: 'Nhập quận/huyện',
              ),
              customTextField(
                controller: _village,
                title: 'Phường/Xã ',
                hint: 'Nhập phường/xã',
              ),
              customTextField(
                controller: _shortDescription,
                title: 'Mô tả ',
                maxLines: 5,
                hint: 'Nhập mô tả',
              ),
              Consumer<UserProvider>(builder: (context, user, child) {
                return customButton(
                    text: 'Cập nhật',
                    context: context,
                    status: user.isLoading,
                    tap: () => _updateMe(user));
              }),
            ],
          ),
        ));
  }

  void _updateMe(UserProvider user) {
    if (_province.text.isEmpty ||
        _district.text.isEmpty ||
        _village.text.isEmpty) {
      errorMessage(
          context: context, message: 'Vui lòng kiểm tra dữ liệu nhập vào');
    } else {
      // user.updateMe(name: _name.text, context: context);
      user.updateMe(
          province: _province.text,
          district: _district.text,
          village: _village.text,
          shortDescription: _shortDescription.text,
          context: context);
      // context.read<UserDataProvider>().runTimeProfile(name: _name.text);
    }
  }
}
