import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEEEEEE),
              ),
              child: ClipOval(
                child: Image.asset(
                  pokemon.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.catching_pokemon,
                    size: 35,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Nomor
            Text(
              '#${pokemon.id.toString().padLeft(3, '0')}',
              style: const TextStyle(fontSize: 10, color: Color(0xFF888888)),
            ),

            // Nama
            Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF222222),
              ),
            ),

            const SizedBox(height: 4),

            // Tipe
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTypeChip(pokemon.type1),
                if (pokemon.type2.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  _buildTypeChip(pokemon.type2),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type,
        style: const TextStyle(color: Color(0xFF444444), fontSize: 9),
      ),
    );
  }
}
