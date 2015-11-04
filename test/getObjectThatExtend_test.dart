library getObjectThatExtend_test;

import 'package:test/test.dart';
import 'package:drails_commons/drails_commons.dart';
import "package:reflectable/reflectable.dart";


const MyReflectable reflectable = const MyReflectable();

class MyReflectable extends  Reflectable {
  const MyReflectable() : super(
      invokingCapability,
      metadataCapability,
      typeCapability,
      typeRelationsCapability,
      declarationsCapability,
      libraryCapability
  );
}


@reflectable
abstract class Service1 {}

@reflectable
class Service1Impl implements Service1 {}


@reflectable
abstract class Service2 {}

@reflectable
class Service2Impl implements Service2 {}

@reflectable
class Service22Impl extends Service2Impl {}


main() {
  test('Get Object that extends 1 level', () {

    var service1ImplCm = reflectable.annotatedClasses.singleWhere((cm) => cm.simpleName == 'Service1');

    var dms = reflectable
        .findLibrary('getObjectThatExtend_test')
        .declarations
        .values;
    expect(getObjectThatExtend(service1ImplCm, dms), new isInstanceOf<Service1Impl>());
  });


  test('Get Object that extends 2 levels', () {

    var service2ImplCm = reflectable.annotatedClasses.singleWhere((cm) => cm.simpleName == 'Service2');

    var dms = reflectable
        .findLibrary('getObjectThatExtend_test')
        .declarations
        .values;
    expect(getObjectThatExtend(service2ImplCm, dms), new isInstanceOf<Service22Impl>());
  });
}