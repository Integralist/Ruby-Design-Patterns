The Singleton design pattern is used whenever you have an object that only requires a single instance to be used (e.g. Database connection class or a utility object that contains a long list of helper methods).

We have three variations:

1. Singleton
2. Singleton-require
3. Singleton-module

I find the Module variation is the best option as it doesn't require having to create a new instance of an object using an unconventional `instance` method and also the fact that you can't create an instance of a module means the intent is made clearer.
