import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_merojob/components/build_drawer.dart';
import 'package:flutter_merojob/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OfflineCoursesScreen extends StatefulWidget {
  const OfflineCoursesScreen({Key? key}) : super(key: key);

  @override
  _OfflineCoursesScreenState createState() => _OfflineCoursesScreenState();
}

class _OfflineCoursesScreenState extends State<OfflineCoursesScreen> {
  ReceivePort _receivePort = ReceivePort();
  static downloadingCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName(port_name)!;

    sendPort.send([id, status, progress]);
  }

  List<String> urls = [
    "https://drive.google.com/file/d/1zFK8j2tqR5-GZHIAhUD_qHXL5nT1u4hb/view?usp=sharing", //1st notepad
    "https://drive.google.com/file/d/11riBhyCipX-k6vfgVuD4O_PMozvx--_A/view?usp=sharing", //2nd pdf
    "https://drive.google.com/file/d/1BKjmbx6oUVNg1ERz4goBhS0LID2NK6iu/view?usp=sharing", //3rd notepad
    "https://drive.google.com/file/d/1Pd-g3AIImRwOL_OdA7CdeCRe5rWs6XBt/view?usp=sharing", // 4th pdf
    "https://drive.google.com/file/d/1Lcr15WnhrLtzPoLNsjv2rhPSwJsBUc4a/view?usp=sharing", //5th notepad
  ];

  List<String> urlForFile = [
    "/assets/files/1st.txt", //1st notepad
    "/assets/files/2nd.pdf", //2nd pdf
    "/assets/files/3rd.txt", //3rd notepad
    "/assets/files/4th.pdf", // 4th pdf
    "/assets/files/5th.txt", //5th notepad
  ];

  List<String> fileNames = [
    "Cover letter.txt",
    "Lorem story.pdf",
    "Dummy text.txt",
    "Lorem text.pdf",
    "Variation.txt"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IsolateNameServer.registerPortWithName(_receivePort.sendPort, port_name);

    _receivePort.listen((message) {});

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Courses"),
        centerTitle: true,
      ),
      drawer: BuildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          child: ListView.builder(
            itemCount: urls.length,
            itemBuilder: (context, index) {
              return buildFileDownloadTile(fileNames[index], urls[index]);
            },
            shrinkWrap: true,
            primary: false,
          ),
        ),
      ),
    );
  }

  Future<bool> checkPermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Card buildFileDownloadTile(String fileName, String url) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fileName,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (await checkPermission()) {
                  final externalDirectory = await getExternalStorageDirectory();
                  final taskID = await FlutterDownloader.enqueue(
                    url: url,
                    savedDir: externalDirectory!.path,
                    fileName: fileName,
                    showNotification: true,
                    openFileFromNotification: true,
                  );
                }
              },
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
