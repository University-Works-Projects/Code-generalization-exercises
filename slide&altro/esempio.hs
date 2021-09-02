-- Come esguire il codice
    {-
    0. Installare ghci tramite il comando "sudo apt install ghc"
    1. Aprire il terminale ed andare nella cartella contentente il codice da eseguire
    2. Digitare sul terminale ":l nomeFile.hs"
    Check: Se ad inizio riga del terminale c'è scritto "*Main>" allora puoi eseguire il codice
    3. Digitare "isEqual True True" per avere un esempio di output
    Bonus: Dopo aver scritto del nuovo codice, per poterlo eseguire vai al punto 2
    -}

-- Prima versione
    class BasicEq var where -- Si crea la classe BasicEq che prende come parametro var
        -- Dichiarazione del metodo della classe
        isEqual :: var -> var -> Bool   -- Prende due input var e ritorna un booleano

    instance BasicEq Bool where     -- Si definisce una istanza della classe con i rispettivi output in base a varie casistiche
        isEqual True  True  = True
        isEqual False False = True
        isEqual _     _     = False -- Ritorna False per casi di input differrenti da quelli sopra dichirati 


-- Seconda versione
    class BasicEq2 var where
        isEqual2    :: var -> var -> Bool
        isNotEqual2 :: var -> var -> Bool

    instance BasicEq2 Bool where
        isEqual2 True  True  = True
        isEqual2 False False = True
        isEqual2 _     _     = False
        isNotEqual2 True  False = True
        isNotEqual2 False True  = True
        isNotEqual2 _     _     = False


-- Terza versione

    {-
    class BasicEq3 var where
        isEqual3 :: var -> var -> Bool
        isEqual3 x y = not (isNotEqual3 x y)
        isNotEqual3 :: a -> a -> Bool
        isNotEqual3 x y = not (isEqual3 x y)
    -}
        



--main :: IO ()
--main =
    --isEqual False False