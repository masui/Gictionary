#
# dict1.txt: Gictionary2 から生成されたもの
#   ~/Gictionary/Makefile 
#	ruby getdict2 > tmp/tmp.txt
#	grep -v '.*-' tmp/tmp.txt > tmp/tmp1.txt
#	ruby -I~/SlimeDict/programs ~/SlimeDict/programs/dicmerge \
#		~/SlimeDict/data/wikipedia.txt 500 \
#		~/SlimeDict/data/ktai.txt 300 \
#		tmp/tmp1.txt 1000 \
#		> ~/SonyRemote/dict1.txt
# dict2.txt: 
#   ruby -I~/SlimeDict/programs ~/SlimeDict/programs/connection2txt dict1.txt  > dict2.txt
#

dict2.txt: dict1.txt
	ruby -I~/SlimeDict/programs ~/SlimeDict/programs/connection2txt dict1.txt  > dict2.txt
dict.js: dict2.txt
	ruby programs/dict2js.rb dict2.txt > dict.js

