#
# テスト
#

assert = require('assert');

dict = require('./connectiondict.js');

assert(dict.search('masuisaN').indexOf("増井さん") >= 0);
assert(dict.search('aiueo').indexOf("ああああ") < 0);


