import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 167817904,
      appSign: "d2c14adad36ef21a4c2b094d38548b3ec4089de371351b965dc17cff309352de",
      userID: "dustyfate",
      userName: "dustyfate1",
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.s
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
