import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniproject/common/const/const.dart';
import 'package:miniproject/common/widget/MyButton.dart';
import 'package:miniproject/common/widget/MyTextField.dart';
import 'package:miniproject/common/widget/toast_overlay.dart';
import 'package:miniproject/main.dart';
import 'package:miniproject/models/newfeed.dart';
import 'package:miniproject/module/news_feed/bloc/newfeed_bloc.dart';
import 'package:miniproject/module/news_feed/page/newfeed_page.dart';
import 'package:miniproject/services/api_service.dart';
import 'package:miniproject/services/photo_service.dart';
import 'package:miniproject/util/transition/navigator.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var notifier = ValueNotifier<bool>(false);
  late NewfeedBloc bloc;

  final picker = ImagePicker();
  var url = '';
  @override
  void initState() {
    bloc = NewfeedBloc(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(title: 'Báo cáo', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const MyTextField(
                hintText: 'Tiêu đề',
              ),
              const SizedBox(
                height: 20,
              ),
              const MyTextField(
                hintText: 'Nội dung',
              ),
              buildItem(),
              GestureDetector(
                onTap: () {
                  print('GestureDetector');
                },
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                          valueListenable: notifier,
                          builder: (context, value, _) {
                            return MyBottom(
                              onTap: () {
                                navigatorPush(context, const NewfeedPage());
                              },
                              text: 'Lưu',
                              enable: true,
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem() {
    return StreamBuilder<List<NewFeed>>(
      stream: bloc.streamNewfeed,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          return Container(
            //color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 20),
            height: 500,
            width: double.infinity,
            child: (GridView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.length ?? 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 95,
                childAspectRatio: 1.0,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                if (index == (snapshot.data!.length) - 1) {
                  return GestureDetector(
                    onTap: () {
                      selectImage(source: ImageSource.gallery);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child:
                          const Icon(Icons.add, size: 32, color: Colors.black),
                    ),
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Image.network(url,
                      width: double.infinity, fit: BoxFit.cover),
                );
              },
            )),
          );
        }
        return Container();
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
    apiService.uploadAvatar(file: photo).then((value) {
      setState(() {
        url = '$baseURl${value.path}';
      });
    }).catchError((e) {
      ToastOverlay(context).showOverlay(messeage: e.toString());
    });
  }
}
