# lava
Lava is an easy to use OOP library for Lua 5.1/5.2/5.3 and LuaJIT

### Note: Lava is currently experimental software

To use Lava in your project, just `require "lava"`.
For examples, read the example scripts in `examples/`

The lava module will return a table of function exports for you to use:
* abstract( string name )
* singleton( string name )
* class( string name )
* interface( string name )
* mixin( string name )
* is_a( instance, definition )
* implements( instance, interface )
* validClass( instance )
* loadClass( string filePath )

## Basic Overview
Classes in lava come in 5 flavors - `class`, `abstract`, `singleton`, `interface` and `mixin`.
Lava supports abstract classes, interfaces, mixins, singletons and single inheritance.

#### class
`class` is the primary object type. Classes can be instantiated with the `:New()` syntax,
inherit from base classes using the `extends "Base" : from "namespace"` syntax,
implement interfaces using the `implements "Interface" : from "namespace"` syntax and
can have mixins applied using the `mixin "Mixin" : from "namespace"` syntax.
`class` objects require that a constructor method be defined somewhere along the parent-child hierarchy. Constructors are defined by creating a function inside the class named `Initialize`.

#### singleton
`singleton` behaves just like `class` with the exception being only 1 instance of a singleton can ever exist at the same time.
Subsequent calls to `:New()` will return the same instance.

#### abstract
`abstract` objects, like `class` and `singleton` can implement interfaces and apply mixins, but cannot be instantiated. `abstract` exists purely to be extended on by child objects.

#### interface
`interface` objects are nothing more than a collection of methods and, optionally, member variables.
Methods from interfaces are not inherited by classes that implement them per-se, rather a class that implements an interface is required to at least define the same set of methods as they appear in the interface.
Failing to define a method in a class that is mentioned in an `implemented` interface will result in an error.
Parent/base classes can implement interfaces, be aware however that implementing the same interface in a parent and child class will result in an error.

#### mixin
`mixin` objects are simple collections of methods and member variables which can be "mixed in" to other objects.
If a mixin is applied twice, say for example once in a base class and then again in a child class, an error will be thrown.
If method or member variable names from a mixin conflict with other method/member names found in the class, that too will throw an error.

`interface` and `mixin` types cannot utilize inheritance via `extends`, nor can they implement interfaces or utilize mixins.

## Writing and loading lava classes
All lava class types must follow the 1 class per-file rule - lava modifies the metatable of the main scope of the defining classes environment (to enable 'magic' methods and variables mentioned further down, amongst other things).
Lava will enforce this rule for you, throwing an error if you attempt to create more than 1 class definition in a file.

When you've written a lava class file, you can load it using the exported `loadClass( string filePath )` method.
If the Lua environment you are using does not support `loadfile`/`dofile` then you will have to modify the `loadClass` method or create your own inside the lava module.

## 'Magic' variables and class definition scope
When defining a class in lava, global functions are redirected to the class definition and a number of variables visible only inside the class definition are made available. These are:
* this
* super
* shared
* super_shared

Additionally, the following methods become available:
* accessor
* getter
* setter
* shared_block

Let's run through each of these and describe what they do.

#### this
`this` refers to the definition object of the class itself.
`this` can be used to store custom data on the class definition or to access the `members` and `methods` tables for manually inserting data.

#### super
`super` refers to the method table of the parent class, if one exists. `super` is used primarily to call overloaded functions from child classes.

#### shared
`shared` refers to the shared table defined by the method `shared_block`. Shared blocks are used to store data which is shared amongst all instances of a class.

#### super_shared
`super_shared` refers to the shared table of the parent class, if one exists. Parent/base classes can define shared blocks and they can be accessed by child classes via `super_shared`

#### shared_block
`shared_block` is a function used to define the existence and initial layout of a shared block in a class.
Shared blocks are populated with this initial table when the first instance of a class is created and are cleared when the last instance is garbage collected.

