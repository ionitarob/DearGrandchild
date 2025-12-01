import 'package:flutter/material.dart';
import 'dart:math';

class MemoriesPage extends StatefulWidget {
  const MemoriesPage({super.key});

  @override
  State<MemoriesPage> createState() => _MemoriesPageState();
}

class _MemoriesPageState extends State<MemoriesPage> {
  int _currentPage = 0;
  final int _itemsPerPage = 4;

  // Lista de ejemplo
  List<Map<String, String>> get _allRecords => const [
        {'title': 'Mi infancia', 'date': '23 noviembre 2025', 'duration': '12 min'},
        {'title': 'Mi primer trabajo', 'date': '22 noviembre 2025', 'duration': '8 min'},
        {'title': 'Un viaje muy especial', 'date': '20 noviembre 2025', 'duration': '24 min'},
        {'title': 'Cómo conocí a la abuela', 'date': '15 noviembre 2025', 'duration': '31 min'},
        {'title': 'La boda de mi hija', 'date': '10 noviembre 2025', 'duration': '45 min'},
        {'title': 'Mis amigos del colegio', 'date': '05 noviembre 2025', 'duration': '15 min'},
        {'title': 'Receta de la paella', 'date': '01 noviembre 2025', 'duration': '10 min'},
        {'title': 'Aquel verano en el pueblo', 'date': '28 octubre 2025', 'duration': '22 min'},
        {'title': 'Consejos para mis nietos', 'date': '25 octubre 2025', 'duration': '50 min'},
        {'title': 'La primera mascota', 'date': '20 octubre 2025', 'duration': '14 min'},
      ];

  void _nextPage() {
    final totalPages = (_allRecords.length / _itemsPerPage).ceil();
    if (_currentPage < totalPages - 1) {
      setState(() => _currentPage++);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  void _openPlaybackPage(Map<String, String> memory) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaybackPage(memoryData: memory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalRecords = _allRecords.length;
    final totalPages = (totalRecords / _itemsPerPage).ceil();
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = min(startIndex + _itemsPerPage, totalRecords);
    final currentRecords = _allRecords.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: false,
        leadingWidth: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          iconSize: 48,
          color: Colors.black87,
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver atrás',
        ),
        title: const Text(
          'Mis memorias',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            // LISTA DE MEMORIAS
            Expanded(
              child: currentRecords.isEmpty
                  ? const Center(child: Text('No hay grabaciones.', style: TextStyle(fontSize: 24)))
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: currentRecords.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = currentRecords[index];
                        return Card(
                          color: const Color.fromARGB(255, 255, 222, 144),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          clipBehavior: Clip.antiAlias, 
                          child: InkWell(
                            onTap: () => _openPlaybackPage(item),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                      height: 1.1
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${item['duration']} • ${item['date']}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // CONTROLES DE PAGINACIÓN
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  Text(
                    'Página ${_currentPage + 1} de $totalPages',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _currentPage > 0 ? _prevPage : null,
                          icon: const Icon(Icons.arrow_back_ios_rounded, size: 32),
                          label: const Text('ANTERIOR', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 188, 195, 255),
                            foregroundColor: Colors.brown.shade900,
                            disabledBackgroundColor: Colors.grey.shade300,
                            disabledForegroundColor: Colors.grey.shade500,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            onPressed: _currentPage < totalPages - 1 ? _nextPage : null,
                            icon: const Icon(Icons.arrow_back_ios_rounded, size: 32),
                            label: const Text('SIGUIENTE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 188, 195, 255),
                              foregroundColor: Colors.brown.shade900,
                              disabledBackgroundColor: Colors.grey.shade300,
                              disabledForegroundColor: Colors.grey.shade500,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
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

// ==========================================
// NUEVA PANTALLA: MENÚ DE REPRODUCCIÓN
// ==========================================

class PlaybackPage extends StatelessWidget {
  final Map<String, String> memoryData;

  const PlaybackPage({super.key, required this.memoryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: false,
        leadingWidth: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          iconSize: 48,
          color: Colors.black87,
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver atrás',
        ),
        title: const Text(
          'Escuchar memoria',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              // 1. TÍTULO Y FECHA
              Text(
                memoryData['title'] ?? 'Sin título',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  color: Colors.black87
                ),
              ),
              const SizedBox(height: 8),
              Text(
                memoryData['date'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500
                ),
              ),

              const SizedBox(height: 40),

              // 2. PANEL REPRODUCTOR (Visual)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.deepOrange.shade100, width: 2),
                ),
                child: Column(
                  children: [
                    Icon(Icons.graphic_eq_rounded, size: 80, color: Colors.deepOrange.shade300),
                    const SizedBox(height: 20),
                    
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 12,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 30),
                        activeTrackColor: Colors.deepOrangeAccent,
                        inactiveTrackColor: Colors.deepOrange.shade100,
                        thumbColor: Colors.deepOrange,
                      ),
                      child: Slider(
                        value: 0.3, 
                        onChanged: (v) {}, 
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('03:45', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          Text(memoryData['duration'] ?? '00:00', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.replay_10_rounded),
                          iconSize: 56,
                          color: Colors.black54,
                          onPressed: () {},
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent.shade200,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.deepOrange.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))]
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.pause_rounded),
                            iconSize: 64,
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.forward_10_rounded),
                          iconSize: 56,
                          color: Colors.black54,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // 3. BOTÓN CONTINUAR GRABANDO (Más grande)
              ElevatedButton.icon(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abriendo grabadora...')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent.shade200,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 24), // Aumentado
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                ),
                icon: const Icon(Icons.mic_rounded, size: 36), // Icono más grande
                label: const Text(
                  'CONTINUAR GRABANDO',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800), // Texto más grande
                ),
              ),

              const SizedBox(height: 24),

              // 4. BOTÓN BORRAR GRABACIÓN (Con confirmación y banner)
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      titlePadding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                      contentPadding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      actionsPadding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      
                      title: const Text(
                        '¿BORRAR GRABACIÓN?',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)
                      ),
                      content: const Text(
                        'ESTA ACCIÓN NO SE PUEDE DESHACER. ¿ESTÁS SEGURO?',
                        style: TextStyle(fontSize: 24, height: 1.3, color: Colors.black87)
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('CANCELAR', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black54)),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx); // Cierra diálogo
                                Navigator.pop(context); // Vuelve a la lista de memorias
                                
                                // Muestra banner de confirmación
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Grabación eliminada correctamente.',
                                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white)
                                    ),
                                    backgroundColor: Colors.redAccent.shade700,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              child: const Text('BORRAR', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent.shade700,
                  backgroundColor: Colors.red.shade50,
                  padding: const EdgeInsets.symmetric(vertical: 24), // Aumentado
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                icon: const Icon(Icons.delete_outline_rounded, size: 36), // Icono más grande
                label: const Text(
                  'BORRAR GRABACIÓN',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700), // Texto más grande
                ),
              ),
              
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}