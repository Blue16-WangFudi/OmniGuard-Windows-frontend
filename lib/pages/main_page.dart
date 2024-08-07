import 'dart:io';

import 'package:flutter/material.dart';
import 'risk_map_page.dart';
import 'risk_overall_reports.dart';
import 'risk_monitoring.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Color.fromRGBO(135, 155, 236, 1),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          indicatorColor: const Color.fromRGBO(218,219,220, 1),
          indicatorWeight: 4.0,
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: '实时风险监测'),
            Tab(text: '风险总体报告'),
            Tab(text: '风险分布地图'),
            Tab(text: '趋势分析图表'),
            Tab(text: '系统健康'),
          ],
          
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 248, 252, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            RiskMonitoring(),
            RiskOverallReport(),
            RiskMapPage(),
            Center(
              child: Image.asset("assets/images/page/page1.png")
            ),
            Center(
              child: Image.asset("assets/images/page/page2.png")
            ),
          ],
        ),
      ),
    );
  }
}
