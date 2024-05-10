import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/note_controller.dart';
import '../widgets/toast.dart';

class AddNewNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.titleController.text = "";
    controller.contentController.text = "";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "تێبینی نوێ زیادکە",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller.titleController,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "ناونیشان",
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColor.hintColor,
                    ),
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                ),
                TextField(
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                  controller: controller.contentController,
                  decoration: const InputDecoration(
                    hintText: "لێرەدا تێبینی بنووسە...",
                    hintStyle: TextStyle(
                      fontSize: 22,
                      color: AppColor.hintColor,
                    ),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.titleController.text.isEmpty) {
              showToast(message: "ناونیشانی تێبینی بەتاڵە");
            } else if (controller.contentController.text.isEmpty) {
              showToast(message: "باسکردنی تێبینی بەتاڵە");
            } else {
              controller.addNoteToDatabase();
            }
          },
          label: const Text(
            "غەزنکردن",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          icon: const Icon(
            Icons.save,
          ),
          backgroundColor: AppColor.buttonColor,
        ),
      ),
    );
  }
}
