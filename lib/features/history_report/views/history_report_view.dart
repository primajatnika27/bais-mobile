import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/empty_list_widget.dart';
import 'package:bais_mobile/features/history_report/controllers/create_history_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryReportView extends GetView<CreateHistoryReportController> {
  const HistoryReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBarGeneral(
          title: 'History Report',
          withLeading: false,
          withTabBar: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Container(
              color: Colors.white,
              child: const TabBar(
                isScrollable: true,
                labelColor: AppTheme.primary,
                unselectedLabelColor: Color.fromARGB(255, 71, 84, 103),
                indicatorColor: AppTheme.primary,
                labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                tabs: [
                  Tab(text: 'Reject'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Approve'),
                  Tab(text: 'Cancel'),
                  Tab(text: 'Done'),
                  Tab(text: 'All'),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    _emptyWidget(),
                    _emptyWidget(),
                    _emptyWidget(),
                    _emptyWidget(),
                    _emptyWidget(),
                    _emptyWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyWidget() {
    return const EmptyListWidget(
      image: 'assets/images/ic_empty.png',
      title: "No history report found",
      subtitle: "It seems you don't have any history report yet.",
    );
  }
}