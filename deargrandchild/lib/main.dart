import 'package:flutter/material.dart';
import 'pages/memories_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final warmSeed = Colors.deepOrange.shade200;

    return MaterialApp(
      title: 'DearGrandchild',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: warmSeed),
        scaffoldBackgroundColor: const Color(0xFFF7EFE6), // soft warm background
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/memories': (context) => const MemoriesPage(),
        '/settings': (context) => const SettingsPage(),
      },
      initialRoute: '/',
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _themes = [
    'La meva infància',
    'Els meus amics',
    'La meva escola',
    'Un viatge especial',
    'Tema lliure',
  ];

  int _selectedThemeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top greeting and small description
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bienvenido, Manolo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('Pulsa HABLAR para iniciar. Elige un tema si quieres centrar la conversación.', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),

            // Horizontal list of selectable themes
            SizedBox(
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _themes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final selected = index == _selectedThemeIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedThemeIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? Colors.deepOrangeAccent.shade100 : const Color(0xFFF7EFE6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: selected ? Colors.deepOrangeAccent : Colors.transparent, width: 1.5),
                        boxShadow: selected
                            ? [BoxShadow(color: Colors.deepOrangeAccent.withOpacity(0.15), blurRadius: 6, offset: const Offset(0, 3))]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          _themes[index],
                          style: TextStyle(fontSize: 16, fontWeight: selected ? FontWeight.w600 : FontWeight.w500, color: Colors.black87),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Spacer
            const Expanded(child: SizedBox()),

            // Main action button centered
            Center(
              child: Semantics(
                button: true,
                label: 'HABLAR',
                child: ElevatedButton(
                  onPressed: () {
                    final theme = _themes[_selectedThemeIndex];
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Iniciando conversación sobre: $theme')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent.shade200,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(340, 120),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                  ),
                  child: const Text(
                    'HABLAR',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: 1.2),
                  ),
                ),
              ),
            ),

            // Spacer between main button and bottom controls
            const SizedBox(height: 36),

            // Bottom controls: Memories and Settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/memories');
                      },
                      icon: const Icon(Icons.memory_outlined, color: Colors.black54),
                      label: const Text('Mis memorias', style: TextStyle(color: Colors.black87)),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFAF0E6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/settings');
                      },
                      icon: const Icon(Icons.settings_outlined, color: Colors.black54),
                      label: const Text('Ajustes', style: TextStyle(color: Colors.black87)),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFAF0E6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
