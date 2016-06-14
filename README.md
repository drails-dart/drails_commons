# Drails Commons

![Build Status](https://travis-ci.org/drails-dart/drails_commons.svg)

This library contains some utility methods to work with reflectable api.

## Get Annotation Values of classes:

If you want to get the value of certain annotation that is over the class of an object, you can use `GetValueOfAnnotation` class.
For example, lets say you have the class `Person` as fallows:

```dart
@myReflectable
@Table(name: 'person')
class Person {
    @Column(name: 'name', length: 50)
    String name;
}
```

then lets say you want to check if the annotation is over the class `Person`. In that case you could do:

```dart
var personClassMirror = myReflectable.reflectType(Person);
var isAnnotationOverPerson = new IsAnnotation<Table>().onClass(personClassMirror);
print(isAnnotationOverPerson); // should prints 'true'
```

Lets say in a different case you want to obtain the object containing all the attributes of `@Table`, then you can do:

```dart
var personClassMirror = myReflectable.reflectType(Person);
var annotationOverPerson = new GetAnnotation<Table>().fromClass(personClassMirror);
print(annotationOverPerson.name); // it should prints 'person'
```

## Get Annotation Values of Instances:

If you want to get the value of certain annotation that is over the class of an object, you can use `GetValueOfAnnotation` class.
For example, lets say you have the class `Person` as fallows:

```dart
@myReflectable
@Table(name: 'person')
class Person {
    @Column(name: 'name', length: 50)
    String name;
}
```

then lets say you want to check if the annotation is over an instance of class `Person`. In that case you could do:

```dart
var person = new Person();
var personInstanceMirror = myReflectable.reflect(person);
var isAnnotationOverPerson = new IsAnnotation<Table>().onInstance(personInstanceMirror);
print(isAnnotationOverPerson); // should prints 'true'
```

Lets say in a different case you want to obtain the object containing all the attributes of `@Table`, then you can do:

```dart
var person = new Person();
var personInstanceMirror = myReflectable.reflect(person);
var annotationOverPerson = new GetAnnotation<Table>().fromInstance(personClassMirror);
print(annotationOverPerson.name); // it should prints 'person'
```

## Get Annotation Values of classes:

If you want to get the value of certain annotation that is over the class of an object, you can use `GetValueOfAnnotation` class.
For example, lets say you have the class `Person` as fallows:

```dart
@myReflectable
@Table(name: 'person')
class Person {
    @Column(name: 'name', length: 50)
    String name;
}
```

then lets say you want to check if the annotation is over the attribute `name`. In that case you could do:

```dart
var nameDeclarationMirror = myReflectable.reflectType(Person).declarations[0];
var isAnnotationOverName = new IsAnnotation<Column>().onDeclaration(nameDeclarationMirror);
print(isAnnotationOverName); // should prints 'true'
```

Lets say you want to obtain the object containing all the attributes of `@Column`, then you can do:

```dart
var nameDeclarationMirror = myReflectable.reflectType(Person).declarations[0];
var annotationOverName = new GetAnnotation<Column>().fromDeclaration(nameDeclarationMirror);
print(annotationOverName.name); // it should prints 'person'
print(annotationOverPerson.length); // it should prints '20'
```

## Get Public Variables from an object

Let's say you want to get all the public attributes from a class, then you need to do:

```dart
var personCM = myReflectable.reflectType(Person);
var publicAttributes = getPublicVariablesFromClass(personCM, myReflectable);
```
