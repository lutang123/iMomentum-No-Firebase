//import 'dart:math';
//import 'package:flutter/material.dart';
////import 'package:layout_demo_flutter/layout_type.dart';
//import 'package:flutter/rendering.dart';
////import 'package:flutter/foundation.dart';
//import '../screens.home_screen.dart';
//
//class HeroHeader implements SliverPersistentHeaderDelegate {
//  HeroHeader({
////    this.layoutGroup,
////    this.onLayoutToggle,
//    this.minExtent,
//    this.maxExtent,
//  });
////  final LayoutGroup layoutGroup;
////  final VoidCallback onLayoutToggle;
//  double maxExtent;
//  double minExtent;
//
//  @override
//  Widget build(
//      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    return Stack(
//      fit: StackFit.expand,
//      children: [
//        Image.asset(
//          'images/beach.jpg',
//          fit: BoxFit.cover,
//        ),
//        Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              colors: [
//                Colors.transparent,
//                Colors.black54,
//              ],
//              stops: [0.5, 1.0],
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//              tileMode: TileMode.repeated,
//            ),
//          ),
//        ),
//        Positioned(
//          left: 4.0,
//          top: 4.0,
//          child: SafeArea(
//            child: IconButton(
//              icon: Icon(Icons.arrow_back_ios),
//              onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => HomePage()));
//              },
////              icon: Icon(layoutGroup == LayoutGroup.nonScrollable
////                  ? Icons.filter_1
////                  : Icons.filter_2),
////              onPressed: onLayoutToggle,
//            ),
//          ),
//        ),
//        Positioned(
//          left: 16.0,
//          right: 16.0,
//          bottom: 16.0,
//          child: Text(
//            'My screens.Notes',
//            style: TextStyle(
//              fontSize: 32.0,
//              color: Colors.white.withOpacity(
//                titleOpacity(shrinkOffset),
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//
//  double titleOpacity(double shrinkOffset) {
//    // simple formula: fade out text as soon as shrinkOffset > 0
//    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
//    // more complex formula: starts fading out text when shrinkOffset > minExtent
//    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
//  }
//
//  @override
//  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//    return true;
//  }
//
//  @override
//  FloatingHeaderSnapConfiguration get snapConfiguration => null;
//
//  @override
//  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
//      OverScrollHeaderStretchConfiguration();
//}
//
//class Meditate extends StatefulWidget {
//  @override
//  _MeditateState createState() => _MeditateState();
//}
//
//class _MeditateState extends State<Meditate> {
//  bool fabVisible = true;
//
//  void toggleFab() {
//    setState(() {
//      fabVisible = !fabVisible;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: _scrollView(context),
//      floatingActionButton: fabVisible
//          ? Visibility(
//              visible: fabVisible,
//              child: FloatingActionButton(
//                backgroundColor: Color(0xff02abd4),
//                child: Icon(
//                  Icons.add,
//                  color: Colors.white70,
//                  size: 30,
//                ),
//                onPressed: () {},
//              ),
//            )
//          : Container(),
//    );
//  }
//
//  Widget _scrollView(BuildContext context) {
//    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
//    return Container(
//      child: CustomScrollView(
//        slivers: <Widget>[
//          SliverPersistentHeader(
//            pinned: true,
//            delegate: HeroHeader(
////                  layoutGroup: layoutGroup,
////                  onLayoutToggle: onLayoutToggle,
//              minExtent: 150.0,
//              maxExtent: 250.0,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
