import 'package:armoyu/Utilities/Import&Export/export.dart';

// class VideoFullscreen extends StatefulWidget {
//   final VideoPlayerController controller;

//   const VideoFullscreen({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   State<VideoFullscreen> createState() => _VideoFullscreenState();
// }

// class _VideoFullscreenState extends State<VideoFullscreen> {
//   @override
//   Widget build(BuildContext context) {
//     getVideoPosition() {
//       var duration = Duration(
//           milliseconds:
//               widget.controller.value.duration.inMilliseconds.round());
//       return [duration.inMinutes, duration.inSeconds]
//           .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
//           .join(':');
//     }

//     final size = widget.controller.value.size;
//     final width = size.width;
//     final height = size.height;

//     return widget.controller.value.isInitialized
//         ? Scaffold(
//             body: Container(
//               alignment: Alignment.topCenter,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   FittedBox(
//                     fit: BoxFit.cover,
//                     child: SizedBox(
//                       width: width,
//                       height: height,
//                       child: Stack(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 isPlay = !isPlay;
//                                 widget.controller.value.isPlaying
//                                     ? widget.controller.pause()
//                                     : widget.controller.play();
//                               });
//                             },
//                             child: AspectRatio(
//                               aspectRatio: widget.controller.value.aspectRatio,
//                               child: VideoPlayer(widget.controller),
//                             ),
//                           ),
//                           Visibility(
//                             visible: !widget.controller.value.isPlaying,
//                             child: InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   isPlay = !isPlay;
//                                   widget.controller.value.isPlaying
//                                       ? widget.controller.pause()
//                                       : widget.controller.play();
//                                 });
//                               },
//                               child: CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.black.withOpacity(0.7),
//                                 child: const Icon(
//                                   Icons.play_arrow,
//                                   size: 48,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 5,
//                             left: 5,
//                             right: 5,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.black.withOpacity(0.7),
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   padding: const EdgeInsets.all(3),
//                                   child: Text(
//                                     getVideoPosition(),
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       isMusicOn = !isMusicOn;
//                                       isMusicOn == false
//                                           ? widget.controller.setVolume(0)
//                                           : widget.controller.setVolume(1);
//                                     });
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.black.withOpacity(0.5),
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     padding: const EdgeInsets.all(3),
//                                     child: Icon(
//                                       isMusicOn
//                                           ? Icons.volume_up
//                                           : Icons.volume_off,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth / 50),
//                                 InkWell(
//                                   onTap: () {},
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.black.withOpacity(0.5),
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     padding: const EdgeInsets.all(3),
//                                     child: Icon(
//                                       isFullScreen
//                                           ? Icons.close_fullscreen
//                                           : Icons.open_in_full,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : const Center(
//             child: CircularProgressIndicator(),
//           );
//   }
// }

///////////////////////////////////////

class VideoFullscreen extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoFullscreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: buildVideo(),
        )
      : const Center(
          child: CircularProgressIndicator(),
        );

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
