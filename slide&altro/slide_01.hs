-- ES 01

    -- Generalizzare i seguenti codici:
    -- Problema: Data una lista di interi, restituirne la somma
        som [] = 0
        sum (n:l) = n + sum l
    
    -- Problema: Data una lista di booleani, restituire la loro congiunzione
        conj [] = True
        conj (b:l) = conj l && b



    -- Svolgimento #################################################################
    
        -- Si potrebbe trovare direttamente la generalizzazione finale, ma per esercizio si generalizzano entrambi i codici.

        -- Generalizzazione della prima funzione:
            -- Nella funzione sum vi è un'elemento vuoto e ed una operazione op, ergo si ha:
                -- Caso []:
                    gen_sum op e [] = e
                -- Caso (x:l):
                --  gen_sum op e (n:l) = n op (gen_sum op e l)      -- Scrivere in questo modo è errato, la versione successiva è corretta
                    gen_sum op e (n:l) = op n (gen_sum op e l)      -- L'operazione op prende come parametri n e la chiamata ricorsiva
        
        -- Istanza delle funzioni sum e conj tramite gen_sum:
            sum  = gen_sum (+)  0
            conj = gen_sum (&&) True


        -- Generalizzazione della seconda funzione:
            -- Nella funzione conj vi è un elemento per il caso lista vuota, ed un'operazione op
                -- Caso []:
                    gen_conj op e [] = e
                -- Caso (x:l):
                    gen_conj op e (x:l) = op (gen_conj op e l) x

        -- Istanza delle funzioni sum e conj tramite gen_conj:
            sum  = gen_conj (+)  0
            conj = gen_conj (&&) True


        -- In questo caso potrebbe sembrare che le due generalizzazioni siano equivalenti, ma le due esse differiscono
        -- nelle proprietà che "supportano", infatti come si evince dalla slide gen_conj non è associativa.
            