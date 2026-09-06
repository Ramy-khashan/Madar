class NavbarRefresh {
  NavbarRefresh._();

  static void Function({bool resetToHome})? _reload;

  static void bind(void Function({bool resetToHome}) reload) => _reload = reload;

  static void unbind(void Function({bool resetToHome}) reload) {
    if (_reload == reload) _reload = null;
  }

  static void reload({bool resetToHome = false}) {
    _reload?.call(resetToHome: resetToHome);
  }
}
