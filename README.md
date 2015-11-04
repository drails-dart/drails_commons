# Drails Commons

![Build Status](https://travis-ci.org/drails-dart/drails_commons.svg)

This library maintains common functions and variables useful for drails_di, dson and drails.

Examples:

```Dart
//Get the value of the annotation of type Annotation1 that is over the class of instanceMirro1
var annotationValueOverClass = new GetValueOfAnnotation<Annotation1>().fromInstance(instanceMirro1);

//Get the value of the annotation of type Annotation1 that is over the class of declarationMirror1
var annotationValueOverDeclaration = new GetValueOfAnnotation<Annotation1>().fromDeclaration(declarationMirror1);

//Get the list of values of the annotation of type Annotation1 that is over the class of instanceMirro1
var annotationValuesOverInstance = new GetValuesOfAnnotations<Annotation1>().fromInstance(instanceMirro1);

//Get the value of the annotation of type Annotation1 that is over the class of declarationMirror1
var annotationValuesOverDeclaration = new GetValuesOfAnnotations<Annotation1>().fromDeclaration(declarationMirror1);
```
