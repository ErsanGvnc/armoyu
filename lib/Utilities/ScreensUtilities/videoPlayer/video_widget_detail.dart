// ignore_for_file: library_private_types_in_public_api

import 'package:armoyu/Utilities/Import&Export/export.dart';

class VideoWidgetDetail extends StatefulWidget {
  final String url;
  final bool play;

  const VideoWidgetDetail({Key? key, required this.url, required this.play})
      : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidgetDetail> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _controller.setVolume(0);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      isIconShow = false;
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoWidgetDetail oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getVideoPosition() {
    var duration = Duration(
        milliseconds: _controller.value.duration.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    isIconShow = !isIconShow;
                  });
                  _controller.value.isPlaying
                      ? await Future.delayed(const Duration(seconds: 3)).then(
                          (value) {
                            _controller.value.isPlaying
                                ? isIconShow = false
                                : null;
                          },
                        )
                      : null;
                  setState(() {});
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(
                    _controller,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isIconShow ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Visibility(
                  visible: isIconShow,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isPlay = !isPlay;
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                      _controller.value.isPlaying
                          ? await Future.delayed(const Duration(seconds: 1))
                              .then(
                              (value) {
                                isIconShow = false;
                              },
                            )
                          : null;
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black.withOpacity(0.7),
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 5,
                right: 5,
                child: AnimatedOpacity(
                  opacity: isIconShow ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              getVideoPosition(),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isMusicOn = !isMusicOn;
                                isMusicOn == false
                                    ? _controller.setVolume(0)
                                    : _controller.setVolume(1);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                isMusicOn ? Icons.volume_up : Icons.volume_off,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth / 50),
                          InkWell(
                            onTap: () {
                              // setState(() {
                              //   isFullScreen = !isFullScreen;
                              // });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => VideoLandscape(
                              //       play: true,
                              //       url: widget.url,
                              //     ),
                              //   ),
                              // ).whenComplete(
                              //   () => setState(() {
                              //     isFullScreen = !isFullScreen;
                              //   }),
                              // );
                              setState(() {
                                isFullScreen = !isFullScreen;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoFullscreen(
                                    controller: _controller,
                                  ),
                                ),
                              ).whenComplete(
                                () => setState(() {
                                  isFullScreen = !isFullScreen;
                                }),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                isFullScreen
                                    ? Icons.close_fullscreen
                                    : Icons.open_in_full,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isIconShow,
                        child: VideoProgressIndicator(
                          _controller,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.white,
                            bufferedColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

          // diğer tasarım.

          // return Stack(
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         isPlay = !isPlay;
          //         _controller.value.isPlaying
          //             ? _controller.pause()
          //             : _controller.play();
          //         setState(() {});
          //       },
          //       child: AspectRatio(
          //         aspectRatio: _controller.value.aspectRatio,
          //         child: VideoPlayer(
          //           _controller,
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       top: 5,
          //       right: 5,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.black.withOpacity(0.5),
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //         padding: const EdgeInsets.all(3),
          //         child: Lottie.asset(
          //           "assets/animations/sound.json",
          //           // controller: _animationController,
          //           animate: _controller.value.isPlaying ? true : false,
          //           repeat: true,
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       bottom: 5,
          //       left: 5,
          //       right: 5,
          //       child: Column(
          //         children: [
          //           VideoProgressIndicator(
          //             _controller,
          //             padding: const EdgeInsets.symmetric(vertical: 5),
          //             allowScrubbing: true,
          //             colors: const VideoProgressColors(
          //               playedColor: Colors.white,
          //               bufferedColor: Colors.grey,
          //             ),
          //           ),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     isPlay = !isPlay;
          //                     isPlay == false
          //                         ? _controller.pause()
          //                         : _controller.play();
          //                   });
          //                 },
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                     color: Colors.black.withOpacity(0.5),
          //                     borderRadius: BorderRadius.circular(30),
          //                   ),
          //                   padding: const EdgeInsets.all(3),
          //                   child: Icon(
          //                     isPlay ? Icons.pause : Icons.play_arrow,
          //                   ),
          //                 ),
          //               ),
          //               const Spacer(),
          //               Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.black.withOpacity(0.5),
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 padding: const EdgeInsets.all(3),
          //                 child: Text(
          //                   "00:00 / ${getVideoPosition()}",
          //                 ),
          //               ),
          //               SizedBox(width: screenWidth / 50),
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     isMusicOn = !isMusicOn;
          //                     isMusicOn == false
          //                         ? _controller.setVolume(0)
          //                         : _controller.setVolume(1);
          //                   });
          //                 },
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                     color: Colors.black.withOpacity(0.5),
          //                     borderRadius: BorderRadius.circular(30),
          //                   ),
          //                   padding: const EdgeInsets.all(3),
          //                   child: Icon(
          //                     isMusicOn ? Icons.volume_up : Icons.volume_off,
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(width: screenWidth / 50),
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     isFullScreen = !isFullScreen;
          //                     // isFullScreen == false
          //                     //     ? _controller.setVolume(0)
          //                     //     : _controller.setVolume(1);
          //                   });
          //                 },
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                     color: Colors.black.withOpacity(0.5),
          //                     borderRadius: BorderRadius.circular(30),
          //                   ),
          //                   padding: const EdgeInsets.all(3),
          //                   child: Icon(
          //                     isFullScreen
          //                         ? Icons.close_fullscreen
          //                         : Icons.open_in_full,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );

          // return VideoPlayer(_controller);
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
