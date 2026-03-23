import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final bool embedded;
  final VoidCallback? onBackHome;

  const ResultsPage({
    super.key,
    this.embedded = false,
    this.onBackHome,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String selectedGame = 'Quiniela';
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = _dateOnly(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final items = _itemsFor(selectedGame, selectedDate);

    final content = SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.embedded ? 340 : 320),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: widget.embedded ? 0 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Expanded(child: _ActionButton(icon: Icons.download_rounded, label: 'Save')),
                            SizedBox(width: 10),
                            Expanded(child: _ActionButton(icon: Icons.share_rounded, label: 'Share')),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const _PrimaryWideButton(icon: Icons.refresh_rounded, label: 'Play Same Numbers Again'),
                        const SizedBox(height: 10),
                        _SecondaryWideButton(
                          icon: Icons.home_rounded,
                          label: 'Back to Home',
                          onTap: () {
                            if (widget.onBackHome != null) {
                              widget.onBackHome!();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        const SizedBox(height: 18),
                        const _InfoCard(
                          text: 'Results will be available after the draw at 21:30. We\'ll notify you if you win!',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: widget.embedded ? 30 : 84),
                  Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Results',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel('Select Game'),
                        const SizedBox(height: 8),
                        _SelectField(
                          label: selectedGame,
                          onTap: _showGamePicker,
                        ),
                        const SizedBox(height: 14),
                        const _FieldLabel('Date'),
                        const SizedBox(height: 8),
                        _DateFilterRow(
                          selectedDate: selectedDate,
                          onToday: () => setState(() => selectedDate = _dateOnly(DateTime.now())),
                          onYesterday: () => setState(
                            () => selectedDate = _dateOnly(DateTime.now()).subtract(const Duration(days: 1)),
                          ),
                          onCalendarTap: _selectCalendarDate,
                        ),
                        const SizedBox(height: 12),
                        ...items,
                      ],
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );

    if (widget.embedded) {
      return content;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: content,
    );
  }

  List<Widget> _itemsFor(String game, DateTime date) {
    final formattedDate = _formatDate(date);

    switch (game) {
      case 'Quini6':
        return [
          QuiniResultCard(
            title: 'Quini6 - Traditional',
            date: formattedDate,
            jackpot: '\$850,000',
            numbers: ['07', '14', '22', '31', '38', '45'],
          ),
          const SizedBox(height: 12),
          QuiniResultCard(
            title: 'Quini6 - Revancha',
            date: formattedDate,
            jackpot: '\$220,000',
            numbers: ['05', '18', '27', '33', '40', '44'],
          ),
        ];
      case 'Loto Plus':
        return [
          QuiniResultCard(
            title: 'Loto Plus',
            date: formattedDate,
            jackpot: '\$450,000',
            numbers: ['03', '11', '19', '24', '35', '41'],
          ),
        ];
      default:
        return [
          QuinielaResultCard(
            title: 'Quiniela - Morning',
            date: formattedDate,
            numbers: ['48', '87', '15', '23', '56', '91', '34', '78', '02', '69'],
          ),
          const SizedBox(height: 12),
          QuinielaResultCard(
            title: 'Quiniela - Afternoon',
            date: formattedDate,
            numbers: ['18', '54', '32', '76', '09', '41', '85', '27', '63', '90'],
          ),
          const SizedBox(height: 12),
          QuiniResultCard(
            title: 'Quini6 - Traditional',
            date: formattedDate,
            jackpot: '\$850,000',
            numbers: ['07', '14', '22', '31', '38', '45'],
          ),
        ];
    }
  }

  Future<void> _showGamePicker() async {
    final value = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        const games = ['Quiniela', 'Quini6', 'Loto Plus'];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Game', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                ...games.map(
                  (game) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(game),
                    trailing: selectedGame == game ? const Icon(Icons.check_rounded) : null,
                    onTap: () => Navigator.of(context).pop(game),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (value != null) {
      setState(() => selectedGame = value);
    }
  }

  Future<void> _selectCalendarDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 5, 12, 31),
      helpText: 'Select Date',
    );

    if (pickedDate != null) {
      setState(() => selectedDate = _dateOnly(pickedDate));
    }
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black87, width: 1.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.black87),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12.5, color: Colors.black87)),
        ],
      ),
    );
  }
}

class _PrimaryWideButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PrimaryWideButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryWideButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SecondaryWideButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.black87),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 12.5, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String text;

  const _InfoCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(Icons.info, size: 14, color: Color(0xFF6B7280)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 10.5, height: 1.35, color: Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 11.5, color: Colors.black87));
  }
}

class _SelectField extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SelectField({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black87, width: 1.2),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontSize: 12.5))),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}

class _DateFilterRow extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onToday;
  final VoidCallback onYesterday;
  final VoidCallback onCalendarTap;

  const _DateFilterRow({
    required this.selectedDate,
    required this.onToday,
    required this.onYesterday,
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final yesterday = today.subtract(const Duration(days: 1));
    final isToday = _isSameDate(selectedDate, today);
    final isYesterday = _isSameDate(selectedDate, yesterday);
    final isCustom = !isToday && !isYesterday;

    return Row(
      children: [
        Expanded(
          child: _DatePill(
            label: 'Today',
            selected: isToday,
            onTap: onToday,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _DatePill(
            label: 'Yesterday',
            selected: isYesterday,
            onTap: onYesterday,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: onCalendarTap,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: isCustom ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: isCustom ? Colors.black : const Color(0xFFD1D5DB)),
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: isCustom ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isSameDate(DateTime left, DateTime right) {
    return left.year == right.year && left.month == right.month && left.day == right.day;
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}

class _DatePill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DatePill({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: selected ? Colors.black : const Color(0xFFD1D5DB)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 12, color: selected ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}

class QuinielaResultCard extends StatelessWidget {
  final String title;
  final String date;
  final List<String> numbers;

  const QuinielaResultCard({
    super.key,
    required this.title,
    required this.date,
    required this.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black87, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500)),
              ),
              Text(date, style: const TextStyle(fontSize: 10.5, color: Color(0xFF6B7280))),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Winning Numbers', style: TextStyle(fontSize: 10.5, color: Color(0xFF6B7280))),
          const SizedBox(height: 8),
          Row(
            children: List.generate(numbers.length, (index) {
              final grayScale = 255 - (index * 18);
              final tone = grayScale.clamp(20, 230);
              final bg = Color.fromARGB(255, tone, tone, tone);
              final fg = tone < 120 ? Colors.white : Colors.black87;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == numbers.length - 1 ? 0 : 4),
                  child: _RankNumberTile(
                    rank: _ordinal(index + 1),
                    value: numbers[index],
                    background: bg,
                    foreground: fg,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Container(
            height: 34,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 15, color: Colors.white),
                SizedBox(width: 6),
                Text('Check If I Won', style: TextStyle(fontSize: 12.5, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _ordinal(int value) {
    switch (value) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
      default:
        return '${value}th';
    }
  }
}

class _RankNumberTile extends StatelessWidget {
  final String rank;
  final String value;
  final Color background;
  final Color foreground;

  const _RankNumberTile({
    required this.rank,
    required this.value,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(rank, style: TextStyle(fontSize: 7, color: foreground, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 11, color: foreground, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class QuiniResultCard extends StatelessWidget {
  final String title;
  final String date;
  final String jackpot;
  final List<String> numbers;

  const QuiniResultCard({
    super.key,
    required this.title,
    required this.date,
    required this.jackpot,
    required this.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black87, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500))),
              Text(date, style: const TextStyle(fontSize: 10.5, color: Color(0xFF6B7280))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            decoration: BoxDecoration(color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jackpot Winner', style: TextStyle(fontSize: 10.5, color: Colors.white70)),
                const SizedBox(height: 2),
                Text(jackpot, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text('Winning Numbers', style: TextStyle(fontSize: 10.5, color: Color(0xFF6B7280))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: numbers
                .map(
                  (number) => Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Text(number, style: const TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
