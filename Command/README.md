The Command Design Pattern can be useful in situations where you need to accumulate a number of operations over time, but want to execute them all at once. Installers do this all the time. In a typical installation program, you go through the wizard saying that yes, you want the basic program, and yes, you want the documentation, but no, you do not want the example files.

A similar situation arises when you need to perform a series of operations for which each operation has a substantial start-up cost when done alone. For example, connecting to a database could be a costly procedure and so to do that multiple times might not be a good idea (alternatively you could leave the connection open for a long time but that too might not be a good idea). With the Command pattern we can avoid both those scenarios by grouping together lots of commands that require database access.

One thing to be careful of is overusing the Command pattern when there is no need. In this example we have built up a specific command class to handle deleting a file but we could also simply just run...  

`File.delete 'file.txt'` 