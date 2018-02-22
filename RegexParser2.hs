{-# LANGUAGE FlexibleContexts #-}
module Main where

{- Matthew Tennis
   CSCI 3500 Project I
   12 October 2015 		-}   
   
import DataTypes
import Text.Parsec hiding (runParser)
import Text.Parsec.Expr
import Text.Parsec.String
import qualified Text.Parsec.Token as Token
import Text.Parsec.Language
import Control.Applicative hiding ((<|>), many)
import Control.Monad.Identity
import Text.ParserCombinators.Parsec.Char
import System.IO

lexer = haskellStyle {
  Token.reservedOpNames = 
  ["(", ")", "*", ".", "+"] }
tokenizer  = Token.makeTokenParser lexer
reservedOp = Token.reservedOp tokenizer
parens     = Token.parens tokenizer

test1 = (Lit 'H')
test2 = (Concat (Lit 'e') (Lit 'l'))
test3 = (Concat (Concat (Lit 'l') (Lit 'o')) (Concat (Lit ' ') (Lit 'W')))	
test4 = [test1,test2,test3]
test5 = (Uni (test3) (test2))

-- IO Stream Parser --

afile :: FilePath
afile = "text.txt"

setPath :: String -> FilePath
setPath [] = error "Empty file!"
setPath (s:[]) = [s]
setPath (s:st) = s:(setPath st)

fileParse fp = do
	result <- parseFromFile fparse fp
	return result

-- Types declared only because GHCi would not compile without
	
fparse :: ParsecT String u Identity [[String]]
fparse = endBy lparse eol

lparse :: ParsecT String u Identity [String]
lparse = sepBy cells (char ',')

cells :: ParsecT String u Identity String
cells = 
	do 	first <- cellContent
		next <- remainingCells
		return $ first ++ next

cellContent :: ParsecT String u Identity String
cellContent = many (noneOf ",\n")

remainingCells :: ParsecT String st Identity String
remainingCells =
	(string "," >> cells)
	<|> (return [])

eol :: ParsecT String u Identity String
eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"

-- End IO Stream Parser --

-- Regular Expression Parser --

-- ioToStr :: (IO (Either ParseError [[String]])) -> ParsecT String u Identity [[String]]
ioToStr input = rexp

rxParse :: ParsecT (IO (Either ParseError [[String]])) u Identity [[String]]
rxParse = undefined

parseStar :: ParsecT String u Identity Regex
parseStar = do 
	r1 <- parseRegex
	char '*'
	return (Star r1)

parseConcat :: ParsecT String u Identity Regex
parseConcat = do 
	r1 <- parseRegex
	char '.'
	r2 <- parseRegex
	return (Concat r1 r2)

parseUnion :: ParsecT String u Identity Regex
parseUnion = do
	r1 <- parseRegex
	char '+'
	r2 <- parseRegex
	return (Uni r1 r2)
	
-- parseLit :: ParsecT Char u Identity Regex
parseLit = do
	r1 <- oneOf validChars
	return (Lit r1)	
	
validChars = ['a'..'z']++['A'..'Z']++['0'..'9']++"$-_!',"
	
-- parseExp :: String -> AExp
-- parseExp str = runParser aexp str

rexp = buildExpressionParser rxTable rexp'
	<?> "REGEX PARSER"
	
rexp' = parens rexp
	<|> parseRegex
	<?> "Oops, something went wrong!"

parseRegex = parseRegex' 
parseRegex' = (parens parseRegex') 
			<|> parseStar 
			<|> parseConcat 
			<|> parseUnion 
			<|> parseLit
			<?> "ERROR" 
	
rxTable = [  [binary "+" Uni AssocLeft]
			,[binary "." Concat AssocLeft]
			,[postfix "*" Star]  ]

binary  name fun assoc = Infix (do{ reservedOp name; return fun }) assoc
prefix  name fun       = Prefix (do{ reservedOp name; return fun })
postfix name fun       = Postfix (do{ reservedOp name; return fun })

-- Regex to NFA Parser --

rx2nfaP :: GenParser Regex st [NFA]
rx2nfaP = undefined

-- TRASH CODE -- 
-- TRASH CODE -- 
-- TRASH CODE -- 

-- rx :: String -> [Regex]
-- rx "" = [(Lit 'a')]
-- rx (x:xs) = (Lit x) : rx xs

-- rxTest :: ParsecT Regex [[String]]
-- rxTest = undefined

-- runParser p str = 
    -- case parse p "" str of
      -- Left e  -> error $ show e
      -- Right r -> r

-- numParse = do
  -- n <- many1 digit
  -- return.Val $ ((read n)::Integer)

--runParser :: Stream s Identity t => Parsec [[String]] () Regex -> s -> a
-- runParser p str = 
    -- case parse p "" str of
      -- Left e  -> error $ show e
      -- Right r -> r

-- rxParser = do
	-- result <- parseFile afile
	-- x <- undefined
	-- return x

-- TRASH CODE -- 
-- TRASH CODE -- 
-- TRASH CODE -- 

-- IO / main
main = do
	putStrLn "Enter a regular expression."
	inputString <- getLine
	let middle = (ioToStr inputString)
	
	putStrLn "Enter address location of .txt file to search."
	loc <- getLine
	
	let abc = (fileParse loc)
	
	putStrLn ("Location is: " ++ loc ++ " .")
	
	let theExp = ioToStr abc
	
	putStrLn ("")
	