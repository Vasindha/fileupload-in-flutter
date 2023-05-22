import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  List<XFile?>? image;
  String? url;

  Future<String> upload(List<XFile?> files1) async {
    var uri = Uri.parse("http://192.168.174.230:3000/upload");
    var request = http.MultipartRequest('POST', uri);
    for (var file in files1) {
      request.files
          .add(await http.MultipartFile.fromPath('uploadFile', file!.path));
    }

    var response = await request.send();
    String url = await response.stream.bytesToString();

    return url;
  }

  Future<String> selectFile() async {
    image = await ImagePicker().pickMultiImage(imageQuality: 20);

    String url = await upload(image!);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  url = await selectFile();
                  setState(() {
                    log(url!);
                  });
                },
                child: Text("upload"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
