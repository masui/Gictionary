#
# テスト
# 
assert = require 'assert'
dict =   require './dict.coffee'

assert dict.search('masui').indexOf("増井") >= 0
assert dict.search('masuisaN').indexOf("増井さん") >= 0
assert dict.search('m[aiueo]suisa').indexOf("増井さん") >= 0

assert dict.search('taberaremaseN').indexOf("食べられません") >= 0
assert dict.search('t[aiueo]b[aiueo]r[aiueo]remaseN').indexOf("食べられません") >= 0
assert dict.search('taberare').indexOf("食べられ") >= 0

assert dict.search('eeee').indexOf("ああああ") < 0
assert dict.search('taiyou').indexOf("太陽") >= 0
assert dict.search('heNkousuru').indexOf("変更する") >= 0
assert dict.search('sa').length > 10
assert dict.search('sa').length <= 20






