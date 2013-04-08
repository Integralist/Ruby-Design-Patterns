The Decorator pattern is a straightforward technique that you can use to assemble exactly the functionality that you need at runtime. It offers an alternative to creating a monolithic "kitchen sink" object that supports every possible feature or a whole forest of classes and subclasses to cover every possible combination of features.

 Instead, with the Decorator pattern, you create one class that covers the basic functionality and a set of decorators to go with it. Each decorator supports the same core interface, but adds its own twist on that interface. The key implementation idea of the Decorator pattern is that the decorators are essentially shells: Each takes in a method call, adds its own special twist, and passes the call on to the next component in line. That next component may be another decorator, which adds yet another twist, or it may be the final, real object, which actually completes the basic request.

The Decorator pattern enhances the functionality provided by a core component by implementing an interface that matches the original core component but adds enhanced functionality via that recognised interface but then also delegates responsibility back to the original core component.

We could have just utilised a `method_missing` variation of our implementation rather than hard coding our delegation but to improve on our delegation version of this pattern we went with using the `forwardable` module instead.

The `forwardable` module is more of a precision weapon than the `method_missing` technique. With `forwardable`, you have control over which methods you delegate.

The `method_missing` technique really shines though when you want to delegate large numbers of calls.

Lastly we created a mixin variation as well using Modules.