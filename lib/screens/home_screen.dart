import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../data/pokemon_data.dart';
import '../widgets/pokemon_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedType = 'All';

  List<String> get availableTypes {
    Set<String> types = {'All'};
    for (var pokemon in pokemonList) {
      types.add(pokemon.type1);
      if (pokemon.type2.isNotEmpty) types.add(pokemon.type2);
    }
    return types.toList();
  }

  List<Pokemon> get filteredPokemon {
    return pokemonList.where((pokemon) {
      bool matchesSearch = pokemon.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      bool matchesType =
          selectedType == 'All' ||
          pokemon.type1 == selectedType ||
          pokemon.type2 == selectedType;
      return matchesSearch && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'PokéInpo', // atau 'PokeInpo'
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Color(0xFF222222),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Pokémon...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF888888)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: availableTypes.length,
              itemBuilder: (context, index) {
                String type = availableTypes[index];
                bool isSelected = selectedType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(type, style: const TextStyle(fontSize: 12)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedType = type;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFFDDDDDD),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF222222)
                          : const Color(0xFF888888),
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                    side: const BorderSide(color: Color(0xFFDDDDDD)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Grid
          Expanded(
            child: filteredPokemon.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tidak ditemukan',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: filteredPokemon.length,
                    itemBuilder: (context, index) {
                      return PokemonCard(
                        pokemon: filteredPokemon[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(pokemon: filteredPokemon[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
