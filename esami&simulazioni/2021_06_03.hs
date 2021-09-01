-- Es 1 - Informatica
    
    -- Consegna
        -- Un dipendente inizia a lavorare su codice preesistente che permette di scalare  l'alesaggio dei pistoni di un motore:

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
            scala_alesaggio (m, k, []) = []         -- m è il modello del motore ricercato, k è il valore che andrà a variare il va
            scala_alesaggio (m, k, Auto :: L) = scala_alesaggio_auto (m, k, Auto) :: scala_alesaggio (m, k, L)

            scala_alesaggio_auto (m, k, < Mot, Ruo >) = < scala_alesaggio_motore (m, k, Mot), Ruo >
            
            scala_alesaggio_motore (m, k, < Mod, Pis, Val >) =
                if m = Mod then < Mod, scala_alessagio_pistoni (k, Pis), Val >  -- Se è il modello ricercato, procede con l'alesaggio
                else < Mod, Pis, Val >                                          -- Altrimenti ritorna l'elemento della lista senza apportare modifiche
            
            scala_alesaggio_pistoni (k, < Pis1, Pis2 >) = < scala_alesaggio_pistone (k, Pis1), scala_alesaggio_pistone (k, Pis2) >s

            scala_alesaggio_pistone (k, < Ale, Lun >) = < k * Ale, Lun >
        


    -- Domanda 1
        -- Consegna
            {-
            Il dipedente deve modificare il codice in maniera tale che:
            1. Si possa scalare anche la lunghezza del pistone
            2. Si possa anche settare l'alesaggio a un valore fissato
            3. Si possano gestire anche motori con quattro pistoni
            -}
        -- Svolgimento
            -- Dunque, per intenderci si ha che:
                Auto ::=  < < Modello, < < Alesaggio, Lunghezza >, < Alesaggio, Lunghezza > >, ValvolaDiPressione >, Ruote >
                Auto ::=  < < Modello, < < 𝔽, 𝔽 >, < 𝔽, 𝔽 > >, ValvolaDiPressione >, Ruote >

            -- È richiesto dunque di generalizzare prima il codice, e poi di adempire alle richieste poste al dipendente, ergo si può precedere in 2 modi:
                -- 1. Trovare la generallizzazione e istanziare le nuove funzioni
                -- 2. Scrivere le nuove funzioni e trovare una generalizzazione (scelta più semplice per i pivelli alle prime armi)

                -- Scelta 2:
                    -- Funzioni varie:
                        -- Funzione per scalare la lunghezza del pistone:
                            scala_lunghezza (m, k, []) = []
                            scala_lunghezza (m, k, Auto :: L) = scala_lunghezza_auto (m, k, Auto) :: scala_lunghezza (m, k, L)

                            scala_lunghezza_auto (m, k, < Mot, Ruo >) = < scala_lunghezza_motore (m, k, Mot), Ruo >

                            scala_lunghezza_motore (m, k, < Mod, Pis, Val >) =
                                if m = Mod then < Mod, scala_lunghezza_pistoni (k, Pis), Val >
                                else < Mod, Pis, Val >
                        
                            scala_lunghezza_pistoni (k, < Pis1, Pis2 >) = < scala_lunghezza_pistone (k, Pis1), scala_lunghezza_pistone (k, Pis2) >

                            scala_lunghezza_pistone (k, < Ale, Lun >) = < Ale, k * Lun >
                
                        -- Funzione per settare l'alesaggio ad un alroe fissato
                            setta_alesaggio (m, k, []) = []
                            setta_alesaggio (m, k, Auto :: L) = setta_alesaggio_auto (m, k, Auto) :: scala_lunghezza (m, k, L)
            
                            setta_alesaggio_auto (m, k, < Mot, Ruo >) = < setta_alesaggio_motore (m, k, Mot), Ruo >

                            setta_alesaggio_motore (m, k, < Mod, Pis, Val >) =
                                if m = Mod then < Mod, setta_alesaggio_pistoni (k, Pis), Val >
                                else < Mod, Pis, Val >

                            setta_alesaggio_pistoni (k, < Pis1, Pis2 >) = < setta_alesaggio_pistone (k, Pis1), setta_alesaggio_pistone (k, Pis2) >

                            setta_alesaggio_pistone (k, < Ale, Lun >) = < k, Lun >

                        -- Funzione per gestire motori con 4 pistoni
                            -- In tal caso il motore è seguito come segue: Motore ::= < Modello, Pistoni, Pistoni, ValvolaDiPressione >
                            
                            scala_alesaggio_4p (m, k, []) = []
                            scala_alesaggio_4p (m, k, Auto :: L) = scala_alesaggio_auto_4p (m, k, Auto) :: scala_alesaggio_4p (m, k, L)

                            scala_alesaggio_auto_4p (m, k, < Mot, Ruo >) = < scala_alesaggio_motore_4p (m, k, Mot), Ruo >
                            
                            scala_alesaggio_motore_4p (m, k, < Mod, Pis1, Pis2, Val >) =
                                if m = Mod then < Mod, scala_alessagio_pistoni_4p (k, Pis1), scala_alessagio_pistoni_4p (k, Pis2) Val >
                                else < Mod, Pis1, Pis2, Val >
                            
                            scala_alesaggio_pistoni_4p (k, < Pis1, Pis2 >) = < scala_alesaggio_pistone_4p (k, Pis1), scala_alesaggio_pistone_4p (k, Pis2) >s

                            scala_alesaggio_pistone (k, < Ale, Lun >) = < k * Ale, Lun >

                    -- Funzione generalizzate (tramite chiamate esplicite)
                        modifica_auto_1 (f, m, []) = []
                        modifica_auto_1 (f, m, Auto :: L) = modifica_auto_2 (f, m, Auto) :: modifica_auto ()

                        modifica_auto_2 (f, m, < f >)
                        setta_alesaggio_auto (m, k, < Mot, Ruo >) = < setta_alesaggio_motore (m, k, Mot), Ruo >


    -- Domanda 2
        -- Consegna
            {-
            Come deve essere generalizzato il codice precedente usando funzioni di ordine superiore in modo da ottenere la funzionalità originale,
            le due nuove e molte altre come istanze? Mostrare anche il codice per tali istanze.
            Suggerimento: Il codice generico deve essere composto dalle funzioni di ordine superiore: modifica_automobili, modifica_auto, modifica_motore, modifica_pistoni, etc.
            -}
        -- Svolgimento