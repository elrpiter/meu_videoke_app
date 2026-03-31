import 'package:flutter/material.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista fictícia para testarmos o visual do seu portfólio
  final List<Map<String, String>> _songs = [
    {'title': 'Evidências', 'artist': 'Chitãozinho & Xororó'},
    {'title': 'Bohemian Rhapsody', 'artist': 'Queen'},
    {'title': 'Como Nossos Pais', 'artist': 'Elis Regina'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Fundo quase preto (Moderno)
      appBar: AppBar(
        title: const Text('MEU VIDEOKÊ PRO', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Campo de Busca
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar música ou artista...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(IconData(0xe567, fontFamily: 'MaterialIcons'), color: Colors.deepPurpleAccent),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          // Lista de Músicas
          Expanded(
            child: ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(IconData(0xe4e3, fontFamily: 'MaterialIcons'), color: Colors.white),
                  ),
                  title: Text(_songs[index]['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(_songs[index]['artist']!, style: const TextStyle(color: Colors.grey)),
                  trailing: const Icon(IconData(0xe40f, fontFamily: 'MaterialIcons'), color: Colors.greenAccent),
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(songTitle: _songs[index]['title']!),
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