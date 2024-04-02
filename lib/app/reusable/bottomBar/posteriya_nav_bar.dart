import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';






typedef PosteriyaNavBarButtonTappedCallback = void Function();
typedef PosteriyaNavBarChangeCallback = void Function(int selectedIndex);
typedef PosteriyaNavBarItemBuilder = Widget Function(PosteriyaNavBarIcon icon, PosteriyaNavBarItem item);


class LinearPointCurve extends Curve {
  final double pIn;
  final double pOut;

  const LinearPointCurve(this.pIn, this.pOut);

  @override
  double transform(double x) {
    final lowerScale = pOut / pIn;
    final upperScale = (1.0 - pOut) / (1.0 - pIn);
    final upperOffset = 1.0 - upperScale;
    return x < pIn ? x * lowerScale : x * upperScale + upperOffset;
  }
}



class PosteriyaNavBarIcon {
  final String? iconPath;
  final String? assetPath;
  final IconData? icon;
  final Color? selectedForegroundColor;
  final Color? unselectedForegroundColor;
  final Color? backgroundColor;
  final Map<String, dynamic>? extras;

  PosteriyaNavBarIcon({
    this.iconPath,
    this.assetPath,
    this.icon,
    this.selectedForegroundColor,
    this.unselectedForegroundColor,
    this.backgroundColor,
    this.extras,
  })  : assert(iconPath == null || assetPath == null || icon == null,
  'Cannot provide both an svgPath and an icon.'),
        assert(iconPath != null || assetPath != null || icon != null,
        'An svgPath or an icon must be provided.');
}

@immutable
class PosteriyaNavBarStyle with Diagnosticable {
  final Color? barBackgroundColor;
  final Color? iconBackgroundColor;
  final Color? iconSelectedForegroundColor;
  final Color? iconUnselectedForegroundColor;

  const PosteriyaNavBarStyle({
    this.barBackgroundColor,
    this.iconBackgroundColor,
    this.iconSelectedForegroundColor,
    this.iconUnselectedForegroundColor,
  });
}


class PosteriyaNavBar extends StatefulWidget {
  static const double nominalHeight = 56.0;
  final List<PosteriyaNavBarIcon> icons;
  final PosteriyaNavBarChangeCallback? onChange;
  final PosteriyaNavBarStyle? style;
  final double animationFactor;
  final double scaleFactor;
  final int defaultIndex;

  final PosteriyaNavBarItemBuilder itemBuilder;

  const PosteriyaNavBar(
      {Key? key,
      required this.icons,
      this.onChange,
      this.style,
      this.animationFactor = 1.0,
      this.scaleFactor = 1.2,
      this.defaultIndex = 0,
      PosteriyaNavBarItemBuilder? itemBuilder})
      : this.itemBuilder = itemBuilder ?? _identityBuilder,
        assert(icons.length > 1),
        super(key: key);

  @override
  State createState() => _PosteriyaNavBarState();

  static Widget _identityBuilder(PosteriyaNavBarIcon icon, PosteriyaNavBarItem item) => item;
}

