module DataTypes where

type Set a = [a]
type State = Integer

data NFA = NFA {
 states 	:: Set State
 ,alphabet 	:: Set Char
 ,start 	:: State
 ,final 	:: Set State } deriving (Show, Eq, Ord)

data Regex = Regex
 |Epsi					-- epsilon
 |Lit Char				-- a
 |Concat Regex Regex    -- a.b
 |Star Regex			-- a*
 |Uni Regex Regex		-- a+b
 |Parens Regex          -- (a)
 deriving (Show, Eq, Ord)
 
-- Set Operations --

subset :: Eq a => Set a -> Set a -> Bool
subset [] _ = True
subset (x:xs) s2 = (x `elem` s2) && (subset xs s2)

eqSet :: Eq a => Set a -> Set a -> Bool
eqSet s1 s2 = (subset s1 s2) && (subset s2 s1)

subsetEq :: Eq a => Set a -> Set a -> Bool
subsetEq s1 s2 = (subset s1 s2) || (eqSet s1 s2)

-- End Set Operations --

-- Regex Operations --

regexOps = [Lit '(', Lit ')', Lit '*', Lit '.', Lit '+']

lit :: Regex -> String
lit Epsi = []
lit (Lit a) = [a]
lit r@(Concat a b) = conCat r 

conCat :: Regex -> String
conCat Epsi 	= []
conCat (Lit a) 	= [a]
conCat (Concat (Lit a) (Lit b)) 
				= [a] ++ [b]
conCat (Concat (Concat a b) (Concat c d)) 	
				= conCat a ++ conCat b ++ conCat c ++ conCat d

conCat' :: [Regex] -> String
conCat' [] = []
conCat' [Epsi] = []
conCat' (r@(Concat (Lit a) (Lit b)):xs) = (conCat r) ++ (conCat' xs)

uni :: Regex -> String
uni Epsi 		 = []
uni (Uni Epsi b) = lit b
uni (Uni a Epsi) = lit a
uni (Uni a b) 	 = undefined

uni' :: [Regex] -> String
uni' [Epsi] = []
uni' ((Uni Epsi b):xs) = undefined

makeString :: [Regex] -> String
makeString [] = []
makeString [Epsi] = []
makeString [(Lit a)] = [a]
makeString [r@(Concat a b)] = makeString' r
makeString [r@(Uni a b)] = makeString' r
makeString [r@(Star a)] = makeString' r
makeString (r:rx) = makeString' r ++ makeString rx

makeString' :: Regex -> String
makeString' Epsi = []
makeString' (Lit a) = [a]
makeString' (Concat a b) = (makeString' a) ++ (makeString' b)
makeString' (Uni a b) = (makeString' a) ++ (makeString' b)
makeString' (Star a) = makeString' a

makeRegex :: String -> Regex
makeRegex [] = Epsi
makeRegex (s:st) = (Concat (Lit s) (makeRegex st))

makeRegex' :: [Char] -> [Regex]
makeRegex' [] = [Epsi]
makeRegex' (s:st) 
	| (s /= '.' && s /= '+' && s /= '*' && s /= '(' && s /= ')') == True = (Lit s):(makeRegex' st)
	| otherwise = undefined
	
-- NFA Operations and Functions --

-- Function to generate states based on word
makeStates :: String -> Set State
makeStates [] = []
makeStates (x:xs) = undefined

-- Helper function to check if Alphabet already contains Symbol
checkAlpha :: Set Char -> Set Char -> Set Char
checkAlpha (x:xs) (y:ys) = undefined

-- Function to make set of alphabet characters
makeAlpha :: String -> Set Char
makeAlpha [] = []
makeAlpha (x:[]) = undefined
makeAlpha (x:xs) = undefined

-- Function to make transition function
makeTrans = undefined

accept = undefined

reject = undefined

regexToNFA :: Regex -> NFA
regexToNFA Epsi = createNFA [0] [] 0 [0]
regexToNFA (Lit a) = createNFA [0,1] [a] 0 [1]
regexToNFA (Concat Regex Regex) = undefined


createNFA :: Set State -> Set Char -> State -> Set State -> NFA 
createNFA q al q0 f = (NFA q al q0 f)