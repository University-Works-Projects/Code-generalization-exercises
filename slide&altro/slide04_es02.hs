{-

    Consegna esercizio:
        Considerare il seguente programma che cerca un numero x in una lista ordinata
        di numeri, rappresentanti l'età di alcune persone:
-}
        search n [] = False
        search n (m:l) = 
            if n > m then search n l
            else n == m
{-
        Esso è corretto in quanto si può dimostrare il seguente teorema:
            Se l è ordinata ed n è in l, allora search n l = True
        
        Arriva ora un cambio di specifiche.
        Ora il capo vuole che la lista diventi una lista di coppie dove la prima componente è l'età e la seconda un codice fiscale.
        La lista continua ad essere ordinata per età, ed ovviamente per ogni codice fiscale è associata una sola età.
        Invece di implementare la nuova specifica, generalizzare la funzione search in modo che lavori su liste di oggetti
        di qualunque tipo, che siano ordinabili in qualunque modo.
-}

    -- Generalizzazione tramite chiamata esplicita (PROBABILMENTE ERRATAAAAAAAA)
    gen_search op1 op2 e el [] = e
    gen_search op1 op2 e el (x:l) =
        if op1 el x then search op1 op2 e el l
        else op2 el x

    -- Istanza
    search1 = gen_search (>) (==) False 

    -- Generalizzazione tramite le type class (NON CAPITAAAAAAA)
    class GenSearch a where
        (>) :: a -> a -> Bool

        search :: GenSearch a => a -> [a] -> Bool
        search n [] = False
        search n (m:l) =
            if n > m then search n l
            else n == m

    -- Istanza
    instance GenSearch (Integer, CodiceFiscale) where
        (x, cf1) > (y, cf2) = x > y
    
{-
    Continuo della consegna:
        Quali proprietà aggiuntve deve soddisfare un tipo ordinato affinchè continui a valere il
        teorema citato in precedenza? In particolare, il codice ottenuto è corretto per la seconda istanza?

-}

