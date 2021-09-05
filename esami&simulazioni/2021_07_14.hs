-- Es 1 - Informatica

    -- Consegna
        {-
        Considerare il seguente codice che, dato l'input di una form, ne valida il contenuto:
        NOTA: Con "<>" il prof intende "diverso"
        -}

        valida (nome, cognome, luogo_di_nascita, data_di_nascita, eta) =
            (nome <> "") && (cognome <> "") &&
            (luogo_di_nascita ∈ elenco_citta) &&
            is_valid_date (data_di_nascita) &&
            (eta = in_anni (today () - data_di_nascita))

    -- Domanda 1 - Modifica del codice + Aggiunta di funzioni di verifica
        -- Consegna
            {-
            Il tipo di validazione effettuata per molti campi è debole (es. il nome potrebbe essere formato da numeri).
            Riscrivere il codice prendendo in input cinque funzioni aggiuntive, ognuna delle quali responsabile della validazione di uno dei campi.
            Mostrare l'istanza che equivale al codice originario.
            Fate attenzione al fatto che per validare l'età serva anche la data di nascita.
            -}
        -- Svolgimento
            -- Legenda:
                {-
                vnc: valida nome cognome
                vldn: valida luogo di nascita
                vddn: valida data di nascita
                ve: valida età
                n: nome
                c: cognome
                ldn: luogo di nascita
                ddn: data di nascita
                e: età
                -}

            valida (vnc, vldn, vddn, ve, n, c, ldn, ddn, e) =
                vnc (nome) && vnc (cognome) && vdn (luogo_di_nascita) && vddn (data_di_nascita) && ve (eta, data_di_nascita)

            -- Istanza:
            valida (vnc, vldn, vddn, ve, n, c, ldn, ddn, e)
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
            valida (tt, &, vnc, vldn, vddn, ve, n, c, ldn, ddn, e) =
                tt &
                vnc(nome) & vnc(cognome) &
                vldn(luogo_di_nascita) &
                vddn(data_di_nascita) &
                ve(data_di_nascita, eta)
                -- Dove
                    -- tt: In questo caso rappresenta un valore aggiountivo da mettere in analisi all'operaizione &
                    -- &: È una semplice generalizzazione di un'operazione (nonostante dal testo non si comprenda benissimo)

            -- Istanza equivalente alla prima
                valida (true, &&, vnc, vldn, vddn, ve, n, c, ldn, ddn, e)
                -- Dove:
                    -- tt assume il valore di verità (in questa istanza non ha "importanza")
                    -- & = &&, ovvero è la semplice operazione and

            -- Istanza per i clienti
                valida (OK, $$, v_vnc, v_vldn, vvd, vve, n, c, ldn, ddn, e)
                -- Dove:
                    -- Legenda:
                        {-
                        v_vnc: valida_vnc
                        v_vldn: valida_vldn
                        ....
                        -}
                    OK $$ x = x     -- (OK1 $$ OK2) $$ ... = OK2 $$ ... 
                    (ERR msg) $$ x = (ERR msg)
                    v_vnc = if vnc(n) && vnc(n) then OK else ERR "nome o cognome non valido"
                    v_vldn = if vldn(ldn) then OK else ERR "luogo di nascita non valido"
                    ....

                    

    -- Domanda 3
        -- Consegna
            {-
            Quali proprietà devono rispettare tt e & affinché il codice sia corretto, ovvero restituisca tt sse tutti i campi sono validi?
            (es. x & tt = ??, tt & tt = ??, e così via)
            -}
        -- Svolgimento
        tt & tt = tt                                     in assenza di errori bisogna propagare il valore tt
        tt & x <> tt     per ogni x <> tt                al primo errore non bisogna restituire tt
        x & tt <> tt     per ogni x <> tt                dopo un errore non bisogna mai tornare a tt


    -- Domanda 4
        -- Consegna
            {-
            Fornire un'ulteriore istanza per il codice del punto 2 ove, invece di restituire OK o (ERR msg) in caso di input invalido
            (dove msg è il primo errore), venga restituita una lista di errori (uno per ogni campo invalido).
            La lista vuota rappresenta l'assenza di errori.
            -}
        -- Svolgimento



            valida([], @, lvn,lvc,lvl,lvd,lve, nome, cognome, luogo_di_nascita, data_di_nascita, eta)
            dove
            @ è la concatenazione di liste
            lvnNo = if vnNo then [] else ["nome invalido"]
            lvcNo = if vnNo then [] else ["cognome invalido"]