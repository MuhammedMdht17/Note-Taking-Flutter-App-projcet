import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/note_controller.dart';
import '../routing/app_routes.dart';
import '../widgets/alert_dialog.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteController controller = Get.find();

  NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)?.settings.arguments as int;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            "وردەکاری تێبینیەکان",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (val) {
                if (val == 0) {
                  editNote(i);
                } else if (val == 1) {
                  deleteNote(context, i);
                } else if (val == 2) {
                  shareNote(i);
                }
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    value: 0,
                    child: Text(
                      "دەسکاریکردن",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "سڕینەوە",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      "شەیرکردن",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ];
              },
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: GetBuilder<NoteController>(
          builder: (_) => Scrollbar(
            child: Container(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      controller.notes[i].title!,
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      " دەستکاری کراوە لە: ${controller.notes[i].dateTimeEdited}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectableText(
                      controller.notes[i].content!,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void editNote(int i) async {
    Get.toNamed(AppRoute.EDIT_NOTE, arguments: i);
  }

  void deleteNote(BuildContext context, int i) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          headingText: "ئایا دڵنیای کە دەتەوێت ئەم تێبینییە بسڕیتەوە؟",
          contentText:
              "بەم شێوەیە تێبینییەکە بۆ هەمیشە دەسڕێتەوە. ناتوانیت ئەم کردارە هەڵبوەشێنیتەوە.",
          confirmFunction: () {
            controller.deleteNote(controller.notes[i].id!);
            Get.offAllNamed(AppRoute.HOME);
          },
          declineFunction: () {
            Get.back();
          },
        );
      },
    );
  }

  void shareNote(int i) async {
    controller.shareNote(
      controller.notes[i].title!,
      controller.notes[i].content!,
    );
  }
}
