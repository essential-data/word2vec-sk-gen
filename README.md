Nástroj na vygenerovanie slovenských sémantických vektorov pre word2vec z korpusu
=================================================================================

Autorské práva
--------------

Copyright (c) 2015 Essential Data, s.r.o.

Toto dielo je možné používať v súlade s licenciou Apache License, verzia 2.0 z januára 2004

Viac informácií v súbore LICENSE. 

Zaujíma vás práca s jazykom? Pracujte pre nás!
----------------------------------------------

Essential Data pracuje s jazykom, s dátami a na zaujímavých projektoch. Pozrite si
[aktuálne otvorené pozície](http://www.essential-data.sk/pracujte-pre-nas/) a pracujte v skvelom
tíme plnom šikovných ľudí.

O projekte
----------

Tento projekt je určený pre použitie s nástrojom [word2vec](https://code.google.com/p/word2vec/). Jeho
cieľom je vygenerovať sémantické vektory z jazykového korpusu, ktorý dostane na vstupe (štandardne si
stiahne slovenskú Wikipediu). Tento nástroj bol použitý na vygenerovanie vektorov v projekte
[word2vec-sk](https://github.com/essential-data/word2vec-sk), avšak tieto boli vygenerované z väčšieho
korpusu (cca 110 miliónov slov), ktorý nemôžeme šíriť. Ak nedisponujete väčším korpusom, odporúčame
iba použiť vygenerované vektory. Ak máte dostatok zdrojových dát v Slovenčine, môžete použiť tieto
nástroje a filtre na vygenerovanie sémantických vektorov.

Je možné použiť obidva podporované algoritmy (continuous bag of words, skip-gram). Priložený Makefile
stiahne všetky potrebné nástroje a dáta (slovenskú wikipediu, [lematizátor](https://github.com/essential-data/lucene-fst-lemmatizer))
a pod.

Vygenerované slovníky, v ktorých mene sa nachádza reťazec "lemma" budú natrénované na korpuse,
ktorý prešiel morfologickou úpravou (známych) slov na základný tvar našim lematizátorom.

Závislosti
----------

Tento projekt je tak trochu "zmeska", preto potrebujete:
 * ``perl`` a ``sed`` na filtrovanie textu
 * ``java`` pre lematizátor
 * ``svn`` na stiahnutie aktuálnej verzie word2vec
 * bežné vývojové nástroje (``patch``, ``gcc``, ``make``, ...)
 * ``bzip2``, ``find``, ``wget``

Pre základné slovníky (zlematizované a iba s wikipediou) budete potrebovať cca 1.3GB miesta. 

Trénovanie
----------

Keďže najpoužiteľnejšie vektorové slovníky sú po použití lematizátora, tieto vytvoríte príkazom ``make``.
Ak máte veľa času, môžete vytvoriť všetky vektorové slovníky príkazom ``make all``, to bude ale chvíľu trvať.

Použitie
--------

Sémantické vektory majú mnohé zaujímavé vlastnosti. Zachovávajú vzťahy (napríklad pri spustení nástroja
word-analogy a zadaní slov ``Francúzsko Paríž Nemecko`` najbližší vektor k výsledku je slovo ``Berlín``.

Takto je možné vytvárať aj triedy slov pre clustering a množstvo iných užitočných aplikácií.

Odkazy
------

* [Github spoločnosti Essential Data](https://github.com/essential-data/) - obsahuje naše open-source projekty (aj) pre prácu s jazykom
* [Aktuálne otvorené pozície](http://www.essential-data.sk/pracujte-pre-nas/) v spoločnosti Essential Data
* [word2vec](https://code.google.com/p/word2vec/) - nástroj pre vytvorenie a používanie sémantických vektorov