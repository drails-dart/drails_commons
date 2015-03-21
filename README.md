# Drails Commons

This library mantains common functions and variables usful for drails_di, dson and drails.

Examples:

```Dart
//Get the value of the annotation of type Annotation1 that is over the class of instanceMirro1
var annotationValue = GetValueOfAnnotation<Annotation1>().fromInstance(instanceMirro1);

//Get the value of the annotation of type Annotation1 that is over the class of declarationMirror1
var annotationValue = GetValueOfAnnotation<Annotation1>().fromDeclaration(declarationMirror1);

//Get the list of values of the annotation of type Annotation1 that is over the class of instanceMirro1
var annotationValue = GetValuesOfAnnotations<Annotation1>().fromInstance(instanceMirro1);

//Get the value of the annotation of type Annotation1 that is over the class of declarationMirror1
var annotationValue = GetValuesOfAnnotations<Annotation1>().fromDeclaration(declarationMirror1);
```