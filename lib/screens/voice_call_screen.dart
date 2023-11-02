import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VoiceCallScreen extends StatelessWidget {
  const VoiceCallScreen({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 167817904, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: "d2c14adad36ef21a4c2b094d38548b3ec4089de371351b965dc17cff309352de", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: "quanghuy",
      userName: "quanghuy1",
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
