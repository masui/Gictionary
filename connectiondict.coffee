# -*- coding: utf-8 -*-
#
# 接続辞書による変換
#
#

d = require './dict.js'

hashLink = []
connectionLink = []

patind = (s) ->
  switch s[0]
    when 'a', 'i', 'u', 'e', 'o', 'A', 'I', 'U', 'E', 'O' then 0
    when 'k', 'g' then 1
    when 's', 'z' then 2
    when 't', 'd', 'T' then 3
    when 'n' then 4
    when 'h', 'b', 'p' then 5
    when 'm' then 6
    when 'y', 'Y' then 7
    when 'r' then 8
    else 10
      
init = ->
  dict = readDict()
  initDict dict

readDict = ->
  d.dict.map (d) ->
    {pat:d[0], word:d[1], out:d[2], in:d[3]}

initDict = (dict)->
  #
  # 先頭読みが同じ単語のリストをつなげておく
  #
  cur = []
  for entry, i in dict
    if !entry.word.match /^\*/
      ind = patind entry.pat
      if !hashLink[ind]?
        cur[ind] = i
        hashLink[ind] = i;
    else
	    dict[cur[ind]].hashLink = i
	    cur[ind] = i
  #
  # コネクションつながりのリスト
  # 
  cur = []
  for entry, i in dict
    ind = entry.in
    if !connectionLink[ind]?
	    cur[ind] = i
	    connectionLink[ind] = i
    else
	    dict[cur[ind]].connectionLink = i
	    cur[ind] = i
  dict

dict =init()

console.log dict[0]
console.log dict[1]



#class DictEntry
#  attr_reader :pat, :word, :inConnection, :outConnection
#  attr_accessor :keyLink, :connectionLink
#
#  def initialize(pat,word,inConnection,outConnection)
#    @pat = pat
#    @word = word
#    @inConnection = inConnection
#    @outConnection = outConnection
#    @keylink = nil
#    @connectionLink = nil
#  end
#end
#  
#class ConnectionDict
#  def initialize(dict)
#    @dict = []
#    @keyLink = []
#    @connectionLink = []
#    readDict(dict)
#    initLink()
#  end
#
#
#  def search(pat,searchmode,&block)
#    @searchmode = searchmode
#    @candidates = []
#    generateCand(nil, pat, "", "", &block)
#  end
#  
#  def generateCand(connection, pat, foundword, foundpat, &block)
#    # これまでマッチした文字列がfoundword,foundpatに入っている
#    # d = (connection ? @connectionLink[connection] : @keyLink[pat[0]]) <- Ruby1.8
#    d = (connection ? @connectionLink[connection] : @keyLink[pat.ord])
#    while d do
#      if pat == @dict[d].pat then # 完全一致
#        block.call(foundword+@dict[d].word, foundpat+@dict[d].pat, @dict[d].outConnection)
#      elsif @dict[d].pat.index(pat) == 0 # 先頭一致
#        if @searchmode == 0 then
#          block.call(foundword+@dict[d].word, foundpat+@dict[d].pat, @dict[d].outConnection)
#        end
#      elsif pat.index(@dict[d].pat) == 0 # connectionがあるかも
#        restpat = pat[@dict[d].pat.length,pat.length]
#        generateCand(@dict[d].outConnection, restpat, foundword+@dict[d].word, foundpat+@dict[d].pat, &block)
#      end
#      d = (connection ? @dict[d].connectionLink : @dict[d].keyLink)
#    end
#  end
#end
####
