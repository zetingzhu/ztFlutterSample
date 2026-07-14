import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../widgets/app_button_circle.dart';

// 故事数据模型
class Story {
  final String id;
  final String title;
  final String coverUrl;
  final String description;
  final String content;
  final String audioUrl;
  final Color coverColor;

  Story({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.description,
    required this.content,
    required this.audioUrl,
    this.coverColor = const Color(0xFFFFE0B2),
  });
}

class ChildrenStoryPage extends StatefulWidget {
  const ChildrenStoryPage({super.key});

  @override
  State<ChildrenStoryPage> createState() => _ChildrenStoryPageState();
}

class _ChildrenStoryPageState extends State<ChildrenStoryPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _selectedIndex = 0;
  bool _isPlaying = false;

  final List<Story> _storyList = [
    Story(
      id: '1',
      title: '灵根育孕',
      coverUrl: '',
      description: '西游记 第一回',
      content: '灵根育孕源流出，心性修持大道生',
      audioUrl: 'audio/story_001.mp3',
      coverColor: const Color(0xFFFFCC80),
    ),
    Story(
      id: '2',
      title: '悟彻菩提',
      coverUrl: '',
      description: '西游记 第二回',
      content: '悟彻菩提真妙理，断魔归本合元神',
      audioUrl: 'audio/story_002.mp3',
      coverColor: const Color(0xFFEF9A9A),
    ),
    Story(
      id: '3',
      title: '四海千山',
      coverUrl: '',
      description: '西游记 第三回',
      content: '四海千山皆拱伏，九幽十类尽除名',
      audioUrl: 'audio/story_003.mp3',
      coverColor: const Color(0xFFFFAB91),
    ),
    Story(
      id: '4',
      title: '官封弼马',
      coverUrl: '',
      description: '西游记 第四回',
      content: '官封弼马心何足，名注齐天意未宁',
      audioUrl: 'audio/story_004.mp3',
      coverColor: const Color(0xFF80CBC4),
    ),
    Story(
      id: '5',
      title: '乱蟠桃',
      coverUrl: '',
      description: '西游记 第五回',
      content: '乱蟠桃大圣偷丹，反天宫诸神捉怪',
      audioUrl: 'audio/story_005.mp3',
      coverColor: const Color(0xFF81D4FA),
    ),
    Story(
      id: '6',
      title: '小圣降妖',
      coverUrl: '',
      description: '西游记 第六回',
      content: '观音赴会问原因，小圣施威降大圣',
      audioUrl: 'audio/story_006.mp3',
      coverColor: const Color(0xFFCE93D8),
    ),
  ];

  Story get _currentStory => _storyList[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  /// Web 推荐使用 mp3；路径避免中文/空格。
  Source _audioSource(String path) {
    return AssetSource(path, mimeType: 'audio/mpeg');
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      return;
    }

    // 暂停后继续播，避免每次从头开始
    if (_audioPlayer.state == PlayerState.paused) {
      await _audioPlayer.resume();
      return;
    }

    try {
      await _audioPlayer.play(_audioSource(_currentStory.audioUrl));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('播放失败：$e')),
      );
    }
  }

  Future<void> _playPrevious() async {
    if (_selectedIndex <= 0) return;
    setState(() => _selectedIndex -= 1);
    await _audioPlayer.stop();
    await _audioPlayer.play(_audioSource(_currentStory.audioUrl));
  }

  Future<void> _playNext() async {
    if (_selectedIndex >= _storyList.length - 1) return;
    setState(() => _selectedIndex += 1);
    await _audioPlayer.stop();
    await _audioPlayer.play(_audioSource(_currentStory.audioUrl));
  }

  Future<void> _onSelectStory(int index) async {
    if (index == _selectedIndex && _isPlaying) return;
    setState(() => _selectedIndex = index);
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6E8),
      body: Column(
        children: [
          const _StoryHeader(),
          Expanded(
            child: Column(
              children: [
                /*中间列表视图*/
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Column(
                      children: [
                        _StoryGrid(
                          stories: _storyList,
                          selectedIndex: _selectedIndex,
                          onSelect: _onSelectStory,
                        ),
                        const SizedBox(height: 16),
                        _StoryPreviewBanner(story: _currentStory),
                      ],
                    ),
                  ),
                ),

                /*下方播放视图*/
                _StoryBottomBar(
                  isPlaying: _isPlaying,
                  onPrevious: _playPrevious,
                  onPlayPause: _togglePlay,
                  onNext: _playNext,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 顶部粉色标题栏（波浪底边）
class _StoryHeader extends StatelessWidget {
  const _StoryHeader();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ScallopBottomClipper(),
      child: Container(
        width: double.infinity,
        color: const Color(0xFFFF9AA2),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 28),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD54F),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.face, color: Colors.white, size: 28),
                  Positioned(
                    top: 2,
                    right: 4,
                    child: Icon(Icons.eco, color: Color(0xFF66BB6A), size: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B4A),
                  borderRadius: BorderRadius.circular(24),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: const Color(0xFFFF6B4A).withValues(alpha: 0.35),
                  //     blurRadius: 8,
                  //     offset: const Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: const Text(
                  '儿童故事屋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD54F),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search, color: Colors.white, size: 26),
            ),
          ],
        ),
      ),
    );
  }
}

/// 故事网格（3 列）
class _StoryGrid extends StatelessWidget {
  const _StoryGrid({
    required this.stories,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<Story> stories;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final story = stories[index];
        final selected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFFFF6B4A)
                          : const Color(0xFFFFE082),
                      width: selected ? 3 : 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: story.coverColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.auto_stories,
                        size: 36,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                story.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? const Color(0xFFFF6B4A)
                      : const Color(0xFF5D4037),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 中间故事预览条
class _StoryPreviewBanner extends StatelessWidget {
  const _StoryPreviewBanner({required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: story.coverColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.face, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              story.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037)),
            ),
          ),
        ],
      ),
    );
  }
}

/// 底部播放控制栏
class _StoryBottomBar extends StatelessWidget {
  const _StoryBottomBar({
    required this.isPlaying,
    required this.onPrevious,
    required this.onPlayPause,
    required this.onNext,
  });

  final bool isPlaying;
  final VoidCallback onPrevious;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return ClipPath(
      clipper: _ConvexTopClipper(),
      child: Container(
        width: double.infinity,
        color: const Color(0xFFB3E5FC),
        padding: EdgeInsets.fromLTRB(28, 36, 28, 16 + bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButtonCircle(
              size: 56,
              color: const Color(0xFFFFD54F),
              icon: Icons.skip_previous,
              onTap: onPrevious,
            ),
            _PlayPauseButton(isPlaying: isPlaying, onTap: onPlayPause),
            AppButtonCircle(
              size: 56,
              color: const Color(0xFFFFD54F),
              icon: Icons.skip_next,
              onTap: onNext,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.isPlaying, required this.onTap});

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 92,
        height: 92,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 92,
              height: 92,
              alignment: Alignment.center,
              // 文本在圆内水平垂直居中
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B4A),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFD54F), width: 6),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B4A).withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                '播放\n暂停',
                textAlign: TextAlign.center,
                // 去掉首行顶部额外留白、末行底部额外留白，避免「上紧下松」
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 2,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 6,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD54F),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 12,
                  color: const Color(0xFFFF6B4A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 顶部栏波浪底边
class _ScallopBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const waveWidth = 18.0;
    const waveHeight = 8.0;
    final path = Path()..lineTo(0, size.height - waveHeight);

    var x = 0.0;
    final midY = size.height - waveHeight;
    while (x < size.width) {
      path.quadraticBezierTo(
        x + waveWidth / 2,
        size.height,
        x + waveWidth,
        midY,
      );
      x += waveWidth;
    }

    path
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// 底部栏向上凸起曲线
class _ConvexTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 28)
      ..quadraticBezierTo(size.width / 2, -8, size.width, 28)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