class _PosteriyaNavBarState extends State<PosteriyaNavBar> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late final AnimationController _xController;
  late final AnimationController _yController;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.defaultIndex;

    _xController = AnimationController(vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _xController.value = _indexToPosition(_currentIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final appSize = MediaQuery.of(context).size;
    const height = PosteriyaNavBar.nominalHeight;

    return SizedBox(
      width: appSize.width,
      height: PosteriyaNavBar.nominalHeight,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: height,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: _buildButtons()),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return CustomPaint(
      painter: _BackgroundCurvePainter(
        _xController.value * MediaQuery.of(context).size.width,
        Tween<double>(
          begin: Curves.easeInExpo.transform(_yController.value),
          end: ElasticOutCurve(0.38).transform(_yController.value),
        ).transform(_yController.velocity.sign * 0.5 + 0.5),
        widget.style?.barBackgroundColor ?? Colors.white,
      ),
    );
  }

  List<Widget> _buildButtons() {
    return widget.icons
        .asMap()
        .entries
        .map(
          (entry) => widget.itemBuilder(
            entry.value,
            PosteriyaNavBarItem(
              entry.value.assetPath ?? entry.value.assetPath,
              entry.value.icon,
              _currentIndex == entry.key,
              () => _handleTap(entry.key),
              entry.value.selectedForegroundColor ?? widget.style?.iconSelectedForegroundColor ?? Colors.black,
              entry.value.unselectedForegroundColor ?? widget.style?.iconUnselectedForegroundColor ?? Colors.grey,
              entry.value.backgroundColor ??
                  widget.style?.iconBackgroundColor ??
                  widget.style?.barBackgroundColor ??
                  Colors.white,
              widget.scaleFactor,
              widget.animationFactor,
            ),
          ),
        )
        .toList();
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  double _indexToPosition(int index) {
    var buttonCount = widget.icons.length;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX + index.toDouble() * buttonsWidth / buttonCount + buttonsWidth / (buttonCount * 2.0);
  }

  void _handleTap(int index) {
    if (_currentIndex == index || _xController.isAnimating) return;

    setState(() {
      _currentIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(_indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 620) * widget.animationFactor);
    Future.delayed(
      const Duration(milliseconds: 500) * widget.animationFactor,
      () {
        _yController.animateTo(1.0, duration: const Duration(milliseconds: 1200) * widget.animationFactor);
      },
    );
    _yController.animateTo(0.0, duration: const Duration(milliseconds: 300) * widget.animationFactor);

    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }
}

class _BackgroundCurvePainter extends CustomPainter {
  static const _radiusTop = 54.0;
  static const _radiusBottom = 44.0;
  static const _horizontalControlTop = 0.6;
  static const _horizontalControlBottom = 0.5;
  static const _pointControlTop = 0.35;
  static const _pointControlBottom = 0.85;
  static const _topY = -10.0;
  static const _bottomY = 54.0;
  static const _topDistance = 0.0;
  static const _bottomDistance = 6.0;

  final double _x;
  final double _normalizedY;
  final Color _color;

  _BackgroundCurvePainter(double x, double normalizedY, Color color)
      : _x = x,
        _normalizedY = normalizedY,
        _color = color;

  @override
  void paint(canvas, size) {
    // Paint two cubic bezier curves using various linear interpolations based off of the `_normalizedY` value
    final norm = const LinearPointCurve(0.5, 2.0).transform(_normalizedY) / 2;

    final radius = Tween<double>(begin: _radiusTop, end: _radiusBottom).transform(norm);
    // Point colinear to the top edge of the background pane
    final anchorControlOffset =
        Tween<double>(begin: radius * _horizontalControlTop, end: radius * _horizontalControlBottom)
            .transform(const LinearPointCurve(0.5, 0.75).transform(norm));
    // Point that slides up and down depending on distance for the target x position
    final dipControlOffset = Tween<double>(begin: radius * _pointControlTop, end: radius * _pointControlBottom)
        .transform(const LinearPointCurve(0.5, 0.8).transform(norm));
    final y = Tween<double>(begin: _topY, end: _bottomY).transform(const LinearPointCurve(0.2, 0.7).transform(norm));
    final dist =
        Tween<double>(begin: _topDistance, end: _bottomDistance).transform(const LinearPointCurve(0.5, 0.0).transform(norm));
    final x0 = _x - dist / 2;
    final x1 = _x + dist / 2;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x0 - radius, 0)
      ..cubicTo(x0 - radius + anchorControlOffset, 0, x0 - dipControlOffset, y, x0, y)
      ..lineTo(x1, y)
      ..cubicTo(x1 + dipControlOffset, y, x1 + radius - anchorControlOffset, 0, x1 + radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    final paint = Paint()..color = _color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BackgroundCurvePainter oldPainter) {
    return _x != oldPainter._x || _normalizedY != oldPainter._normalizedY || _color != oldPainter._color;
  }
}



//==============================================================================
//              ** Nev Item  **
//==============================================================================


class PosteriyaNavBarItem extends StatefulWidget {
  static const nominalExtent = Size(64, 64);
  final String? assetPath;
  final IconData? icon;
  final bool selected;
  final Color selectedForegroundColor;
  final Color unselectedForegroundColor;
  final Color backgroundColor;
  final double scaleFactor;
  final PosteriyaNavBarButtonTappedCallback onTap;
  final double animationFactor;

  const PosteriyaNavBarItem(
      this.assetPath,
      this.icon,
      this.selected,
      this.onTap,
      this.selectedForegroundColor,
      this.unselectedForegroundColor,
      this.backgroundColor,
      this.scaleFactor,
      this.animationFactor, {super.key}
      )   : assert(scaleFactor >= 1.0),
        assert(assetPath == null || icon == null,
        'Cannot provide both an iconPath and an icon.'),
        assert(!(assetPath == null && icon == null),
        'An iconPath or an icon must be provided.');

  @override
  State createState() {
    return _PosteriyaNavBarItemState(selected);
  }
}

class _PosteriyaNavBarItemState extends State<PosteriyaNavBarItem>
    with SingleTickerProviderStateMixin {
  static const double _activeOffset = 16;
  static const double _defaultOffset = 0;
  static const double _iconSize = 25;

  bool _selected;

  late AnimationController _animationController;
  late Animation<double> _activeColorClipAnimation;
  late Animation<double> _yOffsetAnimation;
  late Animation<double> _activatingAnimation;
  late Animation<double> _inactivatingAnimation;

  _PosteriyaNavBarItemState(this._selected);

  @override
  void initState() {
    super.initState();

    double waveRatio = 0.28;
    _animationController = AnimationController(
      duration: Duration(milliseconds: (1600 * widget.animationFactor).toInt()),
      reverseDuration:
      Duration(milliseconds: (1000 * widget.animationFactor).toInt()),
      vsync: this,
    )..addListener(() => setState(() {}));

    _activeColorClipAnimation =
        Tween<double>(begin: 0.0, end: _iconSize).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.25, 0.38, curve: Curves.easeOut),
          reverseCurve: Interval(0.7, 1.0, curve: Curves.easeInCirc),
        ));

    var _animation = CurvedAnimation(
        parent: _animationController, curve: LinearPointCurve(waveRatio, 0.0));

    _yOffsetAnimation = Tween<double>(begin: _defaultOffset, end: _activeOffset)
        .animate(CurvedAnimation(
      parent: _animation,
      curve: ElasticOutCurve(0.38),
      reverseCurve: Curves.easeInCirc,
    ));

    var activatingHalfTween = Tween<double>(begin: 1, end: widget.scaleFactor);
    _activatingAnimation = TweenSequence([
      TweenSequenceItem(tween: activatingHalfTween, weight: 50.0),
      TweenSequenceItem(
          tween: ReverseTween<double>(activatingHalfTween), weight: 50.0),
    ]).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.0, 0.3),
    ));
    _inactivatingAnimation = ConstantTween<double>(1.0).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.3, 1.0),
    ));

    _startAnimation();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.selected != _selected) {
      setState(() {
        _selected = widget.selected;
      });
      _startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    const ne = PosteriyaNavBarItem.nominalExtent;

    final scaleAnimation =
    _selected ? _activatingAnimation : _inactivatingAnimation;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints.tight(ne),
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(ne.width / 2 - _iconSize),
          constraints: BoxConstraints.tight(const Size.square(_iconSize * 2)),
          decoration: ShapeDecoration(
            color: widget.backgroundColor,
            shape: const CircleBorder(),
          ),
          transform: Matrix4.translationValues(0, -_yOffsetAnimation.value, 0),
          child: Stack(children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: widget.icon == null
                  ? Image.asset(
                widget.assetPath!,
                color: widget.unselectedForegroundColor,
                width: _iconSize,
                height: _iconSize * scaleAnimation.value,
                colorBlendMode: BlendMode.srcIn,
              )
                  : Icon(
                widget.icon,
                color: widget.unselectedForegroundColor,
                size: _iconSize * scaleAnimation.value,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ClipRect(
                clipper: _SvgPictureClipper(
                    _activeColorClipAnimation.value * scaleAnimation.value),
                child: widget.icon == null
                    ? Image.asset(
                  widget.assetPath!,
                  color: widget.selectedForegroundColor,
                  width: _iconSize,
                  height: _iconSize * scaleAnimation.value,
                  colorBlendMode: BlendMode.srcIn,
                )
                    : Icon(
                  widget.icon,
                  color: widget.selectedForegroundColor,
                  size: _iconSize * scaleAnimation.value,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _startAnimation() {
    if (_selected) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
      _animationController.reverse();
    }
  }
}

class _SvgPictureClipper extends CustomClipper<Rect> {
  final double height;

  _SvgPictureClipper(this.height);

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(size.topLeft(Offset.zero),
        size.topRight(Offset.zero) + Offset(0, height));
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
