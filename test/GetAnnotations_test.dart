library GetAnnotations_test;

import 'package:unittest/unittest.dart';
import 'package:drails_commons/drails_commons.dart';
import 'dart:mirrors';

class Annotation1 {
  const Annotation1();
}

class Annotation2 {
  const Annotation2();
}

class ObjectWithoutAnnotations {
  
}

@Annotation1()
@Annotation1()
@Annotation2()
class ObjectWithAnnotations {
  
}

class ObjectWithMethodsWithAnnotations {
  @Annotation1()
  @Annotation1()
  method() {}
}

main() {
  group('Get all annotations ->', () {
    test('from class', () {
      expect(new GetValuesOfAnnotations().fromInstance(reflect(new ObjectWithoutAnnotations())), null);
      expect(new GetValuesOfAnnotations<Annotation1>().fromInstance(reflect(new ObjectWithAnnotations())), [const Annotation1(), const Annotation1()]);
      expect(new GetValuesOfAnnotations<Annotation2>().fromInstance(reflect(new ObjectWithAnnotations())), [const Annotation2()]);
    });
    
    test('from method', () {
      var methodMirror = reflect(new ObjectWithMethodsWithAnnotations()).type.declarations.values.first;
      
      expect(new GetValuesOfAnnotations<Annotation1>().fromDeclaration(methodMirror), [const Annotation1(), const Annotation1()]);
    });
  });
}