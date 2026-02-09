import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Map<String, String>> _games = [
    {'title': 'Tómbola Jujena', 'subtitle': 'Jujena', 'asset': 'assets/images/tombola.svg'},
    {'title': 'Loto Plus', 'subtitle': 'Pozos', 'asset': 'assets/images/loto.svg'},
    {'title': 'Quini 6', 'subtitle': 'Tradicional', 'asset': 'assets/images/quini.svg'},
    {'title': 'Telekino', 'subtitle': 'Con Rekino', 'asset': 'assets/images/telekino.svg'},
    {'title': 'Raspaditas', 'subtitle': 'Instantáneo', 'asset': 'assets/images/raspaditas.svg'},
    {'title': 'Brinco', 'subtitle': 'Sorteo diario', 'asset': 'assets/images/brinco.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Inicio', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: Text('\$1.250,00', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700))),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: CircleAvatar(child: Icon(Icons.person)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1100),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple.shade200, width: 2),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    children: [
                      Text('¿Qué querés jugar hoy?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.grey.shade900)),
                      const SizedBox(height: 6),
                      Text('Elegí tu juego favorito y probá tu suerte', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Grid of games
                LayoutBuilder(builder: (context, constraints) {
                  int columns = 2;
                  double w = constraints.maxWidth;
                  if (w > 1000) columns = 4;
                  else if (w > 800) columns = 3;

                  return GridView.count(
                    crossAxisCount: columns,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.4,
                    children: List.generate(_games.length + 1, (index) {
                      if (index == _games.length) {
                        return DottedCard();
                      }
                      final game = _games[index];
                      // add small status badges for a couple of games to match the mock
                      String? badge;
                      if (game['title'] == 'Loto Plus') badge = 'Hoy 21:00 hs';
                      if (game['title'] == 'Brinco') badge = 'Hoy 18:00 hs';

                      return GameCard(title: game['title']!, subtitle: game['subtitle']!, asset: game['asset']!, badge: badge);
                    }),
                  );
                }),

                const SizedBox(height: 24),
                const Text('Accesos Rápidos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),

                // Quick access tiles
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: const [
                    QuickTile(title: 'Números de la Suerte', subtitle: 'Generá números aleatorios', icon: Icons.casino),
                    QuickTile(title: 'Mis Números Favoritos', subtitle: '5 números guardados', icon: Icons.star),
                    QuickTile(title: 'Historial de Jugadas', subtitle: '15 jugadas este mes', icon: Icons.history),
                    QuickTile(title: 'Mi Balance', subtitle: '\$1.250,00', icon: Icons.account_balance_wallet, highlight: true),
                  ],
                ),

                const SizedBox(height: 40),
                Center(child: Text('©2026 INPROJUY - Instituto Provincial de Juegos de Azar de Jujuy', style: TextStyle(color: Colors.black45))),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  final String? badge;
  const GameCard({super.key, required this.title, required this.subtitle, required this.asset, this.badge});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (badge != null)
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Text(badge!, style: const TextStyle(fontSize: 11, color: Colors.green)),
                ),
              ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(color: Colors.indigo.shade50, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        asset,
                        width: 40,
                        height: 40,
                        placeholderBuilder: (context) => const Icon(Icons.videogame_asset, color: Colors.indigo),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 6),
                        Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Align(alignment: Alignment.bottomRight, child: Text('Ver', style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.w600)))
          ],
        ),
      ),
    );
  }
}

class DottedCard extends StatelessWidget {
  const DottedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: Colors.grey.shade300)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add, size: 36, color: Colors.black38),
            SizedBox(height: 8),
            Text('Más Juegos', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

class QuickTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool highlight;
  const QuickTile({super.key, required this.title, required this.subtitle, required this.icon, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: highlight ? Colors.green : Colors.indigo)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12))])),
        ],
      ),
    );

    return card;
  }
}
