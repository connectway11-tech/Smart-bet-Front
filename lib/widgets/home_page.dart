import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 24),
                    child: HomePageContent(),
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
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  static const List<Map<String, String>> _games = [
    {
      'title': 'Tómbola Jujeña',
      'subtitle': 'Jujeña',
      'asset': 'assets/images/tombola_logo.svg',
      'badge': 'Cierra en 15min',
      'badgeTone': 'orange',
      'cta': 'Jujeña',
    },
    {
      'title': 'Loto Plus',
      'subtitle': 'Pozo: \$450 Millones',
      'asset': 'assets/images/loto.svg',
      'badge': 'Hoy 21:00 hs',
      'badgeTone': 'green',
      'cta': 'Acumulado Gigante',
    },
    {
      'title': 'Quini 6',
      'subtitle': 'Tradicional',
      'asset': 'assets/images/quini.svg',
      'badge': 'Mañana',
      'badgeTone': 'blue',
      'cta': 'Tradicional',
    },
    {
      'title': 'Telekino',
      'subtitle': 'Con Rekino',
      'asset': 'assets/images/telekino.png',
      'badge': 'Domingo',
      'badgeTone': 'purple',
      'cta': 'Premio Millonario',
    },
    {
      'title': 'Raspaditas',
      'subtitle': 'Ganás al instante',
      'asset': 'assets/images/raspaditas.svg',
      'badge': 'Instantáneo',
      'badgeTone': 'green',
      'cta': 'Desde \$100',
    },
    {
      'title': 'Brinco',
      'subtitle': 'Sorteo diario',
      'asset': 'assets/images/brinco.jpg',
      'badge': 'Hoy 18:00 hs',
      'badgeTone': 'blue',
      'cta': 'Próximo sorteo: 18:00 hs',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          '¿Qué querés jugar hoy?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: Color(0xFF253041),
            height: 1.08,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 250,
          child: Text(
            'Elegí tu juego favorito y probá tu suerte',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.25,
              color: Colors.blueGrey.shade300,
            ),
          ),
        ),
        const SizedBox(height: 26),
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = 2;
            final width = constraints.maxWidth;
            if (width > 930) {
              columns = 4;
            } else if (width > 700) {
              columns = 3;
            }

            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.99,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ..._games.map(
                  (game) => GameCard(
                    title: game['title']!,
                    subtitle: game['subtitle']!,
                    asset: game['asset']!,
                    badge: game['badge']!,
                    badgeTone: game['badgeTone']!,
                    cta: game['cta']!,
                    fit: game['fit'] == 'cover' ? BoxFit.cover : BoxFit.contain,
                  ),
                ),
                const MoreGamesCard(),
              ],
            );
          },
        ),
        const SizedBox(height: 38),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Accesos Rápidos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.blueGrey.shade900,
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            QuickTile(
              title: 'Números de la Suerte',
              subtitle: 'Generá números aleatorios',
              accent: Color(0xFFA855F7),
              icon: Icons.casino_outlined,
            ),
            QuickTile(
              title: 'Mis Números Favoritos',
              subtitle: '5 números guardados',
              accent: Color(0xFFD4A10D),
              icon: Icons.star_rounded,
              emphasis: '5 números',
            ),
            QuickTile(
              title: 'Historial de Jugadas',
              subtitle: '15 jugadas este mes',
              accent: Color(0xFF2563EB),
              icon: Icons.assignment_outlined,
              emphasis: '15 jugadas',
            ),
            QuickTile(
              title: 'Mi Balance',
              subtitle: '3 jugadas pendientes',
              accent: Color(0xFF10B981),
              icon: Icons.account_balance_wallet_outlined,
              amount: '\$1.250,00',
              highlighted: true,
            ),
          ],
        ),
        const SizedBox(height: 72),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  final String badge;
  final String badgeTone;
  final String cta;
  final BoxFit fit;

  const GameCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.asset,
    required this.badge,
    required this.badgeTone,
    required this.cta,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final badgeStyle = _badgeTheme(badgeTone);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7EBF2)),
        boxShadow: const [
          BoxShadow(color: Color(0x040F172A), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeStyle.backgroundColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  badge,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: badgeStyle.textColor),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 82,
                    child: Center(child: GameLogo(asset: asset, fit: fit)),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF273041),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                cta,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _BadgeTheme _badgeTheme(String tone) {
    switch (tone) {
      case 'orange':
        return const _BadgeTheme(Color(0xFFFFF1E8), Color(0xFFF97316));
      case 'green':
        return const _BadgeTheme(Color(0xFFEAFBF2), Color(0xFF16A34A));
      case 'blue':
        return const _BadgeTheme(Color(0xFFEAF2FF), Color(0xFF2563EB));
      case 'purple':
        return const _BadgeTheme(Color(0xFFF3E8FF), Color(0xFFA855F7));
      default:
        return const _BadgeTheme(Color(0xFFF3F4F6), Color(0xFF6B7280));
    }
  }
}

class _BadgeTheme {
  final Color backgroundColor;
  final Color textColor;

  const _BadgeTheme(this.backgroundColor, this.textColor);
}

class GameLogo extends StatelessWidget {
  final String asset;
  final BoxFit fit;

  const GameLogo({super.key, required this.asset, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    if (asset.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        fit: fit,
        placeholderBuilder: (context) => const Icon(Icons.videogame_asset, color: Colors.indigo),
      );
    }

    return Image.asset(
      asset,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.videogame_asset, color: Colors.indigo),
    );
  }
}

class MoreGamesCard extends StatelessWidget {
  const MoreGamesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD3D9E5)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Color(0xFF9CA3AF), size: 23),
            ),
            const SizedBox(height: 14),
            const Text(
              'Más Juegos',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF4B5563)),
            ),
            const SizedBox(height: 6),
            const Text(
              'Descubrí otras opciones',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? emphasis;
  final String? amount;
  final Color accent;
  final IconData icon;
  final bool highlighted;

  const QuickTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
    this.emphasis,
    this.amount,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 196,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFFEDFCF3) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: highlighted ? const Color(0xFFBBF7D0) : const Color(0xFFE7EBF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, size: 16, color: accent),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF273041)),
          ),
          if (amount != null) ...[
            const SizedBox(height: 8),
            Text(
              amount!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: accent),
            ),
          ],
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 11, color: Color(0xFF8B95A7), height: 1.3),
              children: [
                if (emphasis != null)
                  TextSpan(
                    text: emphasis!,
                    style: TextStyle(fontWeight: FontWeight.w700, color: accent),
                  ),
                TextSpan(text: emphasis != null ? subtitle.replaceFirst(emphasis!, '') : subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE7EBF2)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 860;

          final brand = Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _FooterLogo(),
              SizedBox(width: 14),
              _FooterDivider(),
              SizedBox(width: 14),
              Flexible(
                child: Text(
                  '©2024 INPROJUY - Instituto Provincial de Juegos de Azar de Jujuy',
                  style: TextStyle(fontSize: 10.5, color: Color(0xFF6B7280)),
                ),
              ),
            ],
          );

          final links = Wrap(
            spacing: 22,
            runSpacing: 8,
            children: const [
              Text('Términos y Condiciones', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
              Text('Juego Responsable', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
              Text('Ayuda', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                brand,
                const SizedBox(height: 12),
                links,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: brand),
              const SizedBox(width: 18),
              Flexible(child: Align(alignment: Alignment.centerRight, child: links)),
            ],
          );
        },
      ),
    );
  }
}

class _FooterDivider extends StatelessWidget {
  const _FooterDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      color: const Color(0xFFE5E7EB),
    );
  }
}

class _FooterLogo extends StatelessWidget {
  const _FooterLogo();

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xFF475569);
    const teal = Color(0xFF14B8A6);
    const orange = Color(0xFFF97316);

    return SizedBox(
      width: 58,
      height: 36,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 10,
            child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: orange, shape: BoxShape.circle)),
          ),
          Positioned(
            left: 3,
            top: 2,
            child: Container(width: 5, height: 16, decoration: BoxDecoration(color: teal, borderRadius: BorderRadius.circular(6))),
          ),
          Positioned(
            left: 12,
            top: 0,
            child: Container(width: 5, height: 22, decoration: BoxDecoration(color: dark, borderRadius: BorderRadius.circular(6))),
          ),
          const Positioned(
            left: 22,
            top: 1,
            child: Text('IN', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: dark)),
          ),
          const Positioned(
            left: 22,
            top: 11,
            child: Text('PRO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: teal)),
          ),
          const Positioned(
            left: 22,
            top: 22,
            child: Text('JUY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: orange)),
          ),
        ],
      ),
    );
  }
}
