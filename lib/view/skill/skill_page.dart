import 'package:flutter/material.dart';
import 'package:rpg/view/setting/components/menu_appbar_view.dart';
import 'package:rpg/view/skill/components/skill_list_view.dart';
import 'package:rpg/view/skill/components/skill_title_view.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({Key? key}) : super(key: key);

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> topBarAnimation;
  final List<Widget> _listViews = [];
  final ScrollController _scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 && _scrollController.offset >= 0) {
        if (topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    addAllWidget();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void addAllWidget() {
    _listViews.add(SkillTitleView(
      mainAnimationController: _animationController,
      mainAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval((1 / 2) * 0, 1, curve: Curves.fastOutSlowIn),
      )),
    ));
    _listViews.add(SkillListView(
      mainAnimationController: _animationController,
      mainAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval((1 / 2) * 1, 1, curve: Curves.fastOutSlowIn),
      )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getBodyUI(),
          MenuAppbarView(
            animationController: _animationController,
            topBarOpacity: topBarOpacity,
            title: '技能',
          ),
        ],
      ),
    );
  }

  Widget getBodyUI() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
        bottom: 80 + MediaQuery.of(context).padding.bottom,
        left: 20,
        right: 20,
      ),
      itemCount: _listViews.length,
      itemBuilder: (context, index) {
        _animationController.forward();
        return _listViews[index];
      },
    );
  }
}
