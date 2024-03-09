library rotate_expand_toolbar;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RotateExpandToolbar extends StatefulWidget {
  RotateExpandToolbar({
    super.key,
    this.expandIcon,
    this.iconSize = 32,
    this.color,
    this.space = 8,
    this.expandDuration = const Duration(milliseconds: 500),
    required this.children,
  });

  IconData? expandIcon;
  double iconSize;
  Color? color;
  double space;
  Duration expandDuration;
  List<RotateExpandToolbarItem> children;

  @override
  State<StatefulWidget> createState() => RotateExpandToolbarState();
}

class RotateExpandToolbarState extends State<RotateExpandToolbar>
    with TickerProviderStateMixin {
  bool expand = false;
  bool expaning = false;

  /// 手动控制动画的控制器
  late final AnimationController _manualController;

  /// 手动控制
  late final Animation<double> _manualAnimation;

  @override
  void initState() {
    super.initState();

    /// 不设置重复，使用代码控制进度，动画时间1秒
    _manualController = AnimationController(
      vsync: this,
      duration: widget.expandDuration,
    );
    _manualAnimation =
        Tween<double>(begin: 0, end: 1).animate(_manualController);
    _manualController.addStatusListener(onAnimationListener);
  }

  @override
  void dispose() {
    _manualController.removeStatusListener(onAnimationListener);
    _manualController.dispose();
    super.dispose();
  }

  void onAnimationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        expaning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    list.add(
      RotationTransition(
        turns: _manualAnimation,
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
              minWidth: widget.iconSize,
              minHeight: widget.iconSize,
              maxWidth: widget.iconSize,
              maxHeight: widget.iconSize),
          icon: Icon(widget.expandIcon ?? Icons.arrow_circle_right_outlined),
          iconSize: widget.iconSize,
          color: widget.color,
          onPressed: () {
            if (mounted && !expaning) {
              /// 获取动画当前的值
              var value = _manualController.value;

              /// 0.5代表 180弧度
              if (value == 0.5) {
                _manualController.animateTo(0);
              } else {
                _manualController.animateTo(0.5);
              }

              setState(() {
                expand = !expand;
                expaning = true;
              });
            }
          },
        ),
      ),
    );
    if (expand || expaning) {
      int index = 1;
      for (RotateExpandToolbarItem item in widget.children) {
        if (expaning) {
          RotateExpandToolbarItemAnimationWidget iw =
              RotateExpandToolbarItemAnimationWidget(
            key: UniqueKey(),
            icon: item.icon,
            iconSize: widget.iconSize,
            color: item.color ?? widget.color,
            space: widget.space,
          );

          iw.space = widget.space;
          iw.expandDuration = widget.expandDuration;
          iw.index = index;

          iw.startPostion = const Offset(0, 0);
          iw.endPostion = Offset(
              expaning
                  ? index.toDouble()
                  : index * (widget.iconSize + widget.space),
              0);

          iw.setExpand(expand);

          list.add(iw);
        } else {
          RotateExpandToolbarItemWidget iw = RotateExpandToolbarItemWidget(
            key: UniqueKey(),
            icon: item.icon,
            iconSize: widget.iconSize,
            color: item.color ?? widget.color,
            space: widget.space,
            tooltip: item.tooltip,
            onTap: item.onTap,
          );

          list.add(iw);
        }
        index++;
      }
    }
    if (expaning) {
      return Stack(
        alignment: Alignment.topLeft,
        children: list,
      );
    } else {
      return Row(
        children: list,
      );
    }
  }
}

class RotateExpandToolbarItem {
  RotateExpandToolbarItem(
      {required this.icon, this.color, this.tooltip, required this.onTap});
  IconData icon;
  Color? color;
  String? tooltip;
  Function() onTap;
}

// ignore: must_be_immutable
class RotateExpandToolbarItemAnimationWidget extends StatefulWidget {
  RotateExpandToolbarItemAnimationWidget({
    super.key,
    required this.icon,
    this.iconSize = 32,
    this.color,
    this.space = 8,
  });

  late Duration expandDuration;
  late int index;
  late Offset startPostion;
  late Offset endPostion;
  double space;
  bool expand = true;
  void setExpand(bool value) {
    if (expand != value) {
      expand = value;
      _state?.refresh();
    }
  }

  IconData icon;
  double iconSize;
  Color? color;

  RotateExpandToolbarItemAnimationWidgetState? _state;
  void setState(RotateExpandToolbarItemAnimationWidgetState value) {
    _state = value;
  }

  @override
  State<StatefulWidget> createState() =>
      RotateExpandToolbarItemAnimationWidgetState();
}

class RotateExpandToolbarItemAnimationWidgetState
    extends State<RotateExpandToolbarItemAnimationWidget>
    with TickerProviderStateMixin {
  /// 手动控制动画的控制器
  late final AnimationController _manualController;

  /// 手动控制
  late final Animation<double> _manualAnimation;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _manualController = AnimationController(
      vsync: this,
      duration: widget.expandDuration,
    )..animateTo(widget.index.toDouble());
    if (widget.expand) {
      _manualAnimation = Tween<double>(begin: 0, end: widget.index.toDouble())
          .animate(_manualController);
      _offsetAnimation =
          Tween<Offset>(begin: widget.startPostion, end: widget.endPostion)
              .animate(_manualController);
    } else {
      _manualAnimation = Tween<double>(begin: widget.index.toDouble(), end: 0)
          .animate(_manualController);
      _offsetAnimation =
          Tween<Offset>(begin: widget.endPostion, end: widget.startPostion)
              .animate(_manualController);
    }
  }

  @override
  void dispose() {
    _manualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.setState(this);
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: EdgeInsets.fromLTRB(widget.space, 0, 0, 0),
        child: RotationTransition(
          turns: _manualAnimation,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
                minWidth: widget.iconSize,
                minHeight: widget.iconSize,
                maxWidth: widget.iconSize,
                maxHeight: widget.iconSize),
            icon: Icon(widget.icon),
            iconSize: widget.iconSize,
            color: widget.color,
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}

// ignore: must_be_immutable
class RotateExpandToolbarItemWidget extends StatefulWidget {
  RotateExpandToolbarItemWidget({
    super.key,
    required this.icon,
    this.iconSize = 32,
    this.color,
    this.space = 8,
    this.tooltip,
    required this.onTap,
  });
  double space;
  IconData icon;
  double iconSize;
  Color? color;
  String? tooltip;
  Function() onTap;

  @override
  State<StatefulWidget> createState() => RotateExpandToolbarItemWidgetState();
}

class RotateExpandToolbarItemWidgetState
    extends State<RotateExpandToolbarItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(widget.space, 0, 0, 0),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
            minWidth: widget.iconSize,
            minHeight: widget.iconSize,
            maxWidth: widget.iconSize,
            maxHeight: widget.iconSize),
        icon: Icon(widget.icon),
        iconSize: widget.iconSize,
        color: widget.color,
        tooltip: widget.tooltip,
        onPressed: () {
          setState(() {
            setState(() {
              widget.onTap();
            });
          });
        },
      ),
    );
  }
}
