class Gender{
  const Gender(this.key,this.value);
  final String key;
  final int value;
}

  const List<Gender> genders =[
    const Gender("Cinsiyet Seçiniz", -1),
    const Gender("Erkek", 0),
    const Gender("Kız", 1),
  ];
