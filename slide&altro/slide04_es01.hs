    -- Premesse
        {-
        Considerare il seguente programma definito su liste di triple dove:
            - La prima componenete è un numero naturale (un identificatore univoco)
            - La seconda e la terza una stringa (nome e cognome)
        -}
        first (x, nome, cognome) = x        -- Ritorna la x
        third (x, nome, cognome) = cognome  -- Ritorna il cognome

        -- Cerca x nella lista e restituisce il cognome
        search x [] = []
        search x (p:l) =
            if ((first p) == x) then third p
            else search x l

    -- Consegna
        {-
        Arriva un cambio alle specifiche.
        Ora si vuole aggiungere anche il codice fiscale e si vuole che la funzione search restituisca quello anziché il cognome.
        Piuttosto che modificare il codice ad-hoc per ottenerne un altro ad-hoc, si generalizzi tale
        programma per far si ché i due problemi ne diventino istanza.

        Sia Persona (a, k, v), dove:
            - a generalizza la n-upla
            - k generalizza la chiave (l'identificatore univoco)
            - v generalizza il cognome
        Se sono state implementate le funzioni dopo il where, allora Persona (a, k, v) descrive una funzione
        -}

    -- Svolgimento mio (non ho la minima idea di quanto possa andar bene al prof)
        -- Il codice fatto ad-hoc sarebbe il seguente: (lo scrivo per intuire più facilmente la generalizzazione)
            second (x, code, name, surname) = code  -- Ritorna il codice fiscale
            searchCode c [] = []
            searchCode c (p:l) =
                if ((first p) == x) then second p
                else search x l

        -- Sia double n dato definito come segue:
            double = ((x, c), name, surname)
                
        -- La generalizzazione è la seguente
            gen return_f [] = []
            gen return_f (double:l) =
                if ((first double) == ?) then return_f double
                else gen op return_f ? l

            -- Dove:
                search = gen third
                searchCode = gen second
            


    -- Svolgimento
        class Persona (a, k, v) where
            key :: a -> k                   -- Il metodo key prende in input a e ritorna la chiave k
            value :: a -> v                 -- Il metodo value prende in input a e ritorna v
            default :: v                    -- Il metodo default ritorna v

            search :: Persona (a, k, v) => k -> [a] -> v    -- Prende in input una Persona, => boh, una lista di a, dopodiché ritorna v
            search x [] = default           -- Se la lista è vuota ritorna v
            search x (c:l) =
                if key c == x then value c  -- Se la chiave k corrisponde con l'elemento della lista in analsi, ritorna il v di c (ricordare che c è una n-upla) 
                else search x l

        -- Prima istanza del problema:
        instance Persona ((Integre, String, String), Integer, String) where     -- v è una String perché bisogna ritornare il cognome
            key (id, nome, cognome) = id
            value (id, nome, cognome) = cognome     -- value ritorna il cognome
            default = ""                            -- Il valore di default ritornato qualora la lista sia vuota, è la stringa vuota

        -- Seconda istanza del problema:
        instance Persona ((Integer, CodiceFiscale, String, String), Integer, CodiceFiscale) where   -- v è un CodiceFiscale perché bisogna ritornare un codice fiscale
            key (id, cf, nome cognome) = id
            value (id, cf, nome, cognome) = cf      -- value ritorna il codice fiscale
            default = "SC3M0_CH1_L3663"             -- Il valore di default ritornato qualora la lista sia vuota, è un codice specifico


    -- Continuo della consegna
        {-
        Ogni due giorni arriva la richiesta di aggiungere un nuovo campo alla descrizione, continuando a restituire sempre
        il codice fiscale, e i programmatori si sono stufati di creare sempre nuove istanze di type class.

        Invece di aggiungere un nuovo elemento x ad una tupla c. si può formare la coppia (c, x) la cui prima componente è la vecchia coppia.
        Esempio: (con l'aggiunta del valore degli anni)
            Invece della quadrupla: (id, cf, nome, cognome, anni)
            si può utilizare il dato isomorfo: ((id, cf, nome, cognome), anni)

        Con una dichiarazione di istanza spiegare al compilatore che formare un coppia con
        una Persona e un nuovo valore forma ancora una Persona
        -}