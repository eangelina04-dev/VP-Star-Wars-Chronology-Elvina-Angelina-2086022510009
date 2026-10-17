enum Era {
  prequel(
    'Prequel Era',
    'Republik yang rapuh, pecahnya Clone Wars, dan jatuhnya Anakin Skywalker menjadi Darth Vader.',
    '32 BBY – 19 BBY',
  ),
  original(
    'Original Trilogy',
    'Pemberontakan melawan Kekaisaran, dari Death Star pertama hingga penebusan Darth Vader.',
    '0 BBY/ABY – 4 ABY',
  ),
  sequel(
    'Sequel Era',
    'Bangkitnya First Order dan akhir dari perjalanan keluarga Skywalker.',
    '34 ABY – 35 ABY',
  );

  const Era(this.label, this.description, this.timeSpan);

  final String label;
  final String description;
  final String timeSpan;
}
