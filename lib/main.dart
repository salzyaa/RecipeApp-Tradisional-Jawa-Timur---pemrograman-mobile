import 'package:flutter/material.dart';
import 'recipe_detail.dart';
import 'recipe.dart';
import 'city.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  // Membuat warna putih sebagai MaterialColor
  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      // Kunci dan nilai dalam bentuk map
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe calculator',
      theme: ThemeData(
        primarySwatch: white, // Menggunakan warna putih sebagai warna utama
      ),
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title; // Perbaiki penamaan variabel title

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCities = true;
  City? _selectedCity;

  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan halaman beranda
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: _showCities ? _buildCityList() : _buildRecipeList(),
      ),
    );
  }

  Widget _buildCityList() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makanan Tradisional Jawa Timur'), 
      ),
      body: ListView.builder(
        itemCount: City.samples.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _showCities = false;
                _selectedCity = City.samples[index];
              });
            },
            child: buildCityCard(City.samples[index]),
          );
        },
      ),
    );
  }

  Widget _buildRecipeList() {
    if (_selectedCity == null)
      return Container(); // Tambahkan pengecekan jika _selectedCity null

    List<Recipe> cityRecipes = Recipe.samples
        .where((recipe) => recipe.city.label == _selectedCity!.label)
        .toList();
    print('Selected City: ${_selectedCity!.label}');
    print('Number of Recipes for selected city: ${cityRecipes.length}');
    print(
        'List of Recipes for selected city: ${cityRecipes.map((recipe) => recipe.label)}');

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedCity!.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _showCities = true;
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: cityRecipes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RecipeDetail(recipe: cityRecipes[index]);
                  },
                ),
              );
            },
            child: buildRecipeCard(cityRecipes[index]),
          );
        },
      ),
    );
  }

  Widget buildCityCard(City city) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              city.imageUrl,
              width: 100,
              height: 100,
            ), // Menampilkan gambar dari asset
            const SizedBox(height: 14.0), 
            Text(
              city.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Image(
              image: AssetImage(recipe.imageUrl), 
              width: 100,
              height: 100,
              
            ),
            Text(
              recipe.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
