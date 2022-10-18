import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_sdk/zoom_options.dart';
import 'package:flutter_zoom_sdk/zoom_view.dart';
import 'package:gk/utils/constants/colors.constant.dart';
import 'package:gk/view/basewidget/custom-button.widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JoinMeeting extends StatefulWidget {
  JoinMeeting({Key? key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  ZoomOptions zoomOptions = ZoomOptions(
    domain: "zoom.us",
    appKey: dotenv.env['ZOOM_APP_KEY'],
    appSecret: dotenv.env['ZOOM_APP_SECRET'],
  );

  ZoomMeetingOptions meetingOptions = ZoomMeetingOptions(
      userId: 'User First',
      meetingId: dotenv.env['ZOOM_MEETING_ID'],
      meetingPassword: dotenv.env['ZOOM_MEETING_PASSWORD'],
      disableDialIn: "true",
      disableDrive: "true",
      disableInvite: "true",
      disableShare: "true",
      noAudio: "false",
      noDisconnectAudio: "false");

  Timer? timer;

  var zoom = ZoomView();

  bool isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid) {
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    } else {
      result = status == "MEETING_STATUS_IDLE";
    }

    return result;
  }

  connect() async {
    var phoneStatus = await Permission.phone.request();
    var cameraStatus = await Permission.camera.request();
    var bluetoothStatus = await Permission.bluetooth.request();
    var bluetoothConnectStatus = await Permission.bluetoothConnect.request();
    if (phoneStatus == PermissionStatus.granted &&
        bluetoothStatus == PermissionStatus.granted &&
        bluetoothConnectStatus == PermissionStatus.granted &&
        cameraStatus == PermissionStatus.granted) {
      debugPrint("Connecting....");
      zoom.initZoom(zoomOptions).then((results) {
        debugPrint("Result : $results");
        if (results[0] == 0) {
          zoom.onMeetingStatus().listen((status) {
            debugPrint("Meeting Status Stream : $status");
            if (isMeetingEnded(status[0])) {
              debugPrint("Meeting Status :- Ended");
              timer!.cancel();
            }
          });
          debugPrint("listen on event channel");
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            timer = Timer.periodic(const Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
                debugPrint("Meeting Status Polling: $status");
              });
            });
          });
        }
      }).catchError((error) {
        debugPrint("Error Generated : $error");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting'),
      ),
      body: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CustomButton(
            //   text: "Connect",
            //   color: AppColors.appColor,
            //   width: 30.w,
            //   onPressed: () async {
            //     debugPrint("Connect Pressed");
            //     var phoneStatus = await Permission.phone.request();
            //     var cameraStatus = await Permission.camera.request();
            //     var bluetoothStatus = await Permission.bluetooth.request();
            //     var bluetoothConnectStatus =
            //         await Permission.bluetoothConnect.request();
            //     if (phoneStatus == PermissionStatus.granted &&
            //         bluetoothStatus == PermissionStatus.granted &&
            //         bluetoothConnectStatus == PermissionStatus.granted &&
            //         cameraStatus == PermissionStatus.granted) {
            //       debugPrint("Phone Status: $phoneStatus");
            //       connect();
            //     }
            //   },
            // ),
            // SizedBox(height: 2.h),
            // CustomButton(
            //   text: "Disconnect",
            //   color: AppColors.appColor,
            //   width: 30.w,
            // ),
          ],
        ),
      ),
    );
  }
}
