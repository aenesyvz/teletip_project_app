class OnBoard{
  final image,title,description;

  OnBoard({required this.image, required this.title, required this.description});
}

 List<OnBoard> demoData = [
  OnBoard(image: "assets/images/onboarding1.svg", title: "Doktorunuzu seçin", description:  'Doktorunuza mesaj yazın.'),
  OnBoard(image: "assets/images/onboarding2.svg", title: 'Doktordan randevu talep edin', description:  'Belgelerinizi doktorunuzla paylaşın'),
  OnBoard(image: "assets/images/onboarding3.svg", title:  'Son derece güvenilir', description:   'Bilgileriniz kesinlikle kimseyle paylaşılmaz')
];