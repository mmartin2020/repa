class Language {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  Language(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    this._languages = [
      new Language("en", "English", "English", "Assets/flags/usa.png",
          selected: false),
      new Language("ar", "Arabic", "العربية", "Assets/flags/uae.png"),
      new Language("es", "Spanish", "Spana", "Assets/flags/spain.png",
          selected: true),
      new Language("fr", "French (Canada)", "Français - Canadien",
          "Assets/flags/canada.png"),
      new Language("pr", "Brazilian", "Brazilian", "Assets/flags/brazil.png"),
    ];
  }

  List<Language> get languages => _languages;
}