#### getter
`getter` is a function which generates Get() functions on the class. To use getter, pass in a single string as follows:
```lua
getter "MethodName->memberVariable"
```
`MethodName` will become `GetMethodName()` and will return `instance.memberVariable` when called.

#### setter
`setter`, much like `getter`, generates Set() functions on the class. To use setter, pass in a single string as follows:
```lua
setter "MethodName->memberVariable"
```
`MethodName` will become `SetMethodName( value )` and will set `instance.memberVariable` to `value` when called.

#### accessor
`accessor` is a combination of `getter` and `setter`, creating both a Get() and Set() method.

## Working with class instances
Let's define and create an instance of a simple class.

First, we load lava and place some methods in the global scope:
```lua
lava = require "lava"

-- Placing these methods in _G is optional
abstract = lava.abstract
singleton = lava.singleton
class = lava.class
interface = lava.interface
mixin = lava.mixin
is_a = lava.is_a
validClass = lava.validClass
```

Next we create a new file and write our class definition:
```lua
do class "Example" : namespace "examples"
  {
    memberVariable = "",
  }
  
  accessor "Message->memberVariable"
  
  function Initialize( self, messageString )
    self.memberVariable = messageString
  end
end
```

We can load and create an instance and manipulate the class like so:
```lua
lava.loadClass( "MyClass.lua" )
local myInstance = examples.Example:New( "Hello World!" )
print( myInstance:GetMessage() ) -- prints "Hello World!"

myInstance:SetMessage( "1234" )
print( myInstance:GetMessage() ) -- prints "1234"
```

If we want to grab all active instances of a class, we can do so:
```lua
for _, instance in pairs( examples.Example:GetInstances() ) do
  print( instance:GetMessage() )
end
```

Instances will be automatically removed when garbage collected, however you can explicitly remove them:
```lua
myInstance:Remove() -- Will remove this class from the instance list and invoke examples.Example:OnRemove(), if defined
```
**NOTE:** If you manually :Remove() a class, the instance variable will still be reachable!
You should set all references to your instance to `nil` after calling :Remove() or undefined behavior could result.

When garbage collected, classes that define a `__GC()` method will have that method invoked.
```lua
do class "Example" : namespace "examples"
  {
    memberVariable = "",
  }
  
  accessor "Message->memberVariable"
  
  function Initialize( self, messageString )
    self.memberVariable = messageString
  end

  function __GC( self )
    print "Goodbye, cruel world!"
  end
end
```
**NOTE:** For Lua 5.1 and LuaJIT, the __GC method is achieved by proxying your instance through zero-sized userdata via `newporxy`.
Thus, class instances in 5.1 and JIT are actually `userdata` and not `table`

## Namespaces
In lava, you can specify a namespace for your class/interface/mixin by using the `namespace` method as so:
```lua
do class "Example" : namespace "examples"
```

`namespace` supports nested tables too!
```lua
do class "Example" : namespace "examples.basic.myStuff"
```

If you are extending a class that is in a different namespace from your child class, you can use `from` to specify where to find the parent class
```lua
do class "ChildExample" : namespace "examples" : extends "ParentExample" : from "examples.parents"
```

If namespaces are the same, you can omit `from` and lava will assume it can be found in the same namespace.
If none of your classes specify a namespace, your classes will be placed in `_G`.

## Interfaces
Interfaces in lava are simple prototype classes, implementing no other interfaces, using mixins or extending from other classes.
A simple interface looks like this:
```lua
do interface "Printable" : namespace "interfaces"
  {}

  function Print( self )end
end
```

And an example using this interface in a class:
```lua
do class "Example" : namespace "examples"
  : implements "Printable" : from "interfaces"
  {
    m_strMessage = "Hello World!",
  }

  function Initialize( self )
  end

  function Print( self )
    print( self.m_strMessage )
  end
end
```

If we forget to define the function `Print` inside our class, lava will throw an error.
We can query if a class implements an interface like so:
```lua
if lava.implements( instance, interfaces.Printable ) then
  instance:Print()
end
```

