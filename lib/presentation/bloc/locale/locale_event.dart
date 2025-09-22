abstract class LocaleEvent {}

class OnChangeLocaleEvent extends LocaleEvent {
  final String locale;

  OnChangeLocaleEvent(this.locale);
}

class OnInitLocaleEvent extends LocaleEvent {}
