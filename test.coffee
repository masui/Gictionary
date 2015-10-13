#
# テスト
# 
assert = require 'assert'
dict =   require './dict.coffee'

success = (a, b) ->
  assert dict.search(a).indexOf(b) >= 0
fail = (a, b) ->
  assert dict.search(a).indexOf(b) < 0

# console.log dict.search('masui')
  
success 'meguro',        "目黒"
success 'meguroeki',     "目黒駅"

success 'masui',         "増井"
fail    'masux',         "増井"
success 'masuisaN',      "増井さん"
success 'm[aiueo]suisa', "増井さん"

success '[kg][aiueo][kg][aiueo]s[aiueo][aiueo]', "国際"

success 'taberaremaseN', "食べられません"
success 't[aiueo]b[aiueo]r[aiueo]remaseN', "食べられません"
success 'taberare', "食べられ"
success 't[aiueo]b[aiueo]maseN', "食べません"
success 't[aiueo]b[aiueo]maseN', "飛びません"
fail     'eeee', "ああああ"
success 'taiyou', "太陽"
success 'heNkousuru', "変更する"
success 'heNkous[aiueo]r[aiueo]', "変更する"

assert dict.search('sa').length > 10
assert dict.search('sa').length <= 20