## Mixins
Mixins are basic classes containing methods and variables that may not contain other mixins, implement interfaces or extend from other classes.
Here is a basic mixin example:
```lua
do mixin "Position" : namespace "mixins"
  {
    x = 0,
    y = 0,
  }

  accessor "X->x"
  accessor "Y->y"

  function SetPos( self, x, y )
    self.x = x
    self.y = y
  end

  function GetPos( self )
    return self.x, self.y
  end
end
```

We can use the above mixin like so:
```lua
do class "Person" : namespace "examples"
  : mixin "Position" : from "mixins"
  {
    name = "",
  }

  function Initialize( self, name )
    self.name = name
  end
end
```

```lua
local bob = examples.Person:New( "Bob" )
bob:SetPos( 1, 2 )
print( bob:GetPos() )
bob:SetX( 3 )
print( bob:GetPos() )
```

## Inheritance
For another example, we will extend a class and overload one of it's methods
```lua
do abstract "Base" : namespace "examples.bases"
  {
    message = "",
  }

  function SetMessage( self, message )
    self.message = message
  end
end
```
```lua
do class "Child" : namespace "examples" : extends "Base" : from "examples.bases"
  {}

  function Initialize( self, message )
    self.message = message
  end

  function SetMessage( self, message )
    super.SetMessage( self, message )
    print( message )
  end
end
```
Now, calling `SetMessage` on our child instance both sets the message variable and prints the message.

If you wish to prevent people from extending your classes, you can mark a class as `final`:
```lua
do class "Example" : namespace "examples" : final()
  {}
  
  function Initialize( self )
  end
end
```

## Shared blocks
Shared blocks can be a useful tool in certain situations. Let's look at how to use them.
```lua
do class "Example" : namespace "examples"
  {
    myMessage = "",
  }

  shared_block {
    ourMessage = "",
  }

  accessor "MyMessage->myMessage"

  function Initialize( self, message )
    self.myMessage = message
  end

  function SetOurMessage( self, message )
    shared.ourMessage = message
  end

  function GetOurMessage( self, message )
    return shared.ourMessage
  end
end
```

```lua
local a = examples.Example:New( "Hello" )
local b = examples.Example:New( "World" )

a:SetOurMessage( "Hey There!" )
print( b:GetOurMessage() ) -- prints "Hey There!"
```

Shared blocks can be shared from parent to child via `super_shared`. Let's extend our example and try it out:
```lua
do class "ChildA" : namespace "examples" : extends "Example"
  {}

  shared_block {
    ourMessage = "",
  }

  function SetOurMessage( self, message )
    shared.ourMessage = message
  end

  function GetOurMessage( self, message )
    return shared.ourMessage
  end

  function SetParentMessage( self, message )
    super_shared.ourMessage = message
  end

  function GetParentMessage( self, message )
    return super_shared.ourMessage
  end
end
```
```lua
do class "ChildB" : namespace "examples" : extends "Example"
  {}

  shared_block {
    ourMessage = "",
  }

  function SetOurMessage( self, message )
    shared.ourMessage = message
  end

  function GetOurMessage( self, message )
    return shared.ourMessage
  end

  function SetParentMessage( self, message )
    super_shared.ourMessage = message
  end

  function GetParentMessage( self, message )
    return super_shared.ourMessage
  end
end
```
```lua
local a = examples.ChildA:New( "Hello" )
local b = examples.ChildB:New( "World" )

a:SetOurMessage( "Hey There!" )
print( b:GetOurMessage() ) -- prints nothing, as ChildA and ChildB have different shared blocks

a:SetParentMessage( "Hey There!" )
print( b:GetOurMessage() ) -- prints "Hey There!", as ChildA and ChildB extend from the same parent with a shared block
```

**NOTE:** Shared blocks are an advanced feature. Be aware that calling a parent method which reads or writes from `shared` will try to read from the child's shared block and not the parent's!
You can only read from a parent's shared block via `super_shared`.
