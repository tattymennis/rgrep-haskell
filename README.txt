{- Matthew Tennis
   CSCI 3500 Project I
   12 October 2015 -}

Dr. Eades,

This is an incomplete project, and as such, testing for correct/implemented elements is challenging. I recommend the following:

* NOTE - Written, compiled, and tested in Windows only!
 
- RegexParser2.exe (and other executables) are not meaningfully implemented, and the main function tests were important for me,
	but likely trivial for you. In other words, the executable doesn't do anything useful and should not be used.
	--make file.hs was something I didn't know beforehand.

- Instead, execute RegexParser.hs as a testing environment, as it imports the module DataTypes.hs.

- DataTypes contains my Regex datatype, NFA datatype, Regex operations and conversions, and the skeleton of the NFA
	NFA is incomplete largely because I was planning to successfully parse a Regex and feed it directly into an NFA
	Having not succeeded in connecting the elements of my Regex parser, I didn't have the expected engine in which I could define
	my NFA constructor.

- RegexParser.hs contains main, much of the surviving Arith.hs elements, my file parser, my Regex parser, importing DataType and non-implemented code. 

- File parser (fileParse) does not function with full directories, and only works with .txt files placed in the same directory as 
	its container. 
	Also, I tried multiple ways to take the IO string and assign it to be a FilePath, I created a method called setPath for this purpose.
	However, only literally typing the directory/location into fileParse has any actual effect. Otherwise, it gives an
	"openFile" error.
- So... type: 
- fileParse "test.txt"
	or whatever testfile you choose to use.

- test.txt is a .txt containing the search elements provided in the project description.

- test1, test2, ... test5 exist and are all of type Regex or [Regex]. Useful for little tests w/ makeString, makeString', 

- There is some scratch code commented out, and a few vestigial blocks that don't do anything meaningful. Most represent first drafts.

- I get a bunch of "Warning: Tab character" whenever I compile, but it compiles all the same. I hear its a patchable bug.

- Again, this is incomplete. However, I feel that I learned and researched an immense amount of knowledge to even come this far. I hope
	the work submitted is worthy of partial credit, considering the scope of solving this problem in Haskell.
