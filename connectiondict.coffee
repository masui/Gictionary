# -*- coding: utf-8 -*-
#
# 接続辞書による変換
#

dictdata = require './dictdata.js'

hashLink = []         # 先頭文字が一致する辞書エントリのリスト
connectionLink = []   # 接続番号が一致する辞書エントリのリスト
regexp = []           # パタンの部分文字列にマッチするRegExp
cslength = []         # regexp[n]に完全マッチするパタンの長さ
wordstack = []
patstack = []
exactmode = false
candidates = []

init = ->
  initDict readDict()
  
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
      
readDict = ->
  dictdata.dict.map (d) ->
    {pat:d[0], word:d[1], in:d[2], out:d[3]}

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
  # 同じ接続のものをリンクしておく
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

patInit = (pat,level) ->
  cslength[level] = 0
  if pat.length > 0
    pat.match(/^(\[[^\]]+\])(.*)$/) || pat.match(/^(.)(.*)$/)
    top = RegExp.$1
    [len, p] = patInit(RegExp.$2, level+1)
    cslength[level] = len
  else
    [len, p, top] = [0, '', '']
  s = if p.length > 0 then "(#{p})?" else ''
  regexp[level] = RegExp "^(#{top}#{s})"
  [len+1, top+s]

generateCand = (connection, pat, dict, level, candidates, limit=20) ->
  d = if connection then connectionLink[connection] else hashLink[patind(pat)]
  while d != undefined
    if dict[d].pat.match(regexp[level]) # マッチ
      matchlen = RegExp.$1.length;
      if matchlen == cslength[level] && (!exactmode || exactmode && dict[d].pat.length == matchlen) # 最後までマッチ
        # ncands = addCandidate(dict[d].word, dict[d].pat, dict[d].outConnection, ncands, level, matchlen);
        wordstack.push dict[d].word
        word = wordstack.join('')
        candidates.push word unless candidates.indexOf(word) >= 0
        # console.log "found #{wordstack.join('')}"
        return if candidates.length >= limit
        wordstack.pop()
      else if matchlen == dict[d].pat.length && dict[d].out != undefined
        wordstack.push dict[d].word
        generateCand dict[d].out, pat, dict, level+matchlen, candidates, limit
        wordstack.pop()
    d = if connection then dict[d].connectionLink else dict[d].hashLink
  candidates
  
dict = init()

exports.search = (pat,mode=false) ->
  [len, top] = patInit(pat,0)
  exactmode = mode
  wordstack = []
  patstack = []
  candidates = []
  generateCand connection=null, pat, dict, level=0, candidates, limit=20
