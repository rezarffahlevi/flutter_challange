import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/helpers/preferences_base.dart';
import 'package:flutter_challange/src/screens/auth/login_screen.dart';
import 'package:flutter_challange/src/widgets/extensions.dart';
import 'package:flutter_challange/src/widgets/the_bottom_sheet_ruler.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Helpers {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String base64Encode(String string) {
    Codec<String, String> codec = utf8.fuse(base64);
    return codec.encode(string);
  }

  static String base64Decode(String string) {
    Codec<String, String> codec = utf8.fuse(base64);
    return codec.decode(string);
  }

  static Future<void> addDelay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds), () {});
  }

  static void showLoadingPopup(BuildContext context, {isVisible = true}) {
    if (isVisible)
      showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.2),
        // background color
        barrierDismissible: false,
        // should dialog be dismissed when tapped outside
        barrierLabel: "Dialog",
        // label for barrier
        transitionDuration: Duration(milliseconds: 400),
        // how long it takes to popup dialog after button click
        pageBuilder: (_, __, ___) {
          // your widget implementation
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                // child: SpinKitFadingCircle(
                //   color: TheColors.defaultPurple,
                //   size: 50.0,
                // ),
              ),
            ),
          );
        },
      );
    else
      showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.01),
        // background color
        barrierDismissible: false,
        // should dialog be dismissed when tapped outside
        barrierLabel: "Dialog",
        // label for barrier
        transitionDuration: Duration(milliseconds: 400),
        // how long it takes to popup dialog after button click
        pageBuilder: (_, __, ___) {
          // your widget implementation
          return WillPopScope(
            onWillPop: () async => false,
            child: Container(),
          );
        },
      );
  }

  static void dismissLoadingPopup(BuildContext context) {
    Navigator.pop(context);
  }

  static void showErrorBottomSheet(BuildContext context,
      {String image, String title, String desc}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) => Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: TheColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TheBottomSheetRuler(),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    image ?? '',
                    height: 100,
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  title ?? '',
                  style: TheTextStyle.contentTitle,
                  textAlign: TextAlign.center,
                ),
                TheSizedBox.smallVertical(),
                Text(
                  desc ?? '',
                  maxLines: 3,
                  style: TheTextStyle.contentDescription
                      .copyWith(color: TheColors.grey),
                  textAlign: TextAlign.center,
                ),
                TheSizedBox.smallVertical(),
                TheRoundedButton(
                    title: 'OKE',
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                TheSizedBox.smallVertical(),
              ],
            ),
          )
        ],
      ),
    );
  }

  static void showToast(String msg, {Toast toastLength = Toast.LENGTH_LONG}) {
    Fluttertoast.showToast(msg: msg, toastLength: toastLength);
  }

  static void showErrorToast(e) {
    Fluttertoast.showToast(
        msg: e.toString().replaceAll('Exception: ', ''),
        toastLength: Toast.LENGTH_LONG);
  }

  static String getErrorMessage(e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  static void forceLogOut() async {
    print('force log out');
    await PreferencesHelper.logout();
    navigatorKey.currentState.pushNamedAndRemoveUntil(
        LoginScreen.routeName, (Route<dynamic> route) => false);
  }

  static Widget createVerifiedIcon(String verified) {
    if (verified == 'verified' || verified == 'true')
      return Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          color: TheColors.white,
          size: 15,
        ),
      );
    else
      return Container();
  }

  static String formatDate(String date, {String format = 'dd MMMM yyyy'}) {
    try {
      // initializeDateFormatting();
      return DateFormat(format, 'id').format(DateTime.parse(date));
    } catch (e) {
      print(e.toString());
      return '-';
    }
  }

  static String formatDateTime(String date,
      {String format = 'dd MMMM yyyy HH:mm'}) {
    try {
      // initializeDateFormatting();
      return DateFormat(format, 'id').format(DateTime.parse(date));
    } catch (e) {
      print(e.toString());
      return '-';
    }
  }

  static Future<void> showBottomSheetWidget(BuildContext context,
      {String title,
      Widget widget,
      String image,
      bool isDismissible = true,
      bool enableDrag = true,
      bool showCloseButton = false}) async {
    Widget _closeButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 30),
        TheBottomSheetRuler(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 30,
            color: TheColors.backdrop,
          ),
        ),
      ],
    );

    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showCloseButton ? _closeButton : TheBottomSheetRuler(),
                  TheSizedBox.extraSmallVertical(),
                  image != null
                      ? Image.asset(
                          image,
                          height: 150,
                        )
                      : Container(),
                  title != null
                      ? Text(
                          title,
                          style: TheTextStyle.bottomSheetTitle,
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                  TheSizedBox.extraSmallVertical(),
                  widget ??
                      Container(
                        height: 50,
                      ),
                  TheSizedBox.extraLargeVertical(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showDatePicker(
      BuildContext context, String title, Function(DateTime) onConfirm,
      {DateTime defaultDateTime}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) => datePickerWidget(context, title, (value) {
        onConfirm(value);
      }, defaultDateTime),
    );
  }

  static Widget datePickerWidget(BuildContext context, String title,
      Function(DateTime) onConfirm, DateTime defaultDateTime) {
    DateTime dateTime = defaultDateTime ?? DateTime.now();

    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TheBottomSheetRuler(),
              Text(
                title,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.grey,
                    child: CupertinoDatePicker(
                      backgroundColor: TheColors.white,
                      initialDateTime: defaultDateTime ?? DateTime.now(),
                      onDateTimeChanged: (date) {
//                        this.onConfirm(date);
                        dateTime = date;
                      },
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm(dateTime);
                },
                child: Text('Pilih', style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: TheColors.primary,
              ),
            ],
          ),
        )
      ],
    );
  }

  static String getYoutubeId(String url) {
    String result = '';
    final regex =
        RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false, multiLine: false);
    if (regex.hasMatch(url)) {
      final videoId = regex.firstMatch(url).group(1);
      result = videoId;
      print(videoId);
    } else {
      print("Cannot parse $url");
    }

    return result;
  }

  // static String getYoutubeEmbedLink(String url) {
  //   String _control= 'controls=0';
  //   String _loop= 'loop=1';
  //   String _autoplay= 'autoplay=1';
  //   return 'https://www.youtube.com/embed/' + getYoutubeId(url);
  // }

  static String getYoutubeEmbedLink({
    @required String url,
    bool controlsDisable = true,
    bool loopEnable = false,
    bool autoplayEnable = false,
    bool jsApiEnable = true,
    bool showinfoDisable = true,
    // bool fullscreen = false,
  }) {
    String _controls = 'controls=0';
    String _loop = 'loop=0';
    String _autoplay = 'autoplay=1';
    String _enablejsapi = 'enablejsapi=1';
    String _showinfo = 'showinfo=0';
    String _playsinline = 'playsinline=1';
    String _allowfullscreen = 'allowfullscreen=true';
    String _allowsInlineMediaPlayback = 'allowsInlineMediaPlayback=true';
    String params = '?';
    if (controlsDisable) {
      params = params + _controls + '&';
    }
    if (loopEnable) {
      params = params + _loop + '&';
    }
    if (autoplayEnable) {
      params = params + _autoplay + '&';
    }
    if (jsApiEnable) {
      params = params + _enablejsapi + '&';
    }
    if (showinfoDisable) {
      params = params + _showinfo + '&';
    }
    // if (fullscreen) {
    //   params =
    //       '$params$_playsinline&$_allowfullscreen&$_allowsInlineMediaPlayback&';
    // }

    var link = 'https://www.youtube.com/embed/' + getYoutubeId(url) + params;
    print(link);
    return link;
  }

  static String getPlatformName() {
    String result = '';
    if (Platform.isAndroid)
      result = 'android';
    else
      result = 'ios';
    return result;
  }

  static bool isInteger(num value) => (value % 1) == 0;

  static String replaceZero(String value) {
    String result = removeDecimalZero(value);
    if (result == '0' || result == '0.0') result = '';
    return result;
  }

  static String removeDecimalZero(dynamic n) {
    if (n is String) n = double.parse(n);
    if (isInteger(n)) n = n.toInt();

    return n.toString();
  }

  static bool stringToBool(String data) {
    if (data == 'true') return true;
    return false;
  }

  static String intToWritten(int n) {
    IntToWrittenEnum xtype;
    // List<String> teens= ["One","Two","Three","Four","Five","Six","Seven", "Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen", "Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"];
    // List<String> tens= ["Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"];
    List<String> teens = [
      "Satu",
      "Dua",
      "Tiga",
      "Empat",
      "Lima",
      "Enam",
      "Tujuh",
      "Delapan",
      "Sembilan",
      "Sepuluh",
      "Sebelas",
      "Dua Belas",
      "Tiga Belas",
      "Empat Belas",
      "Lima Belas",
      "Enam Belas",
      "Tujuh Belas",
      "Delapan Belas",
      "Sembilan Belas"
    ];
    List<String> tens = [
      "Dua Puluh",
      "Tiga Puluh",
      "Empat Puluh",
      "Lima Puluh",
      "Enam Puluh",
      "Tujuh Puluh",
      "Delapan Puluh",
      "Sembilan Puluh"
    ];

    if (n < 20)
      xtype = IntToWrittenEnum.TEENS;
    else if (n < 100)
      xtype = IntToWrittenEnum.TENS;
    else if (n < 200) xtype = IntToWrittenEnum.HUNDRED;

    switch (xtype) {
      case IntToWrittenEnum.TEENS:
        return teens[n - 1].toString() + " ";
      case IntToWrittenEnum.TENS:
        return tens[(n / 10 - 2).toInt()].toString() +
            " " +
            intToWritten(n % 10);
      case IntToWrittenEnum.HUNDRED:
        return "Seratus " + intToWritten(n % 100);
      default:
        return 'NUMBER NOT FOUND';
    }
  }
}

enum IntToWrittenEnum { TEENS, TENS, HUNDRED }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
