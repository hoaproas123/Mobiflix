import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobi_phim/constant/app_interger.dart';
import 'package:mobi_phim/constant/app_string.dart';
import 'package:video_player/video_player.dart';

class CustomControls extends StatefulWidget {
  final VideoPlayerController controller;
  final Function() onBack;
  final Function() onNextEpisode;
  final Function(int value) onShowEpisodeList;
  final String title;
  final bool canNext;
  final List<String> listNameOfEpisodes;
  final int currentEpisode;

  const CustomControls({
    super.key,
    required this.controller,
    required this.onBack,
    required this.onNextEpisode,
    required this.onShowEpisodeList,
    required this.title,
    required this.canNext,
    required this.listNameOfEpisodes,
    required this.currentEpisode,
  });

  @override
  _CustomControlsState createState() => _CustomControlsState();
}

class _CustomControlsState extends State<CustomControls> {
  bool _isVisible = true; // Điều khiển hiển thị/ẩn
  Timer? _hideTimer;
  double _volume = 1.0; // Mức âm lượng
  bool _isAdjustingVolume = false; // Cờ để kiểm tra có đang chỉnh âm lượng không
  Duration _seekOffset = Duration.zero; // Hiển thị thời gian tua khi vuốt ngang
  bool _isSeeking = false; // Kiểm tra có đang tua không

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel(); // Hủy bộ đếm thời gian trước đó (nếu có)
    _hideTimer = Timer(const Duration(seconds: AppNumber.NUMBER_OF_DURATION_COUNTDOWN_HIDE_BUTTON_ON_PLAY_VIDEO_SECONDS), () {
      if (mounted) {
        setState(() {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
          _isVisible = false; // Ẩn điều khiển sau 5 giây
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _isVisible = !_isVisible;
    });

    if (_isVisible) {
      _startHideTimer(); // Bắt đầu lại bộ đếm thời gian nếu điều khiển hiển thị
    }
  }
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isAdjustingVolume = true;
      _volume -= details.primaryDelta! / 100; // Giảm volume khi kéo xuống
      _volume = _volume.clamp(0.0, 1.0);
      widget.controller.setVolume(_volume);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _isAdjustingVolume = false;
    });
    _startHideTimer();
  }

  void _seekToPosition(double tapPosition) {
    setState(() {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final double screenWidth = box.size.width;

      final Duration videoDuration =
          widget.controller.value.duration;
      final Duration newPosition =
      Duration(milliseconds: (tapPosition / screenWidth * videoDuration.inMilliseconds).toInt());

      widget.controller.seekTo(newPosition);
      _startHideTimer(); // Ẩn controls sau 5 giây
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isSeeking = true;
      double dragAmount = details.primaryDelta ?? 0;
      int seekSeconds = (dragAmount * 0.2).toInt(); // Điều chỉnh độ nhạy tua
      _seekOffset += Duration(seconds: seekSeconds);

    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_isSeeking) {
      final currentPosition =
          widget.controller.value.position;
      final newPosition = currentPosition + _seekOffset;

      widget.controller.seekTo(newPosition);
      setState(() {
        _isSeeking = false;
      });
      _startHideTimer();
    }
  }
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$minutes:$seconds";
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lớp GestureDetector bao toàn bộ màn hình
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // Quan trọng để bắt sự kiện trên toàn màn hình
            onTap: _toggleControls,
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: IgnorePointer(
              ignoring: !_isVisible,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: AppNumber.NUMBER_OF_DURATION_OPACITY_BUTTON_ON_PLAY_VIDEO_MILLISECONDS),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Nút Back (trở về trang trước)
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                            onPressed: widget.onBack,
                          ),
                          const SizedBox(width: 30,),
                          Text(widget.title,style: const TextStyle(color: Colors.white,fontSize: 20),),
                        ],
                      ),
                    ),
                    // Hiển thị mức âm lượng khi điều chỉnh
                    if (_isAdjustingVolume)
                      Positioned(
                        top: 50,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.volume_up, color: Colors.white, size: 30),
                              Text(
                                '${(_volume * 100).toInt()}%',
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Nút tua lùi, play/pause, tua nhanh
                    Positioned(
                      child: SizedBox(
                        width: context.width,
                        height: context.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                widget.controller.value.isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: Colors.white,
                                size: 50,
                              ),
                              onPressed: () {
                                if (widget.controller.value.isPlaying) {
                                  widget.controller.pause();
                                } else {
                                  widget.controller.play();
                                }
                                setState(() {});
                                _startHideTimer(); // Reset timer khi người dùng thao tác
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Nút danh sách tập phim và chuyển tập tiếp theo
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        children: [
                          DropdownButton<int>(
                            iconDisabledColor: Colors.red,
                            borderRadius: BorderRadius.zero,
                            dropdownColor: Colors.black,
                            elevation: 0,
                            hint: const Text(AppString.LIST_EPISODE_BUTTON,style: TextStyle(color: Colors.white)),
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.list,
                                color: Colors.white,
                                size: 30,),
                            ),
                            items: List.generate(widget.listNameOfEpisodes.length, (item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                enabled: item == widget.currentEpisode ? false : true,
                                child: Text(widget.listNameOfEpisodes[item],style: TextStyle(color: item == widget.currentEpisode ? Colors.white :Colors.grey.withOpacity(0.5))),
                              );
                            },),
                            onChanged: (int? newValue) {
                              widget.onShowEpisodeList(newValue!);
                              _startHideTimer(); // Reset timer khi người dùng thao tác
                            },
                          ),
                          widget.canNext == false ?
                          const SizedBox()
                            :
                          TextButton(
                            onPressed: () {
                              widget.onNextEpisode();
                              _startHideTimer(); // Reset timer khi người dùng thao tác
                            },
                            style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.skip_next_sharp,
                                  color: Colors.white,
                                  size: 30,),
                                SizedBox(width: 5,),
                                Text(AppString.NEXT_EPISODE_BUTTON,style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Thanh tua phim có thể nhấn và kéo để tua
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent, // Bắt sự kiện nhấn trên toàn bộ vùng
                        onTapDown: (TapDownDetails details) {
                          _seekToPosition(details.localPosition.dx);
                        },
                        onHorizontalDragUpdate: (DragUpdateDetails details) {
                          _seekToPosition(details.localPosition.dx);
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 40,),
                            VideoProgressIndicator(
                              widget.controller,
                              allowScrubbing: true, // Cho phép kéo để tua
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              colors: const VideoProgressColors(
                                playedColor: Colors.white,
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.black38,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(widget.controller.value.position), // Thời gian hiện tại
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                  Text(
                                    _formatDuration(widget.controller.value.duration), // Tổng thời gian phim
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}