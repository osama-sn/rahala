class CityModel {
  final String name;
  const CityModel({required this.name});
}

class AppCities {
  AppCities._();

  static const List<CityModel> list = [
    CityModel(name: 'القاهرة'),
    CityModel(name: 'الإسكندرية'),
    CityModel(name: 'دهب'),
    CityModel(name: 'شرم الشيخ'),
    CityModel(name: 'الغردقة'),
    CityModel(name: 'الأقصر'),
    CityModel(name: 'أسوان'),
    CityModel(name: 'سيوة'),
    CityModel(name: 'نويبع'),
    CityModel(name: 'مرسى علم'),
    CityModel(name: 'طابا'),
    CityModel(name: 'العين السخنة'),
    CityModel(name: 'رأس سدر'),
    CityModel(name: 'الفيوم'),
    CityModel(name: 'المنصورة'),
    CityModel(name: 'طنطا'),
    CityModel(name: 'الإسماعيلية'),
    CityModel(name: 'بورسعيد'),
    CityModel(name: 'أسيوط'),
    CityModel(name: 'سوهاج'),
    CityModel(name: 'قنا'),
    CityModel(name: 'المنيا'),
    CityModel(name: 'كفر الشيخ'),
    CityModel(name: 'الزقازيق'),
    CityModel(name: 'مرسى مطروح'),
  ];
}
