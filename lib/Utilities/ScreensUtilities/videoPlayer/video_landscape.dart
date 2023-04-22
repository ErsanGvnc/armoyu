import 'package:armoyu/Utilities/Import&Export/export.dart';

class VideoLandscape extends StatefulWidget {
  final String url;
  final bool play;

  const VideoLandscape({Key? key, required this.url, required this.play})
      : super(key: key);

  @override
  State<VideoLandscape> createState() => _VideoLandscapeState();
}

class _VideoLandscapeState extends State<VideoLandscape> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());

    setLandscape();
  }

  @override
  void dispose() {
    controller.dispose();
    setDefault();

    super.dispose();
  }

  Future setLandscape() async {
    // print("setLandscape");
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // await SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: []);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

  Future setDefault() async {
    // print("setDefault");
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // await SystemChrome.setEnabledSystemUIMode(SystemUiOverlay.values);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    await Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) => VideoFullscreen(controller: controller);
}
