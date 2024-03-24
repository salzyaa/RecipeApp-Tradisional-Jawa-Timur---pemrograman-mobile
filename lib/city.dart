class City {
  String label;
  String imageUrl;

  City(this.label, this.imageUrl);

  // Daftar kota
  static List<City> samples = [
    City('Surabaya', 'assets/sby.jpg'),
    City('Banyuwangi', 'assets/banyuwangi.png'),
    City('Probolinggo', 'assets/probolinggo.jpg'),
    City('Madura', 'assets/madura.jpg'),
  ];
}
