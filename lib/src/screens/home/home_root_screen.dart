import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:provider/provider.dart';

class HomeRootScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final HomeRootBloc bloc = Provider.of<HomeRootBloc>(context);
    bloc.didMount(context);

    final labelTextStyle =
        Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 8.0);
    return WillPopScope(
      onWillPop: () => bloc.onWillPop(),
      child: Scaffold(
        key: bloc.scaffoldKey,
        body: bloc.children[bloc.selectedIndex],
        bottomNavigationBar: SizedBox(
          height: 50.0,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: TheColors.primary,
            unselectedItemColor: Colors.grey,
            currentIndex: bloc.selectedIndex,
            selectedLabelStyle: labelTextStyle,
            unselectedLabelStyle: labelTextStyle,
            onTap: (index) {
              bloc.setSelectedIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'BERANDA',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded),
                label: 'ARISAN',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'NOTIFIKASI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'AKUN',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
