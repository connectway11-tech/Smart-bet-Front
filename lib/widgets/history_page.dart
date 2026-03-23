import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  static const List<_HistoryEntry> _entries = [
    _HistoryEntry(
      game: 'Quini 6',
      line: 'Tradicional',
      date: '15 Ene 2025',
      amount: '\$850',
      status: 'Pendiente',
      statusDetail: 'Sortea a las 21:15 hs',
      tone: Color(0xFF2563EB),
    ),
    _HistoryEntry(
      game: 'Loto Plus',
      line: 'Desquite',
      date: '14 Ene 2025',
      amount: '\$1.200',
      status: 'Ganaste',
      statusDetail: 'Premio acreditado',
      tone: Color(0xFF10B981),
    ),
    _HistoryEntry(
      game: 'Brinco',
      line: 'Sorteo diario',
      date: '12 Ene 2025',
      amount: '\$400',
      status: 'Finalizado',
      statusDetail: 'Sin premio',
      tone: Color(0xFF6B7280),
    ),
    _HistoryEntry(
      game: 'Quini 6',
      line: 'Revancha',
      date: '10 Ene 2025',
      amount: '\$650',
      status: 'Ganaste',
      statusDetail: 'Pendiente de retiro',
      tone: Color(0xFF10B981),
    ),
  ];

  String selectedFilter = 'Todos';
  String selectedGame = 'Todos';

  @override
  Widget build(BuildContext context) {
    final visibleEntries = _visibleEntries;

    return Column(
      children: [
        const SizedBox(height: 26),
        const Text(
          'Historial',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Color(0xFF253041)),
        ),
        const SizedBox(height: 8),
        Text(
          'Revisá tus últimas jugadas y su estado',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, height: 1.25, color: Colors.blueGrey.shade300),
        ),
        const SizedBox(height: 24),
        _HistoryFilters(
          selectedFilter: selectedFilter,
          onChanged: (value) => setState(() => selectedFilter = value),
        ),
        const SizedBox(height: 12),
        _GameScopeRow(
          selectedGame: selectedGame,
          onChanged: (value) => setState(() => selectedGame = value),
        ),
        const SizedBox(height: 16),
        _HistoryOverview(entries: visibleEntries),
        const SizedBox(height: 16),
        for (var index = 0; index < visibleEntries.length; index++) ...[
          _HistoryItem(entry: visibleEntries[index]),
          if (index != visibleEntries.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  List<_HistoryEntry> get _visibleEntries {
    var filtered = _entries.where((entry) {
      final statusMatches = _matchesStatus(entry);

      final gameMatches = selectedGame == 'Todos' ? true : entry.game == selectedGame;
      return statusMatches && gameMatches;
    }).toList();

    if (filtered.isEmpty) {
      filtered = _entries;
    }

    return filtered;
  }

  bool _matchesStatus(_HistoryEntry entry) {
    if (selectedFilter == 'Ganados') {
      return entry.status == 'Ganaste';
    }

    if (selectedFilter == 'Pendientes') {
      return entry.status == 'Pendiente';
    }

    if (selectedFilter == 'Finalizados') {
      return entry.status == 'Finalizado';
    }

    return true;
  }
}

class _HistoryEntry {
  final String game;
  final String line;
  final String date;
  final String amount;
  final String status;
  final String statusDetail;
  final Color tone;

  const _HistoryEntry({
    required this.game,
    required this.line,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusDetail,
    required this.tone,
  });
}

class _HistoryFilters extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onChanged;

  const _HistoryFilters({
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['Todos', 'Ganados', 'Pendientes', 'Finalizados'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options
          .map(
            (option) => _FilterChip(
              label: option,
              selected: selectedFilter == option,
              onTap: () => onChanged(option),
            ),
          )
          .toList(),
    );
  }
}

class _GameScopeRow extends StatelessWidget {
  final String selectedGame;
  final ValueChanged<String> onChanged;

  const _GameScopeRow({
    required this.selectedGame,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['Todos', 'Quini 6', 'Loto Plus', 'Brinco'];

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: options
            .map(
              (option) => GestureDetector(
                onTap: () => onChanged(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selectedGame == option ? const Color(0xFFEFF6FF) : Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: selectedGame == option ? const Color(0xFFBFDBFE) : const Color(0xFFE7EBF2),
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: selectedGame == option ? const Color(0xFF2563EB) : const Color(0xFF4B5563),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF111827) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? const Color(0xFF111827) : const Color(0xFFE7EBF2)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }
}

class _HistoryOverview extends StatelessWidget {
  final List<_HistoryEntry> entries;

  const _HistoryOverview({required this.entries});

  @override
  Widget build(BuildContext context) {
    final won = entries.where((entry) => entry.status == 'Ganaste').length;
    final invested = entries.fold<double>(
      0,
      (sum, entry) => sum + double.parse(entry.amount.replaceAll('\$', '').replaceAll('.', '')),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7EBF2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _OverviewMetric(
              title: 'Jugadas',
              value: entries.length.toString(),
              accent: const Color(0xFF2563EB),
            ),
          ),
          Expanded(
            child: _OverviewMetric(
              title: 'Ganadas',
              value: won.toString(),
              accent: const Color(0xFF10B981),
            ),
          ),
          Expanded(
            child: _OverviewMetric(
              title: 'Invertido',
              value: '\$${invested.toStringAsFixed(0)}',
              accent: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewMetric extends StatelessWidget {
  final String title;
  final String value;
  final Color accent;

  const _OverviewMetric({
    required this.title,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: accent)),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final _HistoryEntry entry;

  const _HistoryItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7EBF2)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 64,
            decoration: BoxDecoration(color: entry.tone, borderRadius: BorderRadius.circular(999)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.game, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(entry.line, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
                const SizedBox(height: 6),
                Text(entry.date, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(entry.amount, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(entry.status, style: TextStyle(fontSize: 11, color: entry.tone, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(entry.statusDetail, style: const TextStyle(fontSize: 10.5, color: Color(0xFF98A2B3))),
            ],
          ),
        ],
      ),
    );
  }
}
