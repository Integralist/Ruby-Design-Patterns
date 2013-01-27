The Strategy Design Pattern is a simple combination of composition and delegation.

The guiding principle is that you have a 'context' object and potentially multiple 'strategy' objects.

The 'context' object is your main Class which then delegates responsiblity for a particular piece of functionality to the relevant 'strategy' objects.

In this example we're using Classes for each 'strategy' object but if your strategy is a simple/single piece of functionality then rather than use a Class you could use a Proc (i.e. a `lambda`) - see example provided