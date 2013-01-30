The Composite Design Pattern is made up of three parts:

1. A Common Interface (Base) Class - known as the 'component'
2. One or more 'leaf' Classes (these are all the smaller processes that extend the Base Class)
3. A Composite Class (this is a component built from subcomponents)

---

To put this into analogy form:

The 'component' is the base class and acts similar to an abstract class or interface in other languages

The 'leaf' classes are like employees at a company.

The 'composite' class is like the departments that employees are grouped under.

---

So when creating your main component (your base class) ask yourself "What will my basic and higher-level objects all have in common?"

From there you'll create one or more 'composite' classes that when executed delegates work to one or more 'leaf' classes.

---

On the one hand, the composite object is a component; on the other hand, it is a collection of components.

You will know that you need to use the Composite pattern when you are trying to build a hierarchy or tree of objects, 
and you do not want the code that uses the tree to constantly have to worry about whether it is dealing with a 
single object or a whole bushy branch of the tree.

The goal of the Composite pattern is to make the leaf objects more or less indistinguishable from the composite objects.

The composite has to manage its children, which probably means that it needs to have a method to get at the children 
and possibly methods to add and remove child objects. The leaf classes, of course, really do not have any children to manage; 
that is the nature of leafyness.

On the one hand, we can make the composite and leaf objects different. For example, we can supply the composite object with 
add_child and remove_child methods and simply omit these methods from the leaf class. This approach has certain logic behind it: 
After all, leaf objects are childless, so they do not need the child management plumbing.

Make the leaf and composite classes different, or burden the leaf classes with embarrassing methods that they do not know 
how to handle. My own instinct is to leave the methods off of the leaf classes. Leaf objects cannot handle child objects, 
and we may as well admit it.

The error that crops up so frequently with the Composite pattern is assuming that the tree is only one level deep,
that is, assuming that all of the child components of a composite object are, in fact, leaf objects and not other composites.