part of drails_commons;

//TODO: when Issue 88 in Dart get resolved delete this file.

/** Enum base class */
abstract class Enum {
  final String name;
  const Enum(this.name);
  
  static const List<Enum> values = const [];
  
  Enum valueOf(String name) => values.singleWhere((val) => val.name == name);
}
