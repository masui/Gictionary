//
// テスト
//

assert = require('assert');
dict =   require('./dict.js'); // 変換プログラム

assert(dict.search('masuisaN').indexOf("増井さん") >= 0);
assert(dict.search('eeee').indexOf("ああああ") < 0);
assert(dict.search('m[aiueo]suisa').indexOf("増井さん") >= 0);
assert(dict.search('taiyou').indexOf("太陽") >= 0);
assert(dict.search('heNkousuru').indexOf("変更する") >= 0);
assert(dict.search('sa').length > 10);
assert(dict.search('sa').length <= 20);


