import 'package:crypto_app/widgets/actions/actions_widget.dart';
import 'package:crypto_app/widgets/balance_panel/balance_panel.dart';
import 'package:crypto_app/widgets/chart/chart_home_page.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unicons/unicons.dart';
import '../services/api.dart';
import '../services/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 66032206.10;
  double profit = 35.22;
  double profitPercent = 0.22;

  List<String> cryptos = ['BTC', 'ETH', 'DOGE', ];
  List<String> names = [
    'Bitcoin',
    'Ethereum',
    'Dogecoin',
    
  ];

  List<Widget> widgets = [
    // futurebuilder for calling last10days api
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    widgets.clear();widgets.add(balancePanel(balance, profit, profitPercent, themeData));
      widgets.add(
        actionsWidget(themeData),
      );
    for (int i = 0; i < cryptos.length; i++) {
      
      widgets.add(
        FutureBuilder<CryptoTimeSeries>(
          future: getLastTenTimeExchangeRate(cryptos[i]),
          builder:
              (BuildContext context, AsyncSnapshot<CryptoTimeSeries> snapshot) {
            if (snapshot.hasData) {
              return chartHomePage(
                true,
                CryptoFontIcons.BTC,
                names[i],
                cryptos[i],
                'INR',
                snapshot.data!.dailyData,
                themeData,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: 409 TOO MANY REQUESTS'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          },
        ),
      );
    }
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: themeData.backgroundColor,
          leading: SizedBox(
            height: 10.w,
            width: 15.w,
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 15.w,
          title: Text(
            '(Cry)pto',
            style: themeData.textTheme.headline6!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: SizedBox(
                height: 3.5.h,
                width: 10.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    UniconsLine.bell,
                    color: themeData.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: ListView(
            children: widgets,
          ),
        ),
      ),
    );
  }
}
