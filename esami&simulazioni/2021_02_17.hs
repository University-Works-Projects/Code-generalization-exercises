-- Es 2 - Informatica

    -- Premesse generiche
        {-
        Una lista L di naturali è definita dalla seguente grammatica:   L := [] | N :: L
        Esempio:
            3 :: 4 :: 5 :: []

        Un albero binatio di naturali è definito dalla seguente grammatica:   T := Nil | T # N # T
        Esempio:
            (Nil # 3 # Nil) # 4 # (Nil # 5 # Nil) è l'albero che ha 4 come radice e si ramifica in un sottoalbero di
            sinistra che contiene 3 e due rami vuoti e uno di destra che contiene 5 con due rami vuoti.
        
        Un albero n-ario di naturali è definito dalla seguente grammatica:   B ::= ℕ ** A ; A ::= [[]] | B ::: A
        Intuizione: un albero (B) è dato da un nodo che contiene un numero e una lista (A) di sotto-alberi figli
        Esempio:
            L'albero del precedente esempio è rappresentabile come: 4 ** ((3 ** [[]]) ::: (5 ** [[]]) ::: [[]]), ovvero
            ha una radice etichettata con 4 che ha una lista di due figli; il primo ha una radice etichettata con 3 e non
            ha figli, mentre il secondo ha una radice etichettata con 5 e non ha figli.
        -}

    -- Consegna generica
        -- Considerare i seguenti problemi con le relative soluzioni:
            -- Problema: sum_all L calcola la somma di tutti i numeri in L
                sum_all [] = 0
                sum_all (N :: L) = N + sum_all L

            -- Problema: multiply_all T calcola il prodotto di tutti i numeri in T
                multiply_all Nil = 1
                multiply_all (T1 # N # T2) = multiply_all T1 * N * multipy_all T2

            -- Problema: max_all_B B calcola il massimo di tutti i numeri nell'albero n-ario B
            -- Problema mutualmente ricorsivo:  max_all_A A calcola il massimo di tutti i numeri nella lista di alberi n-ari A
                max_all_A [[]] = 0
                max_all_B (N ** A) = max N (max_all_A A)                -- Max tra la foglia e il sottoalbero
                max_all_A (B ::: A) = max (max_all_B B) (max_all_A A)   -- Max tra i due sottoalberi

        -- I codici sono tutti differenti, ma i tre problemi sono chiaramente istanze di un problema più generale.
        
    -- Domanda 1
        -- Consegna
            {-
            Rispondere brevemente alle seguenti domande:
            1.1 Descrivere a parole il problema più generale.
            1.2 Quale ruolo giocano 0/+, 1/* e 0/max nei tre esempi?
            1.3 Quale struttura algebrica vista a lezione generalizza nella maniera più precisa (ℕ, +, 0), (ℕ, *, 1) e (ℕ, max, 0)?
            1.4 A parole, qual è la generalizzazione comune di una lista, un albero binario e un albero n-ario di interi?
            1.5 A parole, qual è la generalizzazione comune delle tre funzioni?
            -}

        -- Svolgimento
            -- 1.1
                {-
                Il problema consiste nel calcolare un'operaizone op tra gli elementi di una struttura dati.
                -}
            -- 1.2
                {-
                Rappresentano rispettivamente l'elemento ritornato in caso di lista/foglia vuota e l'operazione che la funzione svolge.
                -}
            -- 1.3
                {-
                Monoide.
                -}
            -- 1.4 - Domanda non capita, ne consegue una risposta possibilmente erronea
                {-
                Un array può rappresentare tutte le strutture dati viste.
                -}
            -- 1.5
                {-
                Una funzione che scorra/visiti la struttura dati in input, e ad ogni valore sia applicata un'operazione.
                -}

    
    -- Altra consegna generica
            {-
            Tutte e quattro le funzioni (sum_all, multiply_all, max_all_A e max_all_B) prendono in input una struttura dati e in base
            alla sua forma possono:
                1. Restituire 0/1/0 (quando?)
                2. Estrarre un numero e una certa quantità di strutture dati simili su cui andare in ricorsione (1 coda nel caso della lista,
                   2 sotto-alberi nel caso degli alberi binari, una lista di sotto-alberi n-ari nel caso degli alberi n-ari).
                   Osservare che:
                    1.1 Una coda (ovvero una sottolista) è rappresentabile con una lista lunga 1 di liste.
                    1.2 Una coppia di sotto-alberi binari è rappresentabile con una lista lunga 2 di sottoalberi binari.
                    1.3 Una lista di sotto-alberi-nari è già una lista di sottoalberi nari.
            A partire da questa osservazione, rispondete alle domande successive:
            -}

    -- Domanda 2
        -- Consegna
            {-
            Definire una type class:  Reduce N C  dove:
                - N deve essere il carrier della struttura algebrica del punto 1, i cui elementi/operazioni devono essere elencati nella
                    definizione della type class e le cui proprietà metterete come commento nella type class.
                - C deve essere il tipo che rappresenta astrattamente un albero n-ario (e quindi anche una lista o un albero binario)
                - Le operazioni definite su C nella type class devono permettere di:
                    1. Estrarre un elemento di N da C (cosa potete estrarre quando C non contiene nessun N?).
                    2. Estrarre da C una lista di nuovi C (i sottoalberi di C).
            -}

        -- Svolgimento


    -- Domanda 3
        -- Consegna
            {-
            Scrivere due funzioni mutualmente ricorsive:
                reduce ::  Reduce N C => C -> N
                reduce_L :: Reduce N C => [C] -> N
            Che calcolino un valore di tipo N a partire da un albero astratto di tipo C o da una lista di alberi astratti di tipo C
            (indicata con il tipo [C] in Haskell)
            Suggerimento: il codice sarà molto simile a quello delle max_all_B / max_all_A
            -}

        -- Svolgimento
    
    
    -- Domanda 4
        -- Consegna
            {-
            Fornire tre istanze della type class Reduce N C che permettano di ritrovare le tre funzioni di partenza
            -}

        -- Svolgimento


A parole: il problema generale consiste nel calcolare (x1 op ... op xn) dove op è l'operazione di un monoide  e x1, ..., xn 
sono i dati contenuti in una struttura dati (arborescente) che contiene dati tutti dello stesso tipo.
Nota 1: Nei tre esempi da generalizzare il monoide è sempre commutativo.
Nota 2: Il fatto che le tre strutture siano arborescenti permette di risolvere il problema per ricorsione strutturale 
sulle sotto-strutture arborescenti, presenti in numero variabile (1/2/un qualunque numero finito).

class Reduce N C where
   neutral :: N
   op :: N -> N -> N
   -- (N, neutral, op) forma un monoide
   get :: C -> N
   children :: C -> [C]

reduce :: Reduce N C => C -> N
reduce c = op (get c) (reduce_L (children c))
reduce_L :: Reduce N C => [C] -> N
reduce_L [] = neutral
reduce_L (c : l) = op (reduce c) (reduce_L l)

instance Reduce Nat L where
   neutral = 0
   op x y = x + y
   get [] = 0
   get (x:l) = x
   children [] = []
   children (x:l) = l : []

instance Reduce Nat T where

   neutral = 1
   op x y = x * y
   get Nil = 1
   get (l # x # r) = x
   children Nil = []
   children (l # x # r) =  l : r : []

instance Reduce Nat B where
   neutral = 0
   op x y = max x y
   get (x  l) = x
   children (x  l) = l

Nota: la seconda istanza è equivalente alla multiply_all solo in virtù della commutatività del prodotto.