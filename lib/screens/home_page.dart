import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/theme_services.dart';
import '../controller/note_controller.dart';
import '../routing/app_routes.dart';
import '../widgets/alert_dialog.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined),
            onPressed: () {
              ThemeServices().switchTheme();
            },
            iconSize: 24,
            color: Get.isDarkMode ? Colors.white : AppColor.darkGreyClr,
          ),
          title: const Text(
            "تێبینیەکانم",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor:
              Get.isDarkMode ? AppColor.buttonColor : AppColor.grayColor,
          actions: [
            PopupMenuButton(
              onSelected: (val) {
                if (val == 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogWidget(
                        headingText:
                            "ئایا دڵنیای کە دەتەوێت ئەم تێبینییە بسڕیتەوە؟",
                        contentText:
                            "بەم شێوەیە هەموو تێبینیەکان بۆ هەمیشە دەسڕێتەوە. ناتوانیت ئەم کردارە هەڵبوەشێنیتەوە.",
                        confirmFunction: () {
                          controller.deleteAllNotes();
                          Get.back();
                        },
                        declineFunction: () {
                          Get.back();
                        },
                      );
                    },
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text(
                    "هەموو تێبینیەکان بسڕەوە",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: GetBuilder<NoteController>(
          builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(AppRoute.ADD_NEW_NOTE);
          },
          label: const Text(
            "تێبینی نوێ زیاد بکە",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          icon: const Icon(
            Icons.add,
          ),
          backgroundColor: AppColor.buttonColor,
        ),
      ),
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          shrinkWrap: false,
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.NOTE_DETAILS, arguments: index);
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      headingText:
                          "ئایا دڵنیای کە دەتەوێت ئەم تێبینییە بسڕیتەوە؟",
                      contentText:
                          "بەم شێوەیە تێبینییەکە بۆ هەمیشە دەسڕێتەوە. ناتوانیت ئەم کردارە هەڵبوەشێنیتەوە.",
                      confirmFunction: () {
                        controller.deleteNote(controller.notes[index].id!);
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? const Color.fromARGB(255, 228, 222, 166)
                        : AppColor.grayColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.notes[index].title!,
                              style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.notes[index].content!,
                              style: const TextStyle(
                                  fontSize: 18, color: AppColor.textColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.notes[index].dateTimeEdited!,
                              style: const TextStyle(
                                  fontSize: 14, color: AppColor.textColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          controller.favoriteNote(controller.notes[index].id!);
                        },
                        child: Icon(
                          controller.notes[index].isFavorite == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget emptyNotes() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            height: 200,
            width: 200,
            image: AssetImage('assets/no_notes1.png'),
          ),
          Text(
            "یەکەم تێبینی خۆت دروست بکە!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
