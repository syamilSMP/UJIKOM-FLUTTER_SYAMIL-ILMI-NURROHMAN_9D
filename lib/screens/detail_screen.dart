import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(221, 0, 0, 0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          pokemon.name,
          style: const TextStyle(color: Color(0xFF222222)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF222222),
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFDDDDDD)),
            ),
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  pokemon.imagePath,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.catching_pokemon,
                    size: 50,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFDDDDDD)),
            ),
            child: Column(
              children: [
                Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _typeBox(pokemon.type1),
                    if (pokemon.type2.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      _typeBox(pokemon.type2),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox('Deskripsi', pokemon.description),
          const SizedBox(height: 12),
          _statsBox(pokemon.stats),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _infoBox('Ability', pokemon.ability)),
              const SizedBox(width: 12),
              Expanded(child: _infoBox('Evolusi', pokemon.evolution)),
            ],
          ),
          const SizedBox(height: 12),
          _infoBox('Weaknesses', pokemon.weaknesses.join(' • ')),
          const SizedBox(height: 12),
          _infoBox('Role', pokemon.role),
          const SizedBox(height: 12),
          _infoBox('Partner', pokemon.partners.join(' → ')),
        ],
      ),
    );
  }

  Widget _typeBox(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type,
        style: const TextStyle(color: Color(0xFF444444), fontSize: 11),
      ),
    );
  }

  Widget _infoBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
          ),
        ],
      ),
    );
  }

  Widget _statsBox(Map<String, int> stats) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stats',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 8),
          ...stats.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 55,
                    child: Text(
                      e.key,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF444444),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (e.value / 255).clamp(0.0, 1.0),
                      backgroundColor: const Color(0xFFEEEEEE),
                      color: const Color(0xFF666666),
                      minHeight: 4,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 30,
                    child: Text(
                      '${e.value}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF444444),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
