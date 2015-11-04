part of drails_commons;

///  Get Value of annotations of Type [T] on [InstanceMirror]s and [DeclarationMirror]s
class GetValueOfAnnotation<T> {
  /// This variable is useful to check if the annotation is on the declaration or class
  final _iat = new IsAnnotation<T>();
  ///  Get the Instance of the Annotation of type [T] from the reflected annotated object [im]
  T fromInstance(InstanceMirror im) => _fromAnnotations(im.type.metadata);

  ///  Get the Instance of the Annotation of type [T] from the reflected annotated declaration (method or property) [obj]
  T fromDeclaration(DeclarationMirror dm) => _fromAnnotations(dm.metadata);

//  T fromInvocation(InvocationMirror im) => _fromAnnotations(ams)

  /// Get the Instance of the Annotation of type [T] from the list of annotations' [InstanceMirror]s
  T _fromAnnotations(List<InstanceMirror> ams) {
    if (_iat.anyOf(ams))
      return ams.singleWhere(_iat._isType) as T;
    return null;
  }
}


///  Get list of Values of annotations of Type [T] on [InstanceMirror]s and [DeclarationMirror]s
class GetValuesOfAnnotations<T> {
 final _iat = new IsAnnotation<T>();
  ///  Get the list of values of the Annotation of type [T] from the reflected annotated object [im]
 Iterable<T> fromInstance(InstanceMirror im) => _fromAnnotations(im.type.metadata);

  ///  Get the list of values of the Annotation of type [T] from the reflected annotated declaration (method or property) [obj]
  Iterable<T> fromDeclaration(DeclarationMirror dm) => _fromAnnotations(dm.metadata);

  /// Get the list of values of the Annotation of type [T] from the list of annotations' [InstanceMirror]s
  Iterable<T> _fromAnnotations(List<InstanceMirror> ams) {
    if (_iat.anyOf(ams))
      return ams.where(_iat._isType).map((im) => im as T);
    return null;
  }
}

///  Check if Annotation is on [InstanceMirror] or [DeclarationMirror]
class IsAnnotation<T> {

  ///  Check if the Annotation of type [T] is on the reflected annotated object [im]
  bool onInstance(InstanceMirror im) => anyOf(im.type.metadata);

  ///  Check if the Annotation of type [T] is on the reflected annotated declaration (method or property) [dm]
  bool onDeclaration(DeclarationMirror dm) => anyOf(dm.metadata);

  ///  Check if any element of the list of annotations' InstanceMirrors mirros [am] is type [T]
  bool anyOf(List ams) {
    return ams.any(_isType);
  }

  ///  Checks if the annotation [InstanceMirror] is type [T]
  bool _isType(am) =>
    am is T;
}

///  Get Declarations (methods and variables) annotated with [T] and are type [DM]
class GetDeclarationsAnnotatedWith<T, DM> {
  ///  Get the iterable of [DeclarationMirror] that are annotated with [T]
  Iterable<DM> from(InstanceMirror im, Reflectable reflectable) =>
      getDeclarationsFromClassIf(im.type, reflectable, (dm) =>
        dm is DM && dm.metadata.any((am) => am is T))
      .values;


}

///  Get List of methods annotated with [T]
class GetMethodsAnnotatedWith<T> {
  ///  Get List of methods annotated with [T] from the InstanceMirror [im]
  Iterable<MethodMirror> from(InstanceMirror im, Reflectable r) => new GetDeclarationsAnnotatedWith<T, MethodMirror>().from(im, r);
}

///  Get List of variables annotated with [T]. for example:
///  
///     class ObjectWithAnnotatedAttr {
///     
///       @Annotation1()
///       @Annotation2()
///       var annotated1
///     
///       @Annotation1()
///       var annotated2
///     }
///     
///     main() {
///       var o = new ObjectWithAnnotatedAttr();
///       
///       //should return a list of [VariableMirror] of annotated1 and annotated2
///       var variablesAnnotatedWithAnnotation1 = new GetVariablesAnnotatedWith<Annotation1>().from(o);
///       
///       //should return a list of [VariableMirror] of annotated1
///       var variablesAnnotatedWithAnnotation2 = new GetVariablesAnnotatedWith<Annotation2>().from(o);
///     }
class GetVariablesAnnotatedWith<T> {
  ///  Get List of variables annotated with [T] from the InstanceMirror [im]. for example:
  ///
  ///     class ObjectWithAnnotatedAttr {
  ///     
  ///       @Annotation1()
  ///       @Annotation2()
  ///       var annotated1
  ///     
  ///       @Annotation1()
  ///       var annotated2
  ///     }
  ///     
  ///     main() {
  ///       var o = new ObjectWithAnnotatedAttr();
  ///       
  ///       //should return a list of [VariableMirror] of annotated1 and annotated2
  ///       var variablesAnnotatedWithAnnotation1 = new GetVariablesAnnotatedWith<Annotation1>().from(o);
  ///       
  ///       //should return a list of [VariableMirror] of annotated1
  ///       var variablesAnnotatedWithAnnotation2 = new GetVariablesAnnotatedWith<Annotation2>().from(o);
  ///     }
  Iterable<VariableMirror> from(InstanceMirror im, Reflectable reflectable) => new GetDeclarationsAnnotatedWith<T, VariableMirror>().from(im, reflectable);
}

