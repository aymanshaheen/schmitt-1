import 'package:flutter/material.dart';
import 'package:schmitt/src/config/agora_config.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/features/inbox/domain/entities/call.dart';

class CallScreen extends StatefulWidget {
  final String channelId;
  final Call call;

  const CallScreen({super.key, required this.channelId, required this.call});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
/*  AgoraClient? client;
  String baseUrl = '';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*client == null
          ?*/ CircularIndicator(
              color: AppColors.darkBlue,
            )
          /*: SafeArea(
              child: Stack(
              children: [
                AgoraVideoViewer(client: client!),
                AgoraVideoButtons(client: client!),
              ],
            )),*/
    );
  }
}
