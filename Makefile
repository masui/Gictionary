#
# http://Gyazz.com/Gictionary2 の接続辞書を使う日本語変換
#

dict1.txt:
	-mkdir tmp
	ruby programs/getdict > tmp/tmp.txt
	grep -v '.*-' tmp/tmp.txt > tmp/tmp1.txt
	ruby -Iprograms programs/dicmerge \
		data/wikipedia.txt 500 \
		data/ktai.txt 300 \
		tmp/tmp1.txt 1000 \
		> tmp/tmp2.txt
	ruby -Iprograms programs/connection2txt -r rklist.gyaim -n tmp/tmp2.txt > dict1.txt
dict2.txt: dict1.txt
	ruby -Iprograms programs/connection2txt dict1.txt  > dict2.txt
dict.js: dict2.txt
	ruby programs/dict2js.rb dict2.txt > dictdata.js

connectiondict.js: connectiondict.coffee
	coffee -c connectiondict.coffee

test: connectiondict.js
	node test.js

