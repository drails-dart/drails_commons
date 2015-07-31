library GetAnnotations_test;

import 'package:unittest/unittest.dart';
import 'package:drails_commons/drails_commons.dart';
import "package:reflectable/reflectable.dart";


const reflectable = const Reflectable(invokingCapability, metadataCapability);

class Annotation1 {
  const Annotation1();
}

class Annotation2 {
  const Annotation2();
}

@reflectable
class ObjectWithoutAnnotations {
  
}

@Annotation1()
@Annotation1()
@Annotation2()
@reflectable
class ObjectWithAnnotations {
  
}

@reflectable
class ObjectWithMethodsWithAnnotations {
  @Annotation1()
  @Annotation1()
  method() {}
}

main() {
  group('Get all annotations ->', () {
    solo_test('from class', () {
      expect(new GetValuesOfAnnotations().fromInstance(reflectable.reflect(new ObjectWithoutAnnotations())), [reflectable]);
      expect(new GetValuesOfAnnotations<Annotation1>().fromInstance(reflectable.reflect(new ObjectWithAnnotations())), [const Annotation1(), const Annotation1()]);
      expect(new GetValuesOfAnnotations<Annotation2>().fromInstance(reflectable.reflect(new ObjectWithAnnotations())), [const Annotation2()]);
    });
    
    test('from method', () {
      var methodMirror = reflectable.reflect(new ObjectWithMethodsWithAnnotations()).type.declarations.values.first;
      
      expect(new GetValuesOfAnnotations<Annotation1>().fromDeclaration(methodMirror), [const Annotation1(), const Annotation1()]);
    });
  });
}