import 'package:daily_do/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

//ignore: must_be_immutable
class CustomScaffold extends StatefulWidget {
  final Widget body;
  final String className;
  final String screenName;
  final int bottomBarIndex;
  final String? subScreenName;
  final Function? onWillPop,
      gestureDetectorOnTap,
      onBackButtonPressed,
      gestureDetectorOnPanDown,
      onNotificationListener;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget? gridview;
  final bool isBackIcon;
  bool showAppBarProfile = false;
  bool showAppBarBackButton = false;
  bool showActionButton = false;
  bool isFullBody = false;
  Widget? bottomNavigationBar;
  Widget? title;
  List<PopupMenuItem<int>> listOfPopupMenuItems = [];
  List<Widget>? actions = [];
  Widget? floatingActionButton;
  Widget? leadingWidget;
  Widget? bottomSheet;
  bool? centerTitle;
  bool showBottomBorder;
  double leadingWidth = 56;
  EdgeInsets padding =
      const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0);

  CustomScaffold(
      {super.key,
      required this.className,
      this.isBackIcon = true,
      required this.screenName,
      this.subScreenName,
      this.onWillPop,
      this.centerTitle,
      this.showBottomBorder = false,
      this.leadingWidget,
      this.onBackButtonPressed,
      this.gestureDetectorOnPanDown,
      this.gestureDetectorOnTap,
      this.onNotificationListener,
      this.bottomSheet,
      required this.scaffoldKey,
      required this.body,
      this.padding =
          const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
      this.gridview,
      this.bottomBarIndex = 0,
      this.showAppBarProfile = false,
      this.showAppBarBackButton = false,
      this.showActionButton = false,
      this.isFullBody = false,
      this.bottomNavigationBar,
      this.title,
      this.floatingActionButton,
      this.leadingWidth = 56,
      this.listOfPopupMenuItems = const [],
      this.actions = const []});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: kWhiteColor, statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
        onWillPop: () {
          if (widget.onWillPop != null) {
            return widget.onWillPop!();
          } else {
            return Future.value(true);
          }
        },
        child: GestureDetector(
          onTap: () {
            if (widget.gestureDetectorOnTap != null) {
              widget.gestureDetectorOnTap!();
            }
          },
          onPanDown: (panDetails) {
            if (widget.gestureDetectorOnPanDown != null) {
              widget.gestureDetectorOnPanDown!(panDetails);
            }
          },
          child: NotificationListener(
            onNotification: (notificationInfo) {
              if (widget.onNotificationListener != null) {
                return widget.onNotificationListener!(notificationInfo);
              } else {
                return false;
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: false,
              backgroundColor: kYellowColor.withOpacity(0.2),
              key: widget.scaffoldKey,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(widget.isFullBody ? 0.0 : 60),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: widget.showBottomBorder
                                    ? kBlackColor.withOpacity(0.20)
                                    : Colors.transparent))),
                    child: CustomAppBar(
                        leadingWidth: widget.leadingWidth,
                        backIcon: widget.isBackIcon,
                        actions: widget.actions ?? [],
                        scaffoldKey: widget.scaffoldKey,
                        screenTitle: widget.screenName,
                        leadingWidget: widget.leadingWidget,
                        centerTitle: widget.centerTitle,
                        title: widget.title,
                        className: widget.className),
                  )),
              body: widget.isFullBody
                  ? Container(
                      padding: widget.padding,
                      child: widget.body,
                    )
                  : Container(
                      width: Get.width,
                      height: Get.height,
                      padding: widget.padding,
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(child: Container(child: widget.body)),
                          ],
                        ),
                      ),
                    ),
              extendBodyBehindAppBar: true,
              bottomNavigationBar: widget.bottomNavigationBar != null
                  ? Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: widget.bottomNavigationBar)
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
              floatingActionButton: widget.floatingActionButton,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomSheet: widget.bottomSheet,
            ),
          ),
        ));
  }
}
