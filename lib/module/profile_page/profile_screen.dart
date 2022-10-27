import 'package:flutter/material.dart';
import 'package:miniproject/common/const/const.dart';
import 'package:miniproject/common/widget/MyButton.dart';
import 'package:miniproject/common/widget/MyTextField.dart';
import 'package:miniproject/common/widget/toast_overlay.dart';

import 'package:miniproject/models/profile.dart';
import 'package:miniproject/module/news_feed/page/newfeed_page.dart';
import 'package:miniproject/module/profile_page/bloc/profile_bloc.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/photo_service.dart';
import 'package:miniproject/util/transition/keyboard.dart';
import 'package:miniproject/util/transition/navigator.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc bloc;
  final picker = ImagePicker();
  var url = '';
  @override
  void initState() {
    bloc = ProfileBloc(context);
    super.initState();
  }

  final profile = Profile();
  final nameController = TextEditingController();
  final birhdayController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  var notifier = ValueNotifier<bool>(false);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildProfile(),
    );
  }

  Widget buildProfile() {
    return StreamBuilder<Profile>(
      stream: bloc.streamProfile,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          // ignore: avoid_print
          print('hasData');
          nameController.text = snapshot.data?.name ?? "";
          birhdayController.text = snapshot.data?.dateOfBirth ?? "";
          addressController.text = snapshot.data?.address ?? "";
          phoneController.text = snapshot.data?.phoneNumber ?? "";
          emailController.text = snapshot.data?.email ?? "";
          return GestureDetector(
            onTap: (() {
              hideKeyboardAndUnFocus(context);
            }),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 64),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: Image.network(
                                  url,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const FlutterLogo(
                                        size: 84,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                right: -15,
                                bottom: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                  onPressed: (() {
                                    selectImage(source: ImageSource.gallery);
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          MyTextField(
                            controller: nameController,
                            labelText: 'Họ và Tên',
                            autoFocus: true,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            controller: birhdayController,
                            labelText: 'Ngày/tháng/năm sinh',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            controller: addressController,
                            labelText: 'Địa chỉ',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            controller: phoneController,
                            labelText: 'Số điện thoại',
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            controller: emailController,
                            labelText: 'Email',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ValueListenableBuilder<bool>(
                                    valueListenable: notifier,
                                    builder: (context, value, _) {
                                      return MyBottom(
                                        onTap: () {
                                          navigatorPush(
                                              context, const NewfeedPage());
                                        },
                                        text: 'Cập nhật thông tin',
                                        // onTap: saveProfile,
                                        enable: true,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'HotLine:'),
                        TextSpan(
                          text: '  1800.1186',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future selectImage({required ImageSource source}) async {
    try {
      final image = await picker.pickImage(
        source: source,
      );
      if (image != null) {
        upload(image);
      }
    } catch (e) {
      ToastOverlay(context).showOverlay(messeage: e.toString());
    }
  }

  void upload(XFile photo) {
    // print('path: ${photo.path}');
    apiService.uploadAvatar(file: photo).then((value) {
      // print('url: $baseURl${value.path}');
      // print('value: ${value.path}');
      setState(() {
        url = '$baseURl${value.path}';
      });
    }).catchError((e) {
      ToastOverlay(context).showOverlay(messeage: e.toString());
    });
  }
}
