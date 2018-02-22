* NOTE - Written, compiled, and tested in Windows ghci 7.10.1
   
This is an incomplete project, and as such, testing for correct/implemented elements is challenging. This is posted purely for legacy purposes.

- Use ghci interpreter and run RegexParser.hs

- DataTypes contains Regex datatype, NFA datatype, Regex operations and conversions, and the skeleton of the NFA

- NFA is incomplete largely because I was planning to successfully parse a Regex and feed it directly into an NFA

- Having been unsuccessful in connecting the elements of my Regex parser, I didn't have the expected engine in which I could define my NFA constructor.

- RegexParser.hs contains main, much of the surviving Arith.hs elements, my file parser, my Regex parser, importing DataType and non-implemented code. 

- File parser (fileParse) does not function with full directories, and only works with .txt files placed in the same directory as its container. 
	
- I tried multiple methods to take the IO string and assign it to be a FilePath, I created a method called setPath for this purpose. However, only literally typing the directory/location into fileParse has any actual effect. Otherwise, it gives an "openFile" error.
	
- fileParse "test.txt" or whatever testfile you choose to use.

- test.txt is a .txt containing the search elements provided in the project description.

- test1, test2, ... test5 exist and are all of type Regex or [Regex]. Useful for little tests w/ makeString, makeString', 
