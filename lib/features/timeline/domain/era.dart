enum Era {
  prequel(
    'Prequel Era',
    'Republik yang rapuh, pecahnya Clone Wars, dan jatuhnya Anakin Skywalker menjadi Darth Vader.',
    'assets/images/eras/prequel.jpg',
  ),
  original(
    'Original Trilogy',
    'Pemberontakan melawan Kekaisaran, dari Death Star pertama hingga penebusan Darth Vader.',
    'assets/images/eras/original.jpg',
  ),
  sequel(
    'Sequel Era',
    'Bangkitnya First Order dan akhir dari perjalanan keluarga Skywalker.',
    'assets/images/eras/sequel.jpg',
  );

  const Era(this.label, this.description, this.imageAsset);

  final String label;
  final String description;
  final String imageAsset;
}
