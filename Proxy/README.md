The Proxy Design Pattern is where we place an object between the user and the actual object the user wishes to interact with.

There are a few different types of proxy object:

- Protection proxies
- Remote proxies
- Virtual proxies

For the purpose of our example we'll implement the 'virtual proxy' which is where we create a proxy object to prevent an expensive object instantiation operation from happening until the user actually interacts with one of the methods on the real object.

We would typically need to build stub methods for each method that we want to proxy, but this could because tedious and inefficient if we have more than a dozen methods (as all we're doing is manually recreating each function and delegating to the original object).

To avoid this manual method creation our proxy pattern utilises the dynamically typed nature of the Ruby language to forward on calls to missing methods to the original object.