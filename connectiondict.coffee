# -*- coding: utf-8 -*-
#
# 接続辞書による変換
#
#

dictjs = require './dict.js'

hashLink = []         # 先頭文字が一致する辞書エントリのリスト
connectionLink = []   # 接続番号が一致する辞書エントリのリスト
# regexp = []           # パタンの部分文字列にマッチするRegExp
# cslength = []         # regexp[n]に完全マッチするパタンの長さ

init = ->
  dict = readDict()
  initDict dict
  
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
  dictjs.dict.map (d) ->
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

patInit = (pat,level,regexp,cslength) ->
  cslength[level] = 0
  if pat.length > 0
    pat.match(/^(\[[^\]]+\])(.*)$/) || pat.match(/^(.)(.*)$/)
    top = RegExp.$1
    [len, p, regexp, cslength] = patInit(RegExp.$2, level+1, regexp, cslength)
    cslength[level] = len
  else
    [len, p, top] = [0, '', '']
  s = if p.length > 0 then "(#{p})?" else ''
  regexp[level] = RegExp "^(#{top}#{s})"
  [len+1, top+s, regexp, cslength]

# search("masui")
# search("m[aiueo]s[aiueo][aiueo]")

search = (pat,dict,exactmode=false) ->
  console.log dict[14]
  console.log dict[477]
  [len, top, regexp, cslength] = patInit(pat,0,[],[])
  generateCand connection=null, pat, dict, level=0, [], patstack=[], exactmode, candidates=[], regexp, cslength

generateCand = (connection, pat, dict, level, wordstack, patstack, exactmode, candidates, regexp, cslength) ->
  console.log "generateCand: pat=#{pat} regexp = #{regexp[level]} connection=#{connection}, level=#{level}, pat=#{pat}"
  # これまでマッチした文字列がwordstack[], patstack[]に入っている
  d = if connection then connectionLink[connection] else hashLink[patind(pat)]
  #console.log "patind = #{patind(pat)} d = #{d}"
  while d != undefined
    # console.log "*** d = #{d} pat=#{pat}"
    if level > 0
      console.log "dict[d] = #{dict[d].pat}"
      console.log "level=#{level} regexp[level] = #{regexp[level]}"
    if dict[d].pat.match(regexp[level]) # マッチ
      #console.log "level=#{level}"
      #console.log "regexp = #{regexp[level]}"
      #console.log "match!"
      matchlen = RegExp.$1.length;
      #console.log "matchlen=#{matchlen}"
      if matchlen == cslength[level] && (!exactmode || exactmode && dict[d].pat.length == matchlen) # 最後までマッチ
        # ncands = addCandidate(dict[d].word, dict[d].pat, dict[d].outConnection, ncands, level, matchlen);
        wordstack[level] = dict[d].word
        patstack[level] = dict[d].pat
        console.log "found #{wordstack.join('-')}"
      else if matchlen == dict[d].pat.length && dict[d].out != undefined
        #console.log "else part d=#{d} matchlen = #{matchlen} dict[d].pat = #{dict[d].pat}"
        # if pat.index(@dict[d].pat) == 0 # connectionがあるかも
        # restpat = pat[@dict[d].pat.length,pat.length]
        wordstack[level] = dict[d].word
        patstack[level] = dict[d].pat
        console.log "level=#{level} matchlen=#{matchlen} regexp = #{regexp[level+matchlen]}"
        generateCand dict[d].out, pat, dict, level+matchlen, wordstack, patstack, exactmode, candidates, regexp, cslength
    else
      #console.log "not match"
    #console.log "-------#{d}"
    d = if connection then dict[d].connectionLink else dict[d].hashLink
    #console.log "-------next #{d}"
  
dict = init()
search 's[aiueo]NziYuu', dict
