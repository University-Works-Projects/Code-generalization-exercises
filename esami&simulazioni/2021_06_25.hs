-- Es 1 - Informatica

    -- Consegna
        {-
        Considerate il seguente frammento di codice che legge da un database un elenco di dipendenti con i rispettivi volumi di vendita,
        seleziona il dipendente migliore e gli invia una mail di ringraziamento.
        -}

        thanks (dbname, password) = process (query_db (open_db (dbname, password), "SELECT * FROM dipendenti"), DUMMY)

        process ([], migliore) = ringrazia(migliore)
        process (dip :: L, migliore) =
            if migliore = DUMMY || dip.vendite > migliore.vendite then process(L, dip)
            else process(L,migliore)

        ringrazia (migliore) = send_mail (migliore.indirizzo_mail, "Sei stato il più bravo, grazie a te i proprietari hanno guadagnato di più, continua così!")




        -- Vedere se le domande sono divise correttamente






    -- Domanda 1
        -- Consegna
            {-
            Il codice viola l'architettura esagonale in quanto il codice mischia la business logic, ovvero la parte algoritmica che prende decisioni a partire dai dati,
            con le system dependencies, ovvero il codice che interagisce con gli elementi architetturali del sistema (file system, database, connessione a server come quello di posta, etc.).
            Questo comporta una serie di problemi, quali:
                1. Per testare la business logic (per capire se effettivamente seleziona il miglior dipendente) è necessario avere installato un database e un server di posta.
                2. Per apportare modifiche architetturali al sistema, per esempio sostituire il database locale a un servizio cloud remoto,
                oppure l'invio di mail all'invio di un SMS o alla pubblicazione di una pagina Web pubblica, bisogna ritoccare il codice per chiamare nuove funzioni o passare
                nuovi parametri (es. magari un'installazione locale diversa di un database può non richiedere la password)
                3. Non si distingue l'intenzione del codice, che fa parte della business logic (es: recuperare la lista di dipendenti, gratificare un dipendente),
                dalla sua implementazione tramite scelte di sistema.
            -}
        
        -- Svolgimento
    
    -- Domanda 2
        -- Consegna
            {-
            Riscrivere tutto il codice (thanks/process/ringrazia) in modo da rendere l'architettura esagonale.
            In particolare il nuovo codice dovrà astrarre completamente sulle operazioni di recupero della lista dei dipendenti e sul modo in cui i dipendenti vengono gratificati.
            Più esplicitamente viene richiesto di:
                1. Mostrare una versione generica del codice che usa funzioni di ordine superiore, ovvero dove le funzioni prendono in input altre funzioni
                per astrarre le operazioni da compiere.
                NOTA: Non si può prendere in input direttamente la lista di dipendenti e dare in output il nome del dipendente, bisogna necessariamente astrarre sull'operazione
                        che restituisce la lista di dipendenti e su quella che lo gratifica.
                2. Mostrare un'istanza del codice generico che sia equivalente al programma originale
                3. Mostrare un'istanza differente di testing dove il codice ottenga la lista prefissata di dipendenti: -}
                    { indirizzo_mail = "csc@badcompany.org", vendite = "666999" } ::
                    { indirizzo_mail = "best_of_the_best@badcompany.org", vendite = "33" } :: []
                e dove la gratificazione verifichi che l'indirizzo_mail del migliore sia "csc@badcompany.org" e stampi un errore altrimenti usando la chiamata print("errore").
            -}

        -- Svolgimento
