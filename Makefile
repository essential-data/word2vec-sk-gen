lemmavect: vec-sk-cbow-lemma vec-sk-skipgram-lemma

nonlemmavect: vec-sk-skipgram vec-sk-cbow

all: lemmavect nonlemmavect

rebuild:
	make clean
	make all

download: skwiki-latest-pages-articles.xml.bz2

skwiki-latest-pages-articles.xml.bz2:
	wget http://dumps.wikimedia.org/skwiki/latest/skwiki-latest-pages-articles.xml.bz2

trunk:
	svn checkout http://word2vec.googlecode.com/svn/trunk/

trunk/word2vec: trunk
	./compile-word2vec.sh

wiki.txt: skwiki-latest-pages-articles.xml.bz2
	bzip2 -dc skwiki-latest-pages-articles.xml.bz2 | perl prefilter.pl > wiki.txt

vec-sk-cbow-lemma: trunk/word2vec corpus-merged-lemma.txt
	./trunk/word2vec -train corpus-merged-lemma.txt -output vec-sk-cbow-lemma -size 200 -window 5 -sample 1e-4 -negative 5 -hs 0 -binary 1 -cbow 1 -iter 3 -threads 4

vec-sk-cbow: trunk/word2vec corpus-merged.txt
	./trunk/word2vec -train corpus-merged.txt -output vec-sk-cbow -size 200 -window 5 -sample 1e-4 -negative 5 -hs 0 -binary 1 -cbow 1 -iter 3 -threads 4

vec-sk-skipgram-lemma: trunk/word2vec corpus-merged-lemma.txt
	./trunk/word2vec -train corpus-merged-lemma.txt -output vec-sk-skipgram-lemma -size 200 -window 10 -sample 1e-4 -negative 5 -hs 0 -binary 1 -cbow 0 -iter 3 -threads 4

vec-sk-skipgram: trunk/word2vec corpus-merged.txt
	./trunk/word2vec -train corpus-merged.txt -output vec-sk-skipgram -size 200 -window 10 -sample 1e-4 -negative 5 -hs 0 -binary 1 -cbow 0 -iter 3 -threads 4


clean:
	rm -fr skwiki-latest-pages-articles.xml.bz2 wiki.txt trunk corpus-merged.txt corpus-merged-lemma.txt lucene-fst-lemmatizer-0.3.2 vec-sk-cbow-lemma vec-sk-skipgram-lemma vec-sk-skipgram vec-sk-cbow

corpus-merged.txt: wiki.txt
	cp -f wiki.txt corpus-merged.txt
	mkdir -p corpus
	( find corpus -name \*.txt -exec cat {} \; ) >> corpus-merged.txt

lucene-fst-lemmatizer-0.3.2/fstutils-0.3.2-jar-with-dependencies.jar:
	wget -O - https://github.com/essential-data/lucene-fst-lemmatizer/releases/download/0.3.2/lucene-fst-lemmatizer-0.3.2.tar.gz | tar xvzf -

corpus-merged-lemma.txt: corpus-merged.txt lucene-fst-lemmatizer-0.3.2/fstutils-0.3.2-jar-with-dependencies.jar
	cat corpus-merged.txt | (java -jar lucene-fst-lemmatizer-0.3.2/fstutils-0.3.2-jar-with-dependencies.jar lemmatize lucene-fst-lemmatizer-0.3.2/fst/slovaklemma.fst ) | sed -e 's/ a as / a /g'  > corpus-merged-lemma.txt

