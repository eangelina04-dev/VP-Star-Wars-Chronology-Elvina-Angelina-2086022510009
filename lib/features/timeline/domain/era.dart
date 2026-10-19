enum Era {
  prequel(
    'Prequel Era',
    'A fragile Republic, the outbreak of the Clone Wars, and the fall of Anakin Skywalker into Darth Vader.',
    'assets/images/eras/prequel.jpg',
  ),
  original(
    'Original Trilogy',
    'The Rebellion against the Empire, from the first Death Star to the redemption of Darth Vader.',
    'assets/images/eras/original.jpg',
  ),
  sequel(
    'Sequel Era',
    'The rise of the First Order and the end of the Skywalker family\'s journey.',
    'assets/images/eras/sequel.jpg',
  );

  const Era(this.label, this.description, this.imageAsset);

  final String label;
  final String description;
  final String imageAsset;
}