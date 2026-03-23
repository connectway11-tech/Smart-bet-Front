import 'package:flutter/material.dart';

enum AppSection { home, myNumbers, history, results }

class AppTabBar extends StatelessWidget {
  final AppSection current;
  final ValueChanged<AppSection> onChanged;

  const AppTabBar({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = <_TabItem>[
      const _TabItem('Inicio', AppSection.home),
      const _TabItem('Mis Números', AppSection.myNumbers),
      const _TabItem('Historial', AppSection.history),
      const _TabItem('Resultados', AppSection.results),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEF1F6))),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 820;

          final tabsWrap = Wrap(
            spacing: 4,
            runSpacing: 6,
            children: tabs.map((entry) {
              final label = entry.label;
              final section = entry.section;
              final selected = current == section;

              return InkWell(
                borderRadius: BorderRadius.circular(7),
                onTap: () => onChanged(section),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFEAF2FF) : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected ? const Color(0xFF2563EB) : const Color(0xFF566173),
                    ),
                  ),
                ),
              );
            }).toList(),
          );

          final balance = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'TU BALANCE',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF9CA3AF),
                      letterSpacing: .2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '\$1.250,00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [Color(0xFFA855F7), Color(0xFFEC4899)]),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.person, size: 13, color: Colors.white),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tabsWrap,
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerRight, child: balance),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: tabsWrap),
              const SizedBox(width: 16),
              balance,
            ],
          );
        },
      ),
    );
  }
}

class _TabItem {
  final String label;
  final AppSection section;

  const _TabItem(this.label, this.section);
}
