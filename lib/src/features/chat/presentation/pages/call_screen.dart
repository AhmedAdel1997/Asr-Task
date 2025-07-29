import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/extensions/text_style_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/res/color_manager.dart';
import '../../../../core/navigation/navigator.dart';

const appId = "22be7313c61e40b780942145e0cae3b2";
const token =
    "007eJxTYPC5zB2ilffmbJrJ7Cc1fBo3llhM3X+K9cm0PTtbTMKFk+coMBgZJaWaGxsaJ5sZppoYJJlbGFiaGBmamKYaJCemGicZyf7syGgIZGSYuHEGKyMDBIL4XAyOGbmpKbohqcUlDAwA9w4hUA==";
const channel = "Ahmed-Test";

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _isMicEnabled = true;
  bool _isCameraEnabled = true;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  // Toggle microphone
  Future<void> _toggleMic() async {
    setState(() {
      _isMicEnabled = !_isMicEnabled;
    });

    if (_isMicEnabled) {
      await _engine.enableAudio();
    } else {
      await _engine.disableAudio();
    }
  }

  // Toggle camera
  Future<void> _toggleCamera() async {
    setState(() {
      _isCameraEnabled = !_isCameraEnabled;
    });

    if (_isCameraEnabled) {
      await _engine.enableVideo();
      await _engine.startPreview();
    } else {
      await _engine.disableVideo();
    }
  }

  // End call
  Future<void> _endCall() async {
    await _dispose();
    Go.back();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 64.h,
        title: Text(
          'Call',
          style: const TextStyle().setH1SemiBold,
        ),
        leading: IconButton(
          onPressed: () {
            Go.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradient,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100.w,
              height: 150.h,
              child: _localUserJoined && _isCameraEnabled
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                  : _localUserJoined && !_isCameraEnabled
                      ? Container(
                          width: 100.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.videocam_off,
                            color: Colors.grey[600],
                            size: 32.sp,
                          ),
                        )
                      : const CircularProgressIndicator(),
            ),
          ),
          // Control buttons at bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mic toggle button
                  Container(
                    decoration: BoxDecoration(
                      color: _isMicEnabled ? AppColors.primary : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _toggleMic,
                      icon: Icon(
                        _isMicEnabled ? Icons.mic : Icons.mic_off,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      iconSize: 24.sp,
                    ),
                  ),
                  20.szW,
                  // Camera toggle button
                  Container(
                    decoration: BoxDecoration(
                      color: _isCameraEnabled ? AppColors.primary : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _toggleCamera,
                      icon: Icon(
                        _isCameraEnabled ? Icons.videocam : Icons.videocam_off,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      iconSize: 24.sp,
                    ),
                  ),
                  20.szW,
                  // End call button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _endCall,
                      icon: Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      iconSize: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.images.firstBg.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000.r),
              child: AppAssets.images.formalPhotoCropped.image(
                width: 150.w,
                height: 150.h,
                fit: BoxFit.fill,
              ),
            ),
            16.szH,
            Text(
              'Please wait for Ahmed Adel to join',
              textAlign: TextAlign.center,
              style: const TextStyle().setH2SemiBold.setWhiteColor,
            ),
          ],
        ),
      );
    }
  }
}
