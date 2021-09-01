-- Es 1 - Informatica

    -- Consegna
        {-
        Considerare il seguente codice che, dato l'input di una form, ne valida il contenuto:
        -}

        valida (nome, cognome, luogo_di_nascita, data_di_nascita, eta) =
            (nome <> "") && (cognome <> "") && (luogo_di_nascita ∈ elenco_citta) && is_valid_date (data_di_nascita) && (eta = in_anni (today () - data_di_nascita))


    -- Domanda 1 - Modifica del codice + Aggiunta di funzioni di verifica
        -- Consegna
            {-
            Il tipo di validazione effettuata per molti campi è debole (es. il nome potrebbe essere formato da numeri).
            Riscrivere il codice **prendendo in input cinque funzioni aggiuntive**, ognuna delle quali responsabile della validazione di uno dei campi.
            Mostrare l'istanza che equivale al codice originario.
            Fate attenzione al fatto che per validare l'età serva anche la data di nascita.
            -}
        -- Svolgimento
            valida (valida_nome, valida_cognome, valida_ldn, valida_ddn, valida_eta, nome, cognome, luogo_di_nascita, data_di_nascita, eta) =
                valida_nome (nome) && valida_cognome (cognome) && valida_ldn (luogo_di_nascita) && valida_ddn (data_di_nascita) && valida_eta (eta, data_di_nascita)

            -- Istanza:
            valida (vnc, vnc, vldn, vddn, ve, nome, cognome, ldn, ddn, eta)
            -- Dove:
            vnc (n) = n <> "" -- Generalizzabile sia per il nome che per il cognome
            vldn (ldn) =  ldn ∈ elenco_città
            vddn (ddn) = is_valid_date (ddn)
            ve (e, ddn) = (e = in_anni (today () - ddn))

    
    -- Domanda 2 - Aggiunta di specifiche + Generalizzazione del codice
        -- Consegna
            {-
            Alcuni clienti trovano interessante non solo restituire un booleano, ma restituire OK se tutti i campi sono corretti, oppure (ERR msg) dove
            msg è un messaggio di errore che descriva l'errore riferito al primo dei campi non validi.
            Generalizzare ulteriormente il codice del punto 1 in modo tale che vengano prese in input anche una generalizzazione & dell'operazione && a
            un tipo qualunque, ed un elemento tt che indichi successo (da utilizzare nel corpo della funzione in modo appropriato).
            Mostrare due istanze, la prima equivalente al codice del punto 1 e la seconda che soddisfa alla richiesta aggiuntiva dei clienti.
            -}
        -- Svolgimento


    -- Domanda 3
        -- Consegna
            {-
            Quali proprietà devono rispettare tt e & affinché il codice sia corretto, ovvero restituisca tt sse tutti i campi sono validi?
            (es. x & tt = ??, tt & tt = ??, e così via)
            -}
        -- Svolgimento


    -- Domanda 4
        -- Consegna
            {-
            Fornire un'ulteriore istanza per il codice del punto 2 ove, invece di restituire OK o (ERR msg) in caso di input invalido dove msg è il primo errore,
            venga restituita una lista di errori (uno per ogni campo invalido).
            La lista vuota rappresenta l'assenza di errori.
            -}
        -- Svolgimento
