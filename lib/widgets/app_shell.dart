import 'package:flutter/material.dart';
import 'package:flutter_mvp/widgets/app_tab_bar.dart';
import 'package:flutter_mvp/widgets/history_page.dart';
import 'package:flutter_mvp/widgets/home_page.dart';
import 'package:flutter_mvp/widgets/my_numbers_page.dart';
import 'package:flutter_mvp/widgets/results_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppSection current = AppSection.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 54, 18, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1020),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE8EAF4)),
                    boxShadow: const [
                      BoxShadow(color: Color(0x060F172A), blurRadius: 22, offset: Offset(0, 8)),
                    ],
                  ),
                  child: Column(
                    children: [
                      AppTabBar(
                        current: current,
                        onChanged: (value) => setState(() => current = value),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                        child: _buildContent(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const FooterBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (current) {
      case AppSection.home:
        return const HomePageContent();
      case AppSection.myNumbers:
        return const MyNumbersPage();
      case AppSection.history:
        return const HistoryPage();
      case AppSection.results:
        return ResultsPage(
          embedded: true,
          onBackHome: () => setState(() => current = AppSection.home),
        );
    }
  }
}
