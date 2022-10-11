# Flutter Style Guide

This Flutter style guide recommends best practices so that real-world Flutter
programmers can write code that can be maintained by other real-world Flutter
programmers. A style guide that reflects real-world usage gets used, while a
style guide that holds to an ideal that has been rejected by the people it is
supposed to help risks not getting used at all&mdash;no matter how good it is.

## Table of Contents

* [Identifiers](#identifiers)
* [Formatting](#formatting)
* [Performance](#performance)
* [Tests](#tests)

### Identifiers
Identifiers come in three flavors in Dart.
UpperCamelCase names capitalize the first letter of each word, including the first.
lowerCamelCase names capitalize the first letter of each word, except the first which is always lowercase, even if it’s an acronym.
lowercase_with_underscores names use only lowercase letters, even for acronyms, and separate words with _.

- DO name types using UpperCamelCase.
Linter rule: camel_case_types
Classes, enum types, typedefs, and type parameters should capitalize the first letter of each word (including the first word), and use no separators.
```
class SliderMenu { ... }
class HttpRequest { ... }
typedef Predicate<T> = bool Function(T value);
```

This even includes classes intended to be used in metadata annotations.
```
class Foo {
  const Foo([Object? arg]);
}

@Foo(anArg)
class A { ... }

@Foo()
class B { ... }
```

If the annotation class’s constructor takes no parameters, you might want to create a separate lowerCamelCase constant for it.
```
const foo = Foo();
@foo
class C { ... }
```

- DO name extensions using UpperCamelCase.
Linter rule: camel_case_extensions
Like types, extensions should capitalize the first letter of each word (including the first word), and use no separators.
```
extension MyFancyList<T> on List<T> { ... }
extension SmartIterable<T> on Iterable<T> { ... }
```

- DO name import prefixes using lowercase_with_underscores.
Linter rule: library_prefixes
Good: 
```
import 'dart:math' as math;
import 'package:angular_components/angular_components.dart' as angular_components;
import 'package:js/js.dart' as js;
```

Bad:
```
import 'dart:math' as Math;
import 'package:angular_components/angular_components.dart' as angularComponents;
import 'package:js/js.dart' as JS;
```
 
- DO name other identifiers using lowerCamelCase.
Linter rule: non_constant_identifier_namesClass members, top-level definitions, variables, parameters, and named parameters should capitalize the first letter of each word except the first word, and use no separators.
```
var count = 3;
HttpRequest httpRequest;
void align(bool clearItems) {
  // ...
}
```
 
- PREFER using lowerCamelCase for constant names.
Linter rule: constant_identifier_names
In new code, use lowerCamelCase for constant variables, including enum values.
```
const pi = 3.14;
const defaultTimeout = 1000;
final urlScheme = RegExp('^([a-z]+):');
class Dice {
  static final numberGenerator = Random();
}
```

- DO capitalize acronyms and abbreviations longer than two letters like words.
Capitalized acronyms can be hard to read, and multiple adjacent acronyms can lead to ambiguous names. For example, given a name that starts with HTTPSFTP, there’s no way to tell if it’s referring to HTTPS FTP or HTTP SFTP.
To avoid this, acronyms and abbreviations are capitalized like regular words.

```
class HttpConnection {}
class DBIOPort {}
class TVVcr {}
class MrRogers {}
var httpRequest = ...
var uiHandler = ...
var userId = ...
Id id;
```
 
- PREFER using _, __, etc. for unused callback parameters.
Sometimes the type signature of a callback function requires a parameter, but the callback implementation doesn’t use the parameter. In this case, it’s idiomatic to name the unused parameter _. If the function has multiple unused parameters, use additional underscores to avoid name collisions: __, ___, etc.

```
futureOfVoid.then((_) {
    //...
});
```

- DON’T use prefix letters.
Hungarian notation and other schemes arose in the time of BCPL, when the compiler didn’t do much to help you understand your code. Because Dart can tell you the type, scope, mutability, and other properties of your declarations, there’s no reason to encode those properties in identifier names.
```
Good: defaultTimeout
Bad: kDefaultTimeout
```

### Formatting
Like many languages, Dart ignores whitespace. However, humans don’t. Having a consistent whitespace style helps ensure that human readers see code the same way the compiler does.

- AVOID lines longer than 80 characters:
Linter rule: lines_longer_than_80_chars
Readability studies show that long lines of text are harder to read because your eye has to travel farther when moving to the beginning of the next line. This is why newspapers and magazines use multiple columns of text.

If you really find yourself wanting lines longer than 80 characters, our experience is that your code is likely too verbose and could be a little more compact. The main offender is usually VeryLongCamelCaseClassNames. Ask yourself, “Does each word in that type name tell me something critical or prevent a name collision?” If not, consider omitting it.

Note that dart format does 99% of this for you, but the last 1% is you. It does not split long string literals to fit in 80 columns, so you have to do that manually.

Exception: When a URI or file path occurs in a comment or string (usually in an import or export), it may remain whole even if it causes the line to go over 80 characters. This makes it easier to search source files for a path.

Exception: Multi-line strings can contain lines longer than 80 characters because newlines are significant inside the string and splitting the lines into shorter ones can alter the program.

- DO use curly braces for all flow control statements:
Linter rule: curly_braces_in_flow_control_structures
Doing so avoids the dangling else problem.
```
if (isWeekDay) {
  print('Bike to work!');
} else {
  print('Go dancing or read a book!');
}
```

Exception: When you have an if statement with no else clause and the whole if statement fits on one line, you can omit the braces if you prefer:

```
if (arg == null) return defaultValue;
```

If the body wraps to the next line, though, use braces:

```
if (overflowChars != other.overflowChars) {
  return overflowChars < other.overflowChars;
}
```

Use raw string
A raw string can be used to not come across escaping only backslashes and dollars.
```
//Do
var s = r'This is demo string \ and $';

//Do not
var s = 'This is demo string \\ and \$';
```

- Use ternary operator for single-line cases.
```
String welcomeMessage = !isNewUser ? 'Welcome!' : 'Please sign up!';
```

- Always highlight the type of member when its value type is known. Do not use var when it is not required. As var is a dynamic type takes more space and time to resolve.
```
//Do
int item = 10;
final Car bar = Car();
String name = 'john';
const int timeOut = 20;

//Do not
var item = 10;
final car = Car();
const timeOut = 2000;
```

### Performance
* Minimize expensive operations:
Some operations are more expensive than others, meaning that they consume more resources. Obviously, you want to only use these operations when necessary. How you design and implement your app’s UI can have a big impact on how efficiently it runs.

Here are some things to keep in mind when designing your UI:
- Avoid repetitive and costly work in build() methods since build() can be invoked frequently when ancestor widgets rebuild.
- Avoid overly large single widgets with a large build() function. Split them into different widgets based on encapsulation but also on how they change.
- When setState() is called on a State object, all descendent widgets rebuild. Therefore, localize the setState() call to the part of the subtree whose UI actually needs to change. Avoid calling setState() high up in the tree if the change is contained to a small part of the tree.
- The traversal to rebuild all descendents stops when the same instance of the child widget as the previous frame is re-encountered. This technique is heavily used inside the framework for optimizing animations where the animation doesn’t affect the child subtree. See the TransitionBuilder pattern and the source code for SlideTransition, which uses this principle to avoid rebuilding its descendents when animating.
- Always try to use const widgets. The widget will not change when setState call we should define it as constant. It will impede the widget from being rebuilt so it revamps performance.
- To create reusable pieces of UIs, prefer using a StatelessWidget rather than a function.
- Use MediaQuery/LayoutBuilder only when needed.
- Use streams only when needed

* Using SizedBox instead of Container in Flutter:
There are multiple use cases where you will require to use a placeholder. Here is the ideal example below:
```
return _isNotLoaded ? Container() : YourAppropriateWidget();
```

The main issue here is that Container doesn't have a const constructor and load a lot of business logic on it, on the other hand SizedBox is a const constructor and builds a fixed-size box. The width and height parameters can be null to specify that the size of the box should not be constrained in the corresponding dimension.

Thus, when we have to implement the placeholder, SizedBox should be used rather than using a container.
```
return _isNotLoaded ? SizedBox() : YourAppropriateWidget();
```

* Minimize use of opacity and clipping
Opacity is another expensive operation, as is clipping. Here are some tips you might find to be useful:
- Use the Opacity widget only when necessary. See the Transparent image section in the Opacity API page for an example of applying opacity directly to an image, which is faster than using the Opacity widget.
- Instead of wrapping simple shapes or text in an Opacity widget, it’s usually faster to just draw them with a semitransparent color. (Though this only works if there are no overlapping bits in the to-be-drawn shape.)
- To implement fading in an image, consider using the FadeInImage widget, which applies a gradual opacity using the GPU’s fragment shader.
- Clipping doesn’t call saveLayer() (unless explicitly requested with Clip.antiAliasWithSaveLayer), so these operations aren’t as expensive as Opacity, but clipping is still costly, so use with caution. By default, clipping is disabled (Clip.none), so you must explicitly enable it when needed.
- To create a rectangle with rounded corners, instead of applying a clipping rectangle, consider using the borderRadius property offered by many of the widget classes.


* Implement grids and lists thoughtfully:
How your grids and lists are implemented might be causing performance problems for your app. This section describes an important best practice when creating grids and lists, and how to determine whether your app uses excessive layout passes.
When building a large grid or list, use the lazy builder methods, with callbacks. That ensures that only the visible portion of the screen is built at startup time.

* Select libraries carefully:
- Before using a third-party library take into account:
Do you relly needed it? It makes more sense to write the code or copy the code than depend on a library.
- When was the package updated? We should always avoid using stale packages.
- How popular is the package? If the package has considerable popularity, it is much easier to find community support.
- How frequently does the package get updated? This is really important if we want to take advantage of the latest Dart features.

### Tests
Write tests for critical functionality

The contingencies of relying on manual testing will always be there, having an automated set of tests can help you save a notable amount of time and effort. As Flutter mainly targets multiple platforms, testing each and every functionality after every change would be time-consuming and call for a lot of repeated effort.

Let’s face the facts, having 100% code coverage for testing will always be the best option, however, it might not always be possible on the basis of available time and budget. Nonetheless, it’s still essential to have at least tests to cover the critical functionality of the app.

Unit and widget tests are the topmost options to go with from the very beginning and it’s not at all tedious as compared to integration tests.

- Unit test
  - For all code beside the UI Widgets.
  - One set of unit tests usually tests a single class.
- Widget test
  - For testing a single widget
- Integration test
  - For testing large parts of the app from the user perspective

|   | Unit  | Widget  | Integration  |
| ------------ | ------------ | ------------ | ------------ |
| Confidence | Low  | Higher | Highest  |
| Maintenance cost | Low | Higher | Highest |
| Dependencies | Few | More | Most |
| Excecution speed | Quick  |  Quick |  Slow |

Official documentation
https://docs.flutter.dev/cookbook/testing/unit/introduction

Demo project
https://github.com/huanachin/flutter_unit_test
