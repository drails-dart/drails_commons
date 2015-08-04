library GetVarialbesAndGettersTest_test;

import 'package:test/test.dart';
import 'package:drails_commons/drails_commons.dart';
import "package:reflectable/reflectable.dart";


const reflectable = const Reflectable(invokingCapability, metadataCapability);

@reflectable
class ObjectWithMembers {
  String name;
  int age;
}

@reflectable
class ExtendedObject extends ObjectWithMembers {
  String myProp;
}

main() {
  group('Get public Variables and Getters ->', (){
    test('test1', () {
      expect(getPublicVariablesAndGettersFromClass(reflectable.reflectType(ObjectWithMembers), reflectable).length, 2);
    });

    test('test2', () {
      expect(getPublicVariablesAndGettersFromClass(reflectable.reflectType(ExtendedObject), reflectable).length, 3);
    });
  });
}