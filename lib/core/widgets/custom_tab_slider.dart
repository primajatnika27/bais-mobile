import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTabSlider extends StatefulWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTap;
  bool showMenu;
  final Function(bool)? didMenuShow; // Made optional by adding "?"

  CustomTabSlider({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    this.showMenu = false,
    this.didMenuShow,
  });

  @override
  State<CustomTabSlider> createState() => _CustomTabSliderState();
}

class _CustomTabSliderState extends State<CustomTabSlider> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(covariant CustomTabSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _scrollToCurrentIndex();
    }
  }

  void _scrollToCurrentIndex() {
    const tabWidth = 150.0;
    const separatorWidth = 45.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = (tabWidth + separatorWidth) * widget.currentIndex -
        (screenWidth - tabWidth) / 2;
    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleMenu(bool show) {
    setState(() {
      widget.showMenu = show;
    });

    // Call the didMenuShow callback with the updated state
    if (widget.didMenuShow != null) {
      widget.didMenuShow!(widget.showMenu);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onLongPress: () {
            _toggleMenu(true);
          },
          child: Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.border300,
                  width: 1,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  children: List.generate(widget.tabs.length * 2 - 1, (index) {
                    if (index.isOdd) {
                      return SizedBox(
                        width: 45,
                        child: CustomPaint(
                          size: const Size(40, 1),
                          painter: DashedLinePainter(),
                        ),
                      );
                    }
                    final tabIndex = index ~/ 2;
                    return SizedBox(
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          widget.onTap(tabIndex);
                          _toggleMenu(false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.currentIndex >= tabIndex
                                    ? AppTheme.primary
                                    : HexColor('#E0E3E8'),
                              ),
                              child: tabIndex < widget.currentIndex
                                  ? SvgPicture.asset(
                                'assets/icons/ic_check_tab.svg',
                                width: 16,
                                height: 16,
                                fit: BoxFit.scaleDown,
                              )
                                  : Center(
                                child: Text(
                                  '${tabIndex + 1}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor('#FCFCFD'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                widget.tabs[tabIndex],
                                style: TextStyle(
                                  color: widget.currentIndex >= tabIndex
                                      ? HexColor('#142A5B')
                                      : HexColor('#E0E3E8'),
                                  fontWeight: widget.currentIndex == tabIndex
                                      ? FontWeight.w500
                                      : FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        if (widget.showMenu)
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.onTap(index);
                  _toggleMenu(false);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${index + 1} ${widget.tabs[index]}"),
                      if (widget.currentIndex == index)
                        const Icon(
                          Icons.check,
                          color: AppTheme.primary,
                        ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: widget.tabs.length,
          ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = HexColor('#E0E3E8')
      ..strokeWidth = 1;

    const dashWidth = 8.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