typedef bool _IfDeclarationFunct(DeclarationMirror dm);

/// Get the List of [DeclarationMirror]s from [ClassMirror] cm if the [ifDeclarationFunct] is true
Map<String, dynamic> getDeclarationsFromClassIf(ClassMirror cm, Reflectable reflectable, _IfDeclarationFunct ifDeclarationFunct) {

  var dms = {};

  try {
    dms.addAll(getDeclarationsFromClassIf(cm.superclass, reflectable, ifDeclarationFunct));
  } catch(e) {
//    not sure what to do here
  } finally {
    cm.declarations.forEach((symbol, dm) {
      if(ifDeclarationFunct(dm)) {
        dms.putIfAbsent(symbol, () => dm);
      }
    });

    return dms;
  }
}

/// Get the list of public [MethodMirror] from [ClassMirror] [cm]
Map<String, MethodMirror> getPublicMethodsFromClass(ClassMirror cm, Reflectable reflectable) =>
    getDeclarationsFromClassIf(cm, reflectable, (dm) => !dm.isPrivate && dm is MethodMirror && (dm as MethodMirror).isRegularMethod);

/// Get the list of public variables and setters from [ClassMirror] [cm]
Map<String, DeclarationMirror> getPublicVariablesAndSettersFromClass(ClassMirror cm, Reflectable reflectable) =>
    getDeclarationsFromClassIf(cm, reflectable, (dm) => !dm.isPrivate && dm is VariableMirror || dm is MethodMirror && dm.isSetter);

/// Get the list of public variables and setters from [ClassMirror] [cm]
Map<String, DeclarationMirror> getPublicVariablesAndGettersFromClass(ClassMirror cm, Reflectable reflectable) =>
    getDeclarationsFromClassIf(cm, reflectable, (dm) =>
    !dm.isPrivate && dm is VariableMirror
        || dm is MethodMirror
          && dm.isGetter
          && dm.simpleName != 'runtimeType'
          && dm.simpleName != 'hashCode'
    );

/// Get the list of public variables [VariableMirror] from [ClassMirror] [cm]
Map<String, VariableMirror> getPublicVariablesFromClass(ClassMirror cm, Reflectable reflectable) =>
    getDeclarationsFromClassIf(cm, reflectable, (dm) => !dm.isPrivate && dm is VariableMirror);

/// Gets the object that extends the [injectableCm] from [declarationCms]
///
///
Object getObjectThatExtend(ClassMirror injectableCm, Iterable<DeclarationMirror> declarationCms) {
  ClassMirror result;
  int counter = 0, counter2 = 0;
  for(ClassMirror cm in declarationCms) {
    counter = _getExtensionLevel(injectableCm, cm, counter);
    if(counter > 0 && counter2 < counter) {
      result = cm;
      counter2 = counter;
      counter = 0;
    }
  }

  return result.newInstance('', []);
}

/**
 * Get the level value that a [declarationCm] extends the [injectableCm], for example:
 *
 * If we have next Abstract class:
 *
 *     abstract class SomeService {
 *       String someMethod();
 *     }
 *
 * The Extension level of the next service is 1
 *
 *     class SomeServiceImpl implements SomeService {
 *       String someMethod() => 'someMethod';
 *     }
 *
 * And the Extension level of the next service is 2
 *
 *     class SomeServiceImpl2 extens SomeServiceImpl {
 *       String someMethod() => super.someMethod() + '2';
 *     }
 */
int _getExtensionLevel(ClassMirror injectableCm, ClassMirror declarationCm, int counter) {

  if(declarationCm.simpleName == SN_OBJECT) {
    return counter = 0;
  }

  counter++;
  try {
    if(!(declarationCm.superinterfaces.any((icm) => icm == injectableCm) || declarationCm.superclass == injectableCm)) {
      counter = _getExtensionLevel(injectableCm, declarationCm.superclass, counter);
    }
  } catch(e) {
    return 0;
  }

  return counter;
}
