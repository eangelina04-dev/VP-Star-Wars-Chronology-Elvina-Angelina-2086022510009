enum Era {
  prequel(
    'Prequel Era',
    'Republik yang rapuh, pecahnya Clone Wars, dan jatuhnya Anakin Skywalker menjadi Darth Vader.',
  ),
  original(
    'Original Trilogy',
    'Pemberontakan melawan Kekaisaran, dari Death Star pertama hingga penebusan Darth Vader.',
  ),
  sequel(
    'Sequel Era',
    'Bangkitnya First Order dan akhir dari perjalanan keluarga Skywalker.',
  );

  const Era(this.label, this.description);

  final String label;
  final String description;
}
