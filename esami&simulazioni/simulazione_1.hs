-- Es 1 - Informatica

    -- Consegna generica
        {-
        Si consideri i seguenti due frammenti di codice:
        -}

        trova_sufficienti [] = []
        trova_sufficienti (x : l) =
            if x >= 18 then x : trova_sufficienti l
            else trova_sufficienti l

        trova_validi [] = []
        trova_validi (y : v) =
            if x < 0 || x > 30 then trova_validi v
            else "ok" : trova_validi v
 
        
    -- Domanda 1
        -- Consegna
            {-
            Cosa calcolatrova_sufficienti (3 : 28 : 32 : 4 : []) ?
            -}
        -- Svolgimento
            trova_sufficienti (3:28:32:4:[]) = 
                if 3 >= 18 then 3 : trova_sufficienti (28:32:4:[])
                else trova_sufficienti (28:32:4:[])
            -- else case, OUTPUT -> 

            trova_sufficienti (28:32:4:[]) =
                if 28 >= 18 then 28 : trova_sufficienti (32:4:[])
                else trova_sufficienti (32:4:[])
            -- if case, OUTPUT -> 28 : trova_sufficienti (32:4:[])

            trova_sufficienti (32:4:[]) =
                if 32 >= 18 then 32: trova_sufficienti (4:[])
                else trova_sufficienti (4:[])
            -- if case, OUTPUT -> 28 : 32 : trova_sufficienti (4:[])

            trova_sufficienti (4:[]) =
                if 4 >= 18 then 4: trova_sufficienti ([])
                else trova_sufficienti ([])
            -- else case, OUTPUT -> 28 : 32 : trova_sufficienti ([])

            trova_sufficienti [] = []
            -- OUTPUT -> 28 : 32 : []


    -- Domanda 2
        -- Consegna
            {-
            Cosa calcola trova_validi (-4 : 9 : 7 : 32 : []) ?
            -}
        -- Svolgimento
            trova_validi (-4:9:7:32:[]) = 
                if -4 < 0 || -4 > 30 then trova_validi (9:7:32:[])
                else "ok" : trova_validi (9:7:32:[])
            -- if case, OUTPUT -> trova_validi (9:7:32:[])

            trova_validi (9:7:32:[]) = 
                if 9 < 0 || 9 > 30 then trova_validi (7:32:[])
                else "ok" : trova_validi (7:32:[])
            -- else case, OUTPUT -> "ok" : trova_validi (7:32:[])

            trova_validi (7:32:[]) = 
                if 7 < 0 || 7 > 30 then trova_validi (32:[])
                else "ok" : trova_validi (32:[])
            -- else case, OUTPUT -> "ok" : "ok" : trova_validi (32:[])

            trova_validi (32:[]) = 
                if 32 < 0 || 32 > 30 then trova_validi ([])
                else "ok" : trova_validi ([])
            -- if case, OUTPUT -> "ok" : "ok" : trova_validi ([])

            trova_validi [] = []
            -- OUTPUT -> "ok" : "ok" : []


    -- Domanda 3
        -- Consegna
            {-
            Trovare una generalizzazione del codice che abbia come istanze sia trova_sufficienti che trova_validi.
            La generalizzazione può essere espressa sia facendo prendere in input altre funzioni esplicitamente, sia attraverso un meccanismo di type classes.
            -}
        -- Svolgimento

            -- Soluzione con chiamata esplicita delle funzioni

                -- Funzione generalizzante
                    gen_trova c b [] = []            -- condition (per gli if-else), binary (per una scelta binaria)
                    gen_trova c b (x : l) =
                        if c x then b x : gen_trova c b l
                        else gen_trova c b l

                -- Istanza della prima funzione
                    trova_sufficienti l = gen_trova c1 id l
                    -- Dove:
                        c1 x = x >= 18
                        id x = x
                    -- e dunque:
                        gen_trova c1 id [] = [] 
                        gen_trova c1 id (x : l) =
                            if c1 x then (id x) : gen_trova c1 id l
                            else gen_trova c1 id l
                    
                -- Istanza della seconda funzione
                    trova_validi l = gen_trova c2 b2 l
                    -- Dove:
                        c2 x = !(x < 0 || x > 30)    -- Si nega così da poter invertire il costrutto dell'if con quello dell'else (per quanto riguarda trova_validi)
                        b2 x = "ok"
                    -- e dunque:
                        gen_trova c2 b2 [] = []
                        gen_trova c2 b2 (x : l) =
                            if c2 x then (b2 x) : gen_trova c2 b2 l
                            else gen_trova c2 b2 l

            -- Soluzione con l'uso di una type class
                class trovaClass a b where
                    c:: a -> Bool
                    b:: a -> b       -- Si scrive che si ritorna un z per generalizzare l'output, in quanto (si assume) che z possa assumere qualsiasi valore

                -- La seguente riga si può leggere come segue:
                    -- Per tutti gli a e b per cui esiste un istanza di Filtraggio, si ha che data una lista di a, si ottiene ottenere una lista di b.
                gen_trova :: trovaClass a b => [a] -> [b]   -- Il codice del prof è errato, la freccia prima di [b] è "->" anzichè "=>"
                gen_trova [] = []
                gen_trova (x : l) =
                    if c x then b x : gen_trova l
                    else gen_trova l

                instance trovaClass int int where        -- Istanza di trova_sufficienti
                    c x = x >= 18
                    b x = x
                
                instance trovaClass int String where     -- Istanza di trova_validi
                    c x = !(x < 0 || x > 30)
                    b x = "ok"

                {- Spiegazione: DA COMPLETARE DA COMPLETARE DA COMPLETARE DA COMPLETARE DA COMPLETARE DA COMPLETARE DA COMPLETARE DA COMPLETARE
                    Si "ricicla" quello che è stato fatto nella parte precedente:
                        - I parametri della classe sono gli stessi della funzione generalizzante
                        - I parametri in questione hann oi medesimi input ed output
                        - La funzione generalizzante (definita separatamente dalla classe) gen_trova è definita allo stesso modo
                        
                        - Sostanzialmente si tratta di "spostare" le definizioni del codice generalizzato tramite chiamata esplicita
                -}


    -- Domanda 4
        -- Consegna
            {-
            Mostrare una terza istanza che data una lista di numeri restituisca la lista ottenuta eliminando i numeri dispari e
            dividendo per due i numeri pari rimanenti.
            Esempio:   dimezza (3 : 4 : 7 : 8 : 10 : []) = 2 : 4 : 5 : []
            -}
        -- Svolgimento
            dimezza [] = []
            dimezza (x : l) =
                if (x 'mod' 2) == 0 then (x / 2) : dimezza l
                else dimezza l

            -- Chiamata di funzione esplicita
                dimezza l = gen_trova c3 b3 l
                -- Dove:
                    c3 = (x 'mod' 2) == 0
                    b3 = x / 2
                -- e dunque:
                    gen_trova c3 b3 [] = []
                    gen_trova c3 b3 (x : l) =
                        if c3 x then (b3 x) : gen_trova c3 b3 l
                        else gen_trova c3 b3 l

            -- Uso di una type class
                instance trovaClass int int where
                    c x = (x 'mod' 2) == 0
                    b x = x / 2
