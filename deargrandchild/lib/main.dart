import 'package:flutter/material.dart';
import 'pages/memories_page.dart';
import 'pages/settings_page.dart';
import 'pages/recording_page.dart'; // <--- IMPORTANTE: Importamos la nueva página

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: warmSeed),
        scaffoldBackgroundColor: const Color(0xFFF7EFE6),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/memories': (context) => const MemoriesPage(),
        '/settings': (context) => const SettingsPage(),
        '/recording': (context) => const RecordingPage(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Cabecera: Saludo y textos grandes
              const SizedBox(height: 20),
              const Text(
                'Bienvenido, Manolo',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Pulsa un botón para comenzar.',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),

              // Este Spacer empuja todo el bloque de botones hacia el centro vertical
              const Spacer(),

              // 2. Botón Principal (HABLAR)
              Center(
                child: Semantics(
                  button: true,
                  label: 'Grabar nueva memoria',
                  child: ElevatedButton(
                    onPressed: () {
                      // <--- CAMBIO AQUÍ: Navegar a la página de grabación
                      Navigator.of(context).pushNamed('/recording');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent.shade200,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 140),
                      padding: const EdgeInsets.all(24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 8,
                      shadowColor: Colors.deepOrange.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.mic_rounded, size: 48),
                        SizedBox(height: 8),
                        Text(
                          'HABLAR',
                          style: TextStyle(
                            fontSize: 40, 
                            fontWeight: FontWeight.w800, 
                            letterSpacing: 1.5
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Separación fija en lugar de Spacer, para mantenerlos juntos
              const SizedBox(height: 24),

              // 3. Botones inferiores (Ahora pegados debajo del principal)
              Row(
                children: [
                  Expanded(
                    child: _BigSecondaryButton(
                      label: 'VER MIS MEMORIAS',
                      icon: Icons.auto_stories_rounded,
                      onTap: () => Navigator.of(context).pushNamed('/memories'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _BigSecondaryButton(
                      label: 'MÁS OPCIONES',
                      icon: Icons.settings_rounded,
                      onTap: () => Navigator.of(context).pushNamed('/settings'),
                    ),
                  ),
                ],
              ),

              // Este Spacer final equilibra la pantalla por abajo
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para los botones secundarios grandes
class _BigSecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _BigSecondaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange.shade100, // Color suave
        foregroundColor: Colors.brown.shade900, // Texto oscuro
        minimumSize: const Size(0, 90), // Altura grande
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.w700
            ),
          ),
        ],
      ),
    );
  }
}