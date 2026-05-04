import 'package:flutter/material.dart';

class Pokemon {
  final int id;
  final String name;
  final String imagePath;
  final String type1;
  final String type2;
  final Map<String, int> stats;
  final String ability;
  final List<String> weaknesses;
  final String evolution;
  final String description;
  final String role;
  final List<String> partners;

  Pokemon({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.type1,
    required this.type2,
    required this.stats,
    required this.ability,
    required this.weaknesses,
    required this.evolution,
    required this.description,
    required this.role,
    required this.partners,
  });

  String get types {
    if (type2.isEmpty) return type1;
    return '$type1 / $type2';
  }

  Color getTypeColor() {
    switch (type1.toLowerCase()) {
      case 'grass':
        return const Color(0xFF78C850);
      case 'fire':
        return const Color(0xFFF08030);
      case 'water':
        return const Color(0xFF6890F0);
      case 'electric':
        return const Color(0xFFF8D030);
      case 'ghost':
        return const Color(0xFF705898);
      case 'poison':
        return const Color(0xFFA040A0);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'normal':
        return const Color(0xFFA8A878);
      case 'fighting':
        return const Color(0xFFC03028);
      case 'psychic':
        return const Color(0xFFF85888);
      case 'rock':
        return const Color(0xFFB8A038);
      case 'dark':
        return const Color(0xFF705848);
      case 'flying':
        return const Color(0xFFA890F0);
      default:
        return const Color(0xFFAAAAAA);
    }
  }
}
