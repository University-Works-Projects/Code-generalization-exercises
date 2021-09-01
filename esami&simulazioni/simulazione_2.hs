-- Es 3 - Informatica
    -- Consegna
        -- Si consideri la seguente grammatica di alberi:
            T ::= Leaf String | Node T T

        {-
        Si considerino le due funzioni f ed f' che cercano una foglia in un albero usando un intero per guidare la ricerca.
         - f restituisce oltre alla stringa trovata nella foglia un log del percorso effettuato.
         - f' si ricorda solamente il numero di passi nel percorso.
        (ricordarsi che ++ è la concatenazione di stringhe)
        -}

        -- f restituirà un qualcosa del tipo: dx sx sx ... Trovata ++ s
            f n (Leaf s) = ("Trovata " ++ s, s)
            f n (Node t1 t2) =
                if pari n then g "sx" (f (n / 2) t1)
                else g "dx" (f (n / 2) t2)
            g s1 (s2, s3) = (s1 ++ s2, s3)

            f' n (Leaf s) = (0, s)
            f' n (Node t1 t2) =
                if pari n then h (f' (n / 2) t1) -- Coen ha sbagliato scrivendo f anzichè f'
                else h (f' (n / 2) t2)           -- Coen ha sbagliato scrivendo f anzichè f'
            h (n, s) = (n + 1, s)


    -- Domanda 1
        -- Consegna
            -- Considerate il seguente albero:
                t = Node (Node (Leaf "a") (Leaf "b")) (Node (Leaf "c") (Leaf "d"))

            {- Dire cosa viene calcolato da:
                1.1 (f 14 t)
                1.2 (f' 4 t)
            -}
        -- Svolgimento
            -- 1.1
                -- (f 14 t) = ?   (con t = Node (Node (Leaf "a") (Leaf "b")) (Node (Leaf "c") (Leaf "d")) )
                -- Funzione invocata n: 1 - Funzioni in attesa: 0 
                f 14 (Node (Node (Leaf "a") (Leaf "b")) (Node (Leaf "c") (Leaf "d")))
                    if pari 14 then g "sx" (f 7 Node (Leaf "a") (Leaf "b"))
                    else g "dx" (f 7 Node (Leaf "c") (Leaf "d"))
                -- Output: g "sx" (f 7 Node (Leaf "a") (Leaf "b"))

                -- Funzione invocata n: 2 - Funzioni in attesa: 0 
                g "sx" (f 7 t) -- (con t = Node (Leaf "a") (Leaf "b")) ...
                ------------------------------------------------------------
                    -- Funzione invocata n: 3 - Funzioni in attesa: 1 g(f(..))
                    f 7 (Node (Leaf "a") (Leaf "b"))
                        if pari 7 then g "sx" (f 7/2 (Leaf "a"))
                        else g "dx" (f 7/2 (Leaf "b"))
                    -- Output: g "dx" (f 3.5 (Leaf "b"))
                    
                    -- Funzione invocata n: 4 - Funzioni in attesa: 2 g(g(..))
                    g "dx" (f 3.5 (Leaf "b")) ...
                    ------------------------------------------------------------
                        -- Funzione invocata n: 5 - Funzioni in attesa: 3 g(g(f(..))) 
                        f n (Leaf s) = ("Trovata " ++ s, s)
                        f 3.5 (Leaf "b")
                        -- Output: "Trovata b", "b" (verranno usati come parametri nella
                        -- 				 funzione in attesa)
                    ------------------------------------------------------------
                    -- RIPRESA invocazione n: 4 - Funzioni in attesa: 2 g(g(..))
                    ... g "dx" ("Trovata b", "b")
                    -- Output: "dx Trovata b" , "b" 
                ------------------------------------------------------------
                -- RIPRESA invocazione n: 2 - Funzioni in attesa: 0
                g "sx" ("dx Trovata b" , "b")
                -- Output: "sx dx Trovata b" , "b"
                    
                -- DUNQUE: (f 14 t) = ("sx dx Trovata b" , "b")

            -- 1.2
                -- (f' 4 t) = ?   (con t = Node (Node (Leaf "a") (Leaf "b")) (Node (Leaf "c") (Leaf "d")) )

                -- Funzione invocata n: 1 - Funzioni in attesa: 0 
                f' 4 (Node (Node (Leaf "a") (Leaf "b")) (Node (Leaf "c") (Leaf "d")))
                    if pari 4 then h (f' 2 Node (Leaf "a") (Leaf "b"))
                    else h (f' 2 Node (Leaf "c") (Leaf "d"))
                -- Output: h (f' 2 Node (Leaf "a") (Leaf "b"))

                -- Funzione invocata n: 2 - Funzioni in attesa: 0 
                h (f' 2 Node (Leaf "a") (Leaf "b")) ...
                -----------------------------------------------------------------
                        -- Funzione invocata n: 3 - Funzioni in attesa: 1 h(f'(..))
                        f' 2 Node (Leaf "a") (Leaf "b")
                            if pari 2 then h (f' 1 (Leaf "a"))
                            else h (f' 1 (Leaf "b"))
                        -- Output: h (f' 1 (Leaf "a"))
                    
                        -- Funzione invocata n: 4 - Funzioni in attesa: 1 h(h(..))
                        h (f' 1 (Leaf "a")) ...
                        ---------------------------------------------------------------
                                -- Funzione invocata n: 5 - Funzioni in attesa: 2 h(h(f(..)))
                                f' 1 (Leaf "a")
                                    (0, "a")
                                -- Output: (0, "a")
                        ---------------------------------------------------------------
                        -- RIPRESA invocazione n: 4 - Funzioni in attesa: 1 h(h(..))
                        ... h (0, "a")
                            (0 + 1, "a")
                        -- Output: (1, "a")
                -----------------------------------------------------------------
                -- RIPRESA invocazione n: 2 - Funzioni in attesa: 0
                h (1, "a")
                    (1 + 1, "a")
                -- Output: (2, "a")

                -- DUNQUE (f' 4 t) = (2, "a")
                Coen ha sbagliato scrivendo (2, "b") anzichè (2, "a")


    -- Domanda 2
        -- Consegna
            {-
            Mostrare una generalizzazione del codice di f e f' che abbia come istanze f, f'.
            Mostrare sia la versione basata su passaggio esplicito di funzioni che quella basata su type classes.
            In entrambi i casi mostrare come si ottengono le istanze.
            -}

        -- Svolgimento

            -- Passaggio esplicito di funzione
                -- Si chiami ff la generalizzazione con passaggio di funzioni
                ff inj combl combr n (Leaf s) = (inj s, s)
                ff inj combl combr n (Node t1 t2) =
                    if pari n then combl (f inj combl combr (n/2) t1)
                    else combr (f inj combl combr (n/2) t2)

                f n t = ff finj fcombl fcombr n t
                f' n t = ff finj' fcomb' fcomb' n t

                -- Dove:
                finj s = "Trovata " ++ s
                fcombl (s1, s2) = ("sx" ++ s1, s2)
                fcombr (s1, s2) = ("dx" ++ s1, s2)

                finj' s = 0
                fcomb' (n,s) = (n+1, s)

                -- Relativa istanza
                ff  n (Leaf s) = (inj s, s)
                ff  n (Node t1 t2) =
                if pari n then combl (f  (n / 2) t1)
                    else combr (f  (n / 2) t2)

            -- Utilizzo delle type classes
                class Log a where
                inj :: String -> a
                combl :: (a, String) -> (a, String)
                combr :: (a, String) -> (a, String)

                -- Relativa istanza
                instance Log String where
                inj = finj
                combl = fcombl
                combr = fcombr

                instance Log Integer where
                inj = finj'
                combl = fcomb'
                combr = fcomb

