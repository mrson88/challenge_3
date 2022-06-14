import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);
  static String id = 'download_file';

  @override
  State<DownloadFile> createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 100, left: 100, right: 100),
        color: Colors.white,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(30),
            height: 100,
            color: Colors.red,
          ),
          const SizedBox()
        ]),
      ),
    );
  }
}
