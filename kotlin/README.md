
# Kotlin Style Guide

This Kotlin style guide recommends best practices so that real-world Kotlin
programmers can write code that can be maintained by other real-world Kotlin
programmers. A style guide that reflects real-world usage gets used, while a
style guide that holds to an ideal that has been rejected by the people it is
supposed to help risks not getting used at all&mdash;no matter how good it is.


## Table of Contents

* [Source file names](#source-file-names)
* [Function names](#function-names)
* [Property names](#property-names)
* [Formatting](#formatting)
* [Horizontal whitespace](#horizontal-whitespace)
* [Colon](#colon)
* [Class header](#class-header-formatting)
* [Annotation](#annotation-formatting)
* [Functions](#function-formatting)
* [Expression body](#expression-body-formatting)
* [Properties](#property-formatting)
* [Control flow statements](#formatting-control-flow-statements)
* [Method calls](#method-call-formatting)
* [Lambdas](#lambda-formatting)
* [Documentation/comments](#documentation-comments)
* [Type aliases](#type-aliases)
* [Conditional statements](#using-conditional-statements)
  * [if versus when](#if-versus-when)
* [Extension functions](#using-extension-functions)
* [Scope functions](#Using-scope-functions-apply/with/run/also/let)
  * [run](#run)
  * [let](#let)
  * [apply](#apply)
  * [also](#also)
  * [with](#with)
  * [Combining scope functions](#combining-scope-functions)

---------------------

### Source file names:
If a Kotlin file contains a single class (potentially with related top-level 
declarations), its name should be the same as the name of the class, with the 
.kt extension appended. If a file contains multiple classes or only top-level
declarations, choose a name describing what the file contains, and name the 
file accordingly. Use the camel case with an uppercase first letter (for example,
ProcessDeclarations.kt )

### Function names:
Names of functions, properties, and local variables start with a lower case letter 
and use the camel case and no underscores: 

```
fun processDeclarations() { /*...*/ } 
var declarationCount = 1 
```

Exception: factory functions used to create instances of classes can have the 
same name as the class being created: 

```
abstract class Foo { /*...*/ } 
class FooImpl : Foo { /*...*/ } 
fun FooImpl(): Foo { return FooImpl() } 
```

In tests (and only in tests), it's acceptable to use method names with spaces 
enclosed in backticks.(Note that such method names are currently not supported
by the Android runtime.) Underscores in method names are also allowed in test
code.

```
class MyTestCase { 
    @Test fun `ensure everything works`() { /*...*/ } 
    @Test fun ensureEverythingWorks_onAndroid() { /*...*/ }
}
```

### Property names:
Names of constants (properties marked with const, or top-level or object val 
properties with no custom get the function that holds deeply immutable data) 
should use uppercase underscore separated names: 

```
const val MAX_COUNT = 8 
val USER_NAME_FIELD = "UserName" 
```

Names of top-level or object properties which hold objects with behavior or 
mutable data should use camel-case names: 

```
val mutableCollection: MutableSet = HashSet() 
```

Names of properties holding references to singleton objects can use the same 
naming style as object declarations: 

```
val PersonComparator: Comparator = /*...*/ 
```

For enum constants, it's OK to use either uppercase underscore-separated names
( enum class Color { RED, GREEN } ) or regular camel-case names starting with 
an uppercase first letter, depending on the usage.

### Formatting:
Use 4 spaces for indentation. Do not use tabs. For curly braces, put the opening 
brace in the end of the line where the construct begins, and the closing brace on
a separate line aligned horizontally with the opening construct.

```
if (elements != null) { 
    for (element in elements) {
     // ... 
    } 
}
```

### Horizontal whitespace:
Put spaces around binary operators ( a + b ). 
Exception: don't put spaces around the "range to" operator ( 0..i ). 
Do not put spaces around unary operators ( a++ ) 
Put spaces between control Oow keywords ( if , when , for and while ) and the 
corresponding opening parenthesis. Do not put a space before an opening parenthesis
in a primary constructor declaration, method declaration or method call. 

```
class A(val x: Int) 
fun foo(x: Int) { ... } 
fun bar() { foo(1) } 
```

Never put a space after ( , [ , or before ] , ) . 
Never put a space around . or ?. : foo.bar().filter { it > 2 }.joinToString() , foo?.bar()
Put a space after // : // This is a comment
Do not put spaces around angle brackets used to specify type parameters: class Map { ... }
Do not put spaces around :: : Foo::class , String::length 
Do not put a space before ? used to mark a nullable type: String? 

### Colon
Put a space before : in the following cases: 
when it's used to separate a type and a supertype; 
when delegating to a superclass constructor or a different constructor of the 
same class;
after the object keyword. 

Don't put a space before  :  when it separates a declaration and its type. 
Always put a space after : . 

```
abstract class Foo : IFoo { 
    abstract fun foo(a: Int): T 
} 

class FooImpl : Foo() { 
    constructor(x: String) : this(x) { /*...*/ } 

    val x = object : IFoo { /*...*/ } 
}
```

### Class header formatting:
Classes with a few primary constructor parameters can be written in a single line:

```
class Person(id: Int, name: String)
```

Classes with longer headers should be formatted so that each primary constructor 
parameter is in a separate line with indentation. Also, the closing parenthesis 
should be on a new line. If we use inheritance, then the superclass constructor 
call or list of implemented interfaces should be located on the same line as the 
parenthesis:

```
class Person( 
    id: Int, 
    name: String, 
    surname: String
) : Human(id, name) { /*...*/ }
```

For multiple interfaces, the superclass constructor call should be located first and 
then each interface should be located in a different line:

```
class Person( 
    id: Int, 
    name: String, 
    surname: String 
) : Human(id, name), 
    KotlinMaker { /*...*/ }
```

For classes with a long supertype list, put a line break after the colon and align all
supertype names horizontally:

```
class MyFavouriteVeryLongClassHolder :
    MyLongHolder(), 
    SomeOtherInterface, 
    AndAnotherOne {
    
    fun foo() { /*...*/ } 
}
```

To clearly separate the class header and body when the class header is long, either put
a blank line following the class header (as in the example above), or put the opening 
curly brace on a separate line:

```
class MyFavouriteVeryLongClassHolder : 
    MyLongHolder(), 
    SomeOtherInterface, 
    AndAnotherOne 
{ 
    fun foo() { /*...*/ } 
}
```

Use regular indent (4 spaces) for constructor parameters.

### Annotation formatting:
Annotations are typically placed on separate lines, before the declaration to which they 
are attached, and with the same indentation:

```
@Target(AnnotationTarget.PROPERTY) 
annotation class JsonExclude
```

Annotations without arguments may be placed on the same line:

```
@JsonExclude @JvmField 
var x: String
```

A single annotation without arguments may be placed on the same line as the 
corresponding declaration:

```
@Test fun foo() { /*...*/ }
```

### Function formatting:
If the function signature doesn't fit on a single line, use the following syntax:

```
fun longMethodName( 
    argument: ArgumentType = defaultValue, 
    argument2: AnotherArgumentType 
): ReturnType { 
    // body 
}
```

Use regular indent (4 spaces) for function parameters.

Prefer using an expression body for functions with the body consisting of a single 
expression.

```
// bad 
fun foo(): Int { 
    return 1 
} 

// good
fun foo() = 1
```

### Expression body formatting:
If the function has an expression body that doesn't fit in the same line as the 
declaration, put the = sign on the first line. Indent the expression body by 4 
spaces.

```
fun f(x: String) = 
    x.length
```

### Property formatting:
For very simple read-only properties, consider one-line formatting: 

```
val isEmpty: Boolean get() = size == 0
```

For more complex properties, always put get and set keywords on separate lines:

```
val foo: String 
get() { /*...*/ }
```

For properties with an initializer, if the initializer is long, add a line break 
after the equals sign and indent the initializer by four spaces:

```
private val defaultCharset: Charset? = 
    EncodingRegistry.getInstance().getDefaultCharsetForPropertiesFiles(file)
```

### Formatting control flow statements:
If the condition of an if or when the statement is multiline, always use curly 
braces around the body of the statement. Indent each subsequent line of the 
condition by 4 spaces relative to statement begin. Put the closing parentheses 
of the condition together with the opening curly brace on a separate line:

```
if (!component.isSyncing && 
    !hasAnyKotlinRuntimeInScope(module) 
) { 
    return createKotlinNotConfiguredPanel(module) 
}
```

Put the else , catch , finally keywords, as well as the while keyword of a do/while 
loop, on the same line as the preceding curly brace:

```
if (condition) {
    // body 
} else {
    // else part 
} 


try { 
    // body 
} finally { 
    // cleanup 
}
```

In a when statement, if a branch is more than a single line, consider separating it
from adjacent case blocks with a blank line:

```
private fun parsePropertyValue(propName: String, token: Token) {
	  when (token) {
		    is Token.ValueToken ->
			  callback.visitValue(propName, token.value)
		
		    Token.LBRACE -> { // …
        }
    }
}
```

Put short branches on the same line as the condition, without braces.

```
when (foo) {
    true -> bar() // good 
    false -> { baz() } // bad 
}
```

### Method call formatting:
In long argument lists, put a line break after the opening parenthesis. Indent 
arguments by 4 spaces. Group multiple closely related arguments on the same line.

```
drawSquare( 
    x = 10, y = 10, 
    width = 100, height = 100, 
    fill = true )
```

Put spaces around the = sign separating the argument name and value.

### Lambda formatting:
In lambda expressions, spaces should be used around the curly braces, as well as 
around the arrow which separates the parameters from the body. 
If a call takes a single lambda, it should be passed outside of parentheses whenever
possible.

```
list.filter { it > 10 }
```

If assigning a label for a lambda, do not put a space between the label and the opening
 curly brace:

```
fun foo() { 
    ints.forEach list@{ 
        // ... 
    } 
}
```

When declaring parameter names in a multiline lambda, put the names on the first line, 
followed by the arrow and the newline:

```
appendCommaSeparated(properties) { 
    prop -> val propertyValue = prop.get(obj)  // ... 
}
```

If the parameter list is too long to Dt on a line, put the arrow on a separate line:

```
foo { 
    context: Context, 
    environment: Env 
    -> 
    context.configureEnv(environment) 
}
```

### Documentation comments:
For longer documentation comments, place the opening /** on a separate line and begin 
each subsequent line with an asterisk:

```
/** 
* This is a documentation comment 
* on multiple lines. 
*/
```

Short comments can be placed on a single line:

```
/** This is a short documentation comment. */
```

String templates:
Don't use curly braces when inserting a simple variable into a string template. 
Use curly braces only for longer expressions. 

```
println("$name has ${children.size} children")
```

### Type aliases:
If you have a functional type or a type with type parameters which is used multiple times 
in a codebase, prefer deDning a type alias for it: 

```
typealias PersonIndex = Map<String, Person>
```

### Using conditional statements:
Prefer using the expression form of try, if and when. Examples:

```
return if (x) foo() else bar()

return when(x) { 
    0 -> "zero" 
    else -> "nonzero" 
}
```

The above is preferable to:

```
if (x) 
    return foo()
else 
    return bar() 

when(x) { 
    0 -> return "zero" 
    else -> return "nonzero" 
}
```

#### if versus when
Prefer using if for binary conditions instead of when . Instead of

```
when (x) { 
    y -> // ... 
    else -> // ... 
}
```

use

```
if (x == y) ... else …
```

Prefer using when if there are three or more options.

Loops on ranges:
Use the until function to loop over an open range:

```
for (i in 0..n - 1) { /*...*/ } // bad 
for (i in 0 until n) { /*...*/ } // good
```

### Using extension functions:
Use extension functions liberally. Every time you have a function that works primarily 
on an object, consider making it an extension function accepting that object as a receiver.
To minimize API pollution, restrict the visibility of extension functions as much as it 
makes sense. As necessary, use local extension functions, member extension functions, 
or top-level extension functions with private visibility.

### Using scope functions apply/with/run/also/let:
Kotlin provides a variety of functions to execute a block of code in the context of a 
given object: let, run, with, apply, and also. You should be used the scope functions 
depending on your needs, there is not a specific rule for each one, they are used in 
order to have a clean and easy to maintain code, and since Kotlin is a compiled language
with the use of those functions you can get better performance of your apps.

#### run
Receive 'this' as an instance of the current context and return a final value, should be 
used to execute actions over the same context.

```
val dog = Dog()
val result = dog.run { //this as instance of the object dog
	  jump() // same as dog.jump() also you can use this.jump()
	  sit()
 	  eat()
	  sleep() // the final return value
}
```

Without "run" the code looks like:

```
dog.jump()
dog.sit()
dog.eat()
val resutl = dog.sleep()
```

#### let
Receive 'it' as an instance of the current object and return a final value, should be 
used to use the object context several times.

```
dog.let { 
 	  renameDog(it, "Canelo")
    paintDog(it, red)
}
```

#### apply
Receive 'this' as an instance fo the current context, return the object context, should
be used to change context data:

```
dog.apply {
    name = "Canelo"
    color = "Red"
    size = "Big"	
}
```

#### also
Receive 'it' as an instance of the object, return the same context as result, should be 
used to execute a code after a creation of the object or parameters assignations:

val dog = Dog().also {
	selectedDog = it 
}

Also, you can combine with 'apply':

```
dog.apply {
    name = "Canelo"
    color = "Red"
    size = "Big"	
}.also {
    selectedDog = it
}
```

#### with
Similar to let, but using 'this' as context, should be used if you know the object is 
not null for example:

```
val dog = Dog()
with(dog) {
    renameDog(this, "Canelo")
    eat() 
}
```

But if you need to check the object nullability you should be used 'let' as instance of with:

```
dog?.let {
    ...
}
```

#### Combining scope functions
Imagine you have two objects and you need to use a scope function inside another, you 
need to specify the name of the context to avoid context overlapping.

```
dog1.let { // it as instance of dog1
 	  dog2.let { d2 -> // you have to rename the context for dog2
        it.isBrotherOf(d2) //it stell an instance of dog1
        doSomething(arrayListOf(it,d2))
    }
    // d2 doesn't exist in this context
    it.jump()
}
```
