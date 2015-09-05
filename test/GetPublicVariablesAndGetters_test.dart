library GetVarialbesAndGettersTest_test;

import 'package:test/test.dart';
import 'package:drails_commons/drails_commons.dart';
import "package:reflectable/reflectable.dart";


const myReflectable = const MyReflectable();

class MyReflectable extends  Reflectable {
  const MyReflectable() : super(
      invokingCapability,
      metadataCapability,
      typeCapability,
      typeRelationsCapability,
      declarationsCapability);
}

@myReflectable
class ObjectWithMembers {
  String name;
  int age;
}

@myReflectable
class ExtendedObject extends ObjectWithMembers {
  String myProp;
}

main() {
  group('Get public Variables and Getters ->', (){
    test('test1', () {
      expect(getPublicVariablesAndGettersFromClass(myReflectable.reflectType(ObjectWithMembers), myReflectable).length, 2);
    });

    test('test2', () {
      expect(getPublicVariablesAndGettersFromClass(myReflectable.reflectType(ExtendedObject), myReflectable).length, 3);
    });
  });
}