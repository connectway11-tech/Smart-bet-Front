import 'package:flutter/material.dart';

class MyNumbersPage extends StatefulWidget {
  const MyNumbersPage({super.key});

  @override
  State<MyNumbersPage> createState() => _MyNumbersPageState();
}

class _MyNumbersPageState extends State<MyNumbersPage> {
  static const List<_SavedSet> _allSets = [
    _SavedSet(
      title: 'Favoritos de la Semana',
      subtitle: 'Usados en Quini 6 y Loto Plus',
      notes: 'Último uso: hace 2 días',
      numbers: ['07', '14', '22', '31', '38', '45'],
      accent: Color(0xFF2563EB),
      game: 'Quini 6',
      tag: 'Frecuente',
    ),
    _SavedSet(
      title: 'Cábalas Personales',
      subtitle: 'Fechas y números frecuentes',
      notes: '5 números guardados',
      numbers: ['03', '11', '19', '24', '35'],
      accent: Color(0xFFA855F7),
      game: 'Loto Plus',
      tag: 'Personal',
    ),
    _SavedSet(
      title: 'Rápidas para Brinco',
      subtitle: 'Selecciones de sorteo diario',
      notes: 'Listas para jugar hoy',
      numbers: ['08', '17', '25', '36', '42', '49'],
      accent: Color(0xFF10B981),
      game: 'Brinco',
      tag: 'Hoy',
    ),
    _SavedSet(
      title: 'Números de Reserva',
      subtitle: 'Alternativas para próximas jugadas',
      notes: 'Sin usar esta semana',
      numbers: ['02', '09', '18', '27', '33', '41'],
      accent: Color(0xFFF59E0B),
      game: 'Quini 6',
      tag: 'Backup',
    ),
  ];

  String selectedGame = 'Todos';
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final visibleSets = _visibleSets;
    final activeSet = visibleSets[selectedIndex.clamp(0, visibleSets.length - 1)];
    final playedToday = visibleSets.where((set) => set.tag == 'Hoy' || set.notes.contains('hoy')).length;

    return Column(
      children: [
        const SizedBox(height: 26),
        const Text(
          'Mis Números',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Color(0xFF253041)),
        ),
        const SizedBox(height: 8),
        Text(
          'Tus combinaciones guardadas para jugar más rápido',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, height: 1.25, color: Colors.blueGrey.shade300),
        ),
        const SizedBox(height: 24),
        _SummaryStrip(
          savedCount: visibleSets.length.toString(),
          topGame: _topGameLabel(visibleSets),
          playedToday: playedToday.toString(),
        ),
        const SizedBox(height: 18),
        _GameFilterRow(
          selectedGame: selectedGame,
          onChanged: (value) {
            setState(() {
              selectedGame = value;
              selectedIndex = 0;
            });
          },
        ),
        const SizedBox(height: 16),
        const _SectionHeader(title: 'Combinaciones Guardadas', action: 'Agregar Nueva'),
        const SizedBox(height: 12),
        for (var index = 0; index < visibleSets.length; index++) ...[
          _SavedNumbersCard(
            key: ValueKey('${visibleSets[index].title}-$index'),
            set: visibleSets[index],
            selected: selectedIndex == index,
            onTap: () => setState(() => selectedIndex = index),
          ),
          if (index != visibleSets.length - 1) const SizedBox(height: 14),
        ],
        const SizedBox(height: 16),
        _SelectedSetPanel(set: activeSet),
      ],
    );
  }

  List<_SavedSet> get _visibleSets {
    final sets = selectedGame == 'Todos'
        ? _allSets
        : _allSets.where((set) => set.game == selectedGame).toList();

    return sets.isEmpty ? _allSets : sets;
  }

  String _topGameLabel(List<_SavedSet> sets) {
    final counts = <String, int>{};
    for (final set in sets) {
      counts.update(set.game, (value) => value + 1, ifAbsent: () => 1);
    }

    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }
}

class _SavedSet {
  final String title;
  final String subtitle;
  final String notes;
  final List<String> numbers;
  final Color accent;
  final String game;
  final String tag;

  const _SavedSet({
    required this.title,
    required this.subtitle,
    required this.notes,
    required this.numbers,
    required this.accent,
    required this.game,
    required this.tag,
  });
}

class _SummaryStrip extends StatelessWidget {
  final String savedCount;
  final String topGame;
  final String playedToday;

  const _SummaryStrip({
    required this.savedCount,
    required this.topGame,
    required this.playedToday,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MiniStatCard(
            title: 'Guardados',
            value: savedCount,
            accent: const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MiniStatCard(
            title: 'Más usados',
            value: topGame,
            accent: const Color(0xFFA855F7),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MiniStatCard(
            title: 'Jugados hoy',
            value: playedToday,
            accent: const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color accent;

  const _MiniStatCard({
    required this.title,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7EBF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: accent)),
        ],
      ),
    );
  }
}

class _GameFilterRow extends StatelessWidget {
  final String selectedGame;
  final ValueChanged<String> onChanged;

  const _GameFilterRow({
    required this.selectedGame,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['Todos', 'Quini 6', 'Loto Plus', 'Brinco'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options
          .map(
            (option) => GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: selectedGame == option ? const Color(0xFF111827) : Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: selectedGame == option ? const Color(0xFF111827) : const Color(0xFFE7EBF2),
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: selectedGame == option ? Colors.white : const Color(0xFF4B5563),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String action;

  const _SectionHeader({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF253041)),
          ),
        ),
        Text(
          action,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF2563EB)),
        ),
      ],
    );
  }
}

class _SavedNumbersCard extends StatelessWidget {
  final _SavedSet set;
  final bool selected;
  final VoidCallback onTap;

  const _SavedNumbersCard({
    super.key,
    required this.set,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? set.accent : const Color(0xFFE7EBF2), width: selected ? 1.4 : 1),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: set.accent.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: set.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.bookmark_rounded, color: set.accent, size: 17),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(set.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Text(set.subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: set.accent.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    set.tag,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: set.accent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: set.numbers
                  .map(
                    (number) => Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111827),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        number,
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(set.notes, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
                const Spacer(),
                Text(
                  selected ? 'Seleccionado' : 'Jugar ahora',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: set.accent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedSetPanel extends StatelessWidget {
  final _SavedSet set;

  const _SelectedSetPanel({required this.set});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: set.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: set.accent.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selección activa',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: set.accent),
          ),
          const SizedBox(height: 8),
          Text(
            '${set.title} para ${set.game}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF253041)),
          ),
          const SizedBox(height: 6),
          Text(
            'Podés reutilizar esta combinación, editarla o guardarla como jugada rápida para el próximo sorteo.',
            style: TextStyle(fontSize: 12.5, height: 1.35, color: Colors.blueGrey.shade500),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Editar',
                  primary: false,
                  accent: set.accent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  label: 'Jugar esta',
                  primary: true,
                  accent: set.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final bool primary;
  final Color accent;

  const _ActionButton({
    required this.label,
    required this.primary,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: primary ? accent : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary ? accent : accent.withValues(alpha: 0.28)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: primary ? Colors.white : accent,
        ),
      ),
    );
  }
}
