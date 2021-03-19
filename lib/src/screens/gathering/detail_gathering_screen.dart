import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/providers/gathering/detail_gathering_bloc.dart';
import 'package:flutter_challange/src/providers/user/user_bloc.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';

class DetailGatheringScreen extends StatelessWidget {
  static const String routeName = '/detail-gathering';
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  // SliverAppBar is declared in Scaffold.body, in slivers of a
  // CustomScrollView.
  @override
  Widget build(BuildContext context) {
    final DetailGatheringBloc bloc = Provider.of<DetailGatheringBloc>(context);
    bloc.didMount(context);
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TheColors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 300.0,
            backgroundColor: TheColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Arisan Keluarga',
                style: TextStyle(
                  color: TheColors.white,
                  fontWeight: TheFontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: _body(context, bloc)),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: bloc.shakeClicked,
        child: Container(
            height: 85,
            width: 110,
            decoration: BoxDecoration(
              color: TheColors.yellow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: TheColors.yellow, width: 0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Kocok Arisan'),
                Image.asset(
                  'assets/icons/shake.png',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ],
            )),
      ),
    );
  }

  Widget _body(BuildContext context, DetailGatheringBloc bloc) {
    final dimension = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              // color: TheColors.greyPlaceHolder,
              border: Border.all(color: TheColors.white, width: 0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Info",
                  style: TextStyle(
                      color: TheColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                _itemWidget(
                    value: 'Yaya Tech',
                    key: 'Pemenang Arisan Ke-2',
                    onTap: bloc.memberClicked),
                _itemWidget(
                    value: 'Penarikan Ke-2 dari 16',
                    key: '31 Maret 2021',
                    onTap: bloc.memberClicked),
                TheSizedBox.smallVertical(),
                Text(
                  "Detail Group",
                  style: TextStyle(
                      color: TheColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                _itemWidget(
                    value: '20', key: 'Anggota', onTap: bloc.memberClicked),
                _itemWidget(
                    value: 'Rp. 20.000 / bulan', key: 'Kas', onTap: () {}),
                _itemWidget(
                    value: 'Rp. 5.000 / bulan', key: 'Konsumsi', onTap: () {}),
                _itemWidget(
                    value: 'Rp. 20.000.000', key: 'Saldo Kas', onTap: () {}),
                _itemWidget(
                    value: 'Perbulan', key: 'Jangka Waktu', onTap: () {}),
                _itemWidget(value: 'Pertama', key: 'Putaran', onTap: () {}),
                _itemWidget(value: 'Bebas', key: 'Tipe Arisan', onTap: () {}),
                TheSizedBox.smallVertical(),
                Text(
                  "Settings",
                  style: TextStyle(
                      color: TheColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                _menuWidget(
                    icon: Icons.delete,
                    text: 'Hapus Group',
                    onTap: bloc.memberClicked),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWidget({value: '-', key: '-', onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: TheColors.greyLight, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value ?? '-',
                  style: TextStyle(
                    color: TheColors.text,
                    fontWeight: TheFontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  key ?? '-',
                  style: TextStyle(
                    color: TheColors.text,
                    fontWeight: TheFontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: TheColors.text,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuWidget({icon: Icons.redo, text: '-', onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: TheColors.greyLight, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: TheColors.text,
                ),
                TheSizedBox.extraSmallHorizontal(),
                Text(
                  text,
                  style: TextStyle(
                    color: TheColors.text,
                    fontWeight: TheFontWeight.normal,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: TheColors.text,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
