import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          'Ajustes',
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // 1. Botón MI PERFIL
              _SettingsButton(
                label: 'MANOLO - MI PERFIL',
                icon: Icons.person_rounded,
                color: Colors.blue.shade100,
                textColor: Colors.blue.shade900,
                onTap: () {},
              ),
              
              const SizedBox(height: 24),

              // 2. Botón OPCIONES DE GRABACIÓN
              _SettingsButton(
                label: 'OPCIONES DE GRABACIÓN',
                icon: Icons.graphic_eq_rounded,
                color: Colors.blueGrey.shade800,
                textColor: Colors.white,
                onTap: () {},
              ),

              const SizedBox(height: 24),

              // 3. Botón BORRAR DATOS con Diálogo Gigante
              _SettingsButton(
                label: 'BORRAR TODOS LOS DATOS',
                icon: Icons.delete_forever_rounded,
                color: Colors.redAccent.shade700,
                textColor: Colors.white,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)
                      ),
                      titlePadding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                      contentPadding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      actionsPadding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      
                      title: const Text(
                        '¿BORRAR TODOS LOS DATOS?',
                        style: TextStyle(
                          fontSize: 32, // Título muy grande
                          fontWeight: FontWeight.w800
                        )
                      ),
                      content: const Text(
                        'ESTO ELIMINARÁ TODAS TUS MEMORIAS. ¿ESTÁS SEGURO?',
                        style: TextStyle(
                          fontSize: 24, // Texto del cuerpo grande
                          height: 1.3,
                          color: Colors.black87
                        )
                      ),
                      actions: [
                        // Usamos Column para botones verticales grandes o Row para horizontales.
                        // En pantallas grandes, Row suele ir bien, pero asegurando altura.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: const Text(
                                'NO, SALIR', 
                                style: TextStyle(
                                  fontSize: 22, // Botón grande
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54
                                )
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx); // Cerrar diálogo
                                
                                // Mostrar confirmación de borrado
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Los datos han sido eliminados.',
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
                              child: const Text(
                                'SÍ, BORRAR', 
                                style: TextStyle(
                                  fontSize: 22, 
                                  fontWeight: FontWeight.w700
                                )
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _SettingsButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 4,
        ),
        child: Row(
          children: [
            Icon(icon, size: 48),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  color: textColor,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 24, color: textColor.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}