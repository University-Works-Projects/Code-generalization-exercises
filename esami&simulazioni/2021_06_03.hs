-- Es 1 - Informatica
    
    -- Consegna
        -- Un dipendente inizia a lavorare su codice preesistente che permette di scalare l'alesaggio dei pistoni di un motore:

            -- Un'auto ha varie componenti fra cui un motore e delle ruote:
                Auto ::= < Motore, Ruote >

            -- Un motore ha due pistoni e altre componenti:
                Motore ::= < Modello, Pistoni, ValvolaDiPressione >

            -- Di pistoni ce ne sono due:
                Pistoni ::= < Pistone, Pistone >

            -- Un pistone è descritto da varie caratteristiche:
                Pistone ::= < Alesaggio, Lunghezza >

            -- 𝔽 genera tutti i numeri floating point:
                Alesaggio ::= 𝔽
                Lunghezza ::= 𝔽

        -- La seguente procedura aggiorna le auto con un determinato modello di motore cambiando l'alesaggio dei pistoni.
            -- Prende in input una lista di automobili
            scala_alesaggio (m, k, []) = []     -- m: modello del motore ricercato, k: valore che andrà a variare il va
            scala_alesaggio (m, k, Auto :: L) = scala_alesaggio_auto (m, k, Auto) :: scala_alesaggio (m, k, L)

            scala_alesaggio_auto (m, k, < Mot, Ruo >) = < scala_alesaggio_motore (m, k, Mot), Ruo >
            
            scala_alesaggio_motore (m, k, < Mod, Pis, Val >) =
                if m = Mod then < Mod, scala_alessagio_pistoni (k, Pis), Val >  -- Se è il modello ricercato, procede con l'alesaggio
                else < Mod, Pis, Val >                                          -- Altrimenti ritorna l'elemento della lista senza apportare modifiche
            
            scala_alesaggio_pistoni (k, < Pis1, Pis2 >) = < scala_alesaggio_pistone (k, Pis1), scala_alesaggio_pistone (k, Pis2) >

            scala_alesaggio_pistone (k, < Ale, Lun >) = < k * Ale, Lun >
        
    -- Svolgimento mio (non so quanto vada bene al prof)
        -- Domanda 1
            -- Consegna
                {-
                Il dipedente deve modificare il codice in maniera tale che:
                    1.1 Si possa scalare anche la lunghezza del pistone
                    1.2 Si possa anche settare l'alesaggio a un valore fissato
                    1.3 Si possano gestire anche motori con quattro pistoni
                -}
            -- Svolgimento
                -- Dunque, per intenderci si ha che:
                    -- L'espansione del dato Auto è la seguente:
                        Auto ::=  <   <  Modello, < <Alesaggio, Lunghezza>, <Alesaggio, Lunghezza> >, ValvolaDiPressione  >, Ruote   >
                        Auto ::=  <   <  Modello, < <𝔽, 𝔽>, <𝔽, 𝔽> >, ValvolaDiPressione  >, Ruote   >
                    -- Mentre il codice fatto ad-hoc per la modifica della lunghezza sarebbe:
                            scala_lunghezza (m, k, []) = []
                            scala_lunghezza (m, k, Auto :: L) = scala_lunghezza_auto (m, k, Auto) :: scala_lunghezza (m, k, L)

                            scala_lunghezza_auto (m, k, < Mot, Ruo >) = < scala_lunghezza_motore (m, k, Mot), Ruo >

                            scala_lunghezza_motore (m, k, < Mod, Pis, Val >) =
                                if m = Mod then < Mod, scala_lunghezza_pistoni (k, Pis), Val >
                                else < Mod, Pis, Val >
                                
                            scala_lunghezza_pistoni (k, < Pis1, Pis2 >) = < scala_lunghezza_pistone (k, Pis1), scala_lunghezza_pistone (k, Pis2) >

                            scala_lunghezza_pistone (k, < Ale, Lun >) = < Ale, k * Lun >

                    -- Si prova ordunque a ideare una generalizzazione che adempisca alle tre domande poste

                        -- Codice (generalizzabile) generalizzato
                            gen1 (op, m, k, []) = []
                            gen1 (op, m, k, Auto::L) = gen2 (op, m, k, Auto) :: gen1 (op, m, k, L)

                            gen2 (op, m, k, <Mot, Ruo>) = gen3 (op, m, k, Mot)

                            gen3 (op, m, k, <Mod, Pis, Val>) =
                                if (m == Mod) then <Mod, op (k, Pis), Val>
                                else <Mod, Pis, Val>
                        
                        -- Istanze:
                            op (k, Pis) = <modify (ma, k, Pis)>
                            -- Dove:
                                -- Per modificare l'alesaggio di 2 pistoni
                                    modify = <ma (k, Pis), ma (k, Pis)>         -- ma: modifyAlesaggio 
                                -- Per modificare l'alesaggio di 4 pistoni
                                    modify = <ma (k, Pis), ma (k, Pis), ma (k, Pis), ma (k, Pis)> 
                                    -- Per variare il valore
                                        ma (k, <Ale, Lun>) = < k * Ale, Lun >
                                    -- Per settare il valore
                                        ma (k, <Ale, Lun>) = < Ale = k, Lun >

                                -- Per modificare la lunghezza di 2 pistoni
                                    modify = <ma (k, Pis), ma (k, Pis)>         -- ma: modifyAlesaggio 
                                    -- Per variare il valore
                                        ma (k, <Ale, Lun>) = < Ale, k * Lun >

   
        -- Domanda 2
            -- Consegna
                {-
                Come deve essere generalizzato il codice precedente usando funzioni di ordine superiore in modo da ottenere la funzionalità originale,
                le due nuove e molte altre come istanze? Mostrare anche il codice per tali istanze.
                Suggerimento: Il codice generico deve essere composto dalle funzioni di ordine superiore: modifica_automobili, modifica_auto, modifica_motore, modifica_pistoni, etc.
                -}
            -- Svolgimento
                -- Il tutto è già stato fatto nella soluzione alla prima domanda