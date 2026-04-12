import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/common/theme/text_styles.dart';
import 'package:evently_c18/l10n/app_localizations.dart';
import 'package:evently_c18/provider/theme_provider.dart';
import 'package:evently_c18/screens/events/add_new_event/add_new_event_screen.dart';
import 'package:evently_c18/screens/home/tabs/fav_tab/fav_tab.dart';
import 'package:evently_c18/screens/home/tabs/home_tab/home_provider.dart';
import 'package:evently_c18/screens/home/tabs/home_tab/home_tab.dart';
import 'package:evently_c18/screens/home/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeTab(), FavTab(), ProfileTab()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      child: Scaffold(
        floatingActionButton: Consumer<HomeProvider>(
          builder: (BuildContext context, HomeProvider value, Widget? child) =>
              FloatingActionButton(
                onPressed: () async {
                  final res = await Navigator.of(
                    context,
                  ).pushNamed(AddNewEventScreen.routeName);
                  if (res == true) {
                    value.getEvents();
                  }
                },
                backgroundColor: theme.colorScheme.primary,
                shape: CircleBorder(),
                child: Icon(Icons.add, color: Colors.white, size: 24),
              ),
        ),
        appBar: index == 0
            ? AppBar(
                centerTitle: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).updateTheme();
                    },
                    icon: Icon(Icons.wb_sunny_outlined),
                  ),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: FilledButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).updateLanguage();
                      },

                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.all(0),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.localeName, //  == 'ar'
                        //     ? "EN"
                        //     : "AR", //   AppLocalizations.of(context)!.local,
                        style: AppTextStyles.style14w600Black.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
                title: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.hello, //    "Welcome Back ✨",
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    Text(
                      "Name", //TODO:with provider
                      style: theme.textTheme.displayMedium!.copyWith(
                        // color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: tabs[index],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) => setState(() {
            index = value;
          }),
          items: [
            BottomNavigationBarItem(
              icon: Assets.icons.homeUnselecte.svg(),
              activeIcon: Assets.icons.homeSelected.svg(),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.heartUnselected.svg(),
              activeIcon: Assets.icons.heartSelected.svg(),
              label: AppLocalizations.of(context)!.fav,
            ),
            BottomNavigationBarItem(
              icon: Assets.icons.userUnselected.svg(),
              activeIcon: Assets.icons.userSelected.svg(),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
    );
  }
}
