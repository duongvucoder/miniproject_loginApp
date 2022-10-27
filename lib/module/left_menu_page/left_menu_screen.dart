import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniproject/common/const/const.dart';
import 'package:miniproject/common/widget/toast_overlay.dart';
import 'package:miniproject/models/profile.dart';
import 'package:miniproject/module/login_page/login_screen.dart';
import 'package:miniproject/module/profile_page/bloc/profile_bloc.dart';
import 'package:miniproject/module/profile_page/profile_screen.dart';
import 'package:miniproject/module/report_page/page/report_screen.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/photo_service.dart';
import 'package:miniproject/util/transition/navigator.dart';

class LeftMenuPage extends StatefulWidget {
  const LeftMenuPage({Key? key}) : super(key: key);
  @override
  State<LeftMenuPage> createState() => _LeftMenuPageState();
}

class _LeftMenuPageState extends State<LeftMenuPage> {
  late ProfileBloc bloc;

  final picker = ImagePicker();
  var url = '';
  @override
  void initState() {
    bloc = ProfileBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blue,
            child: buildInformation(), // set your color
          ),
        ),
      ),
      body: Column(
        children: [
          buildListItem(
              text: 'Sự cố',
              icon: Icons.toc_rounded,
              onlick: () {
                navigatorPush(context, const ReportPage());
              }),
          const Divider(
            color: Colors.grey,
          ),
          buildListItem(
              text: 'Đổi mật khẩu',
              icon: Icons.password_outlined,
              onlick: () {
                navigatorPush(context, const ProfilePage());
              }),
          const Divider(
            color: Colors.grey,
          ),
          buildListItem(
              text: 'Báo cáo',
              icon: Icons.note_alt,
              onlick: () {
                navigatorPush(context, const ReportPage());
              }),
          const Divider(
            color: Colors.grey,
          ),
          buildListItem(
            text: 'Điều khoản',
            icon: Icons.preview_outlined,
          ),
          const Divider(
            color: Colors.grey,
          ),
          buildListItem(
            text: 'Liên hệ',
            icon: Icons.note_alt,
          ),
          const Divider(
            color: Colors.grey,
          ),
          buildListItem(
              text: 'Đăng xuất',
              icon: Icons.login_outlined,
              onlick: () {
                navigatorPush(context, const LoginScreen());
              }),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
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
    apiService.uploadAvatar(file: photo).then((value) {
      setState(() {
        url = '$baseURl${value.path}';
      });
    }).catchError((e) {
      ToastOverlay(context).showOverlay(messeage: e.toString());
    });
  }

  Widget buildInformation() {
    return StreamBuilder<Profile>(
      stream: bloc.streamProfile,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blue,
            child: Row(
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.network(
                        // '$baseURl${snapshot.data?.avatar ?? ""}',
                        url,
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.asset(
                                'assets/images/duongvu.jpeg',
                                width: 75,
                                height: 75,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 40,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white70,
                      ),
                      onPressed: (() {
                        selectImage(source: ImageSource.gallery);
                      }),
                    ),
                  ),
                ]),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        snapshot.data?.phoneNumber ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildListItem({String? text, IconData? icon, Function? onlick}) {
    return GestureDetector(
      onTap: () {
        if (onlick != null) {
          onlick();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(width: 20),
            Text(
              text ?? "",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
