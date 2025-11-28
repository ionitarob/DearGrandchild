import 'package:flutter/material.dart';

class MemoriesPage extends StatelessWidget {
  const MemoriesPage({super.key});

  // Placeholder sample data - real app should load persisted recordings
  List<Map<String, String>> get _sampleRecords => const [
        {'title': 'La meva infància', 'date': '17 abril 2024'},
        {'title': 'El meu primer treball', 'date': '1 març 2023'},
        {'title': 'Un viatge especial', 'date': '12 juny 2022'},
      ];

  @override
  Widget build(BuildContext context) {
    final records = _sampleRecords;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis memorias'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: records.isEmpty
            ? const Center(
                child: Text('No hay grabaciones guardadas', style: TextStyle(fontSize: 18)),
              )
            : ListView.separated(
                itemCount: records.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = records[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(item['title'] ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      subtitle: Text(item['date'] ?? '', style: const TextStyle(color: Colors.black54)),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow_rounded),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reproduciendo: ${item['title']}')));
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
