# Gictionary - オープンなテキスト入力用辞書
Gictionaryはテキスト入力システムに利用するためののオープンな辞書データベースです。
<a href="http://Gyazz.com/Gictionary2">Gyazz.com/Gictionary2</a>にあるデータを
このレポジトリのソフトウェアで
<a href="http://GitHub.com/Gyaim">Gyaim</a>、
<a href="http://GitHub.com/GyaimMotion">GyaimMotion</a>、
<a href="http://GitHub.com/Slime">Slime</a>
などの辞書に変換します。

- GyaimはMacRubyで実装したMac用のIMEです (MountainLion以前用)
- GyaimMotionはRubyMotionで実装したMac用のIMEです (Yosemite以降用)
- SlimeはAndroid用のIMEです

## 辞書の構造

例えば「<a href="http://Gyazz.com/Gictionary2/目黒">目黒</a>」というエントリには以下のようなテキストが入っています。

    めぐろ 山手線駅名 駅名地名接続
    めぐろ 名前 名前接続
    [[山手線駅名]] [[苗字1]] [[目]] [[黒]]

- 読み、単語のカテゴリ、単語に続く可能性があるカテゴリを空白で区切って並べます
- 続くカテゴリが無い場合は読みと単語カテゴリだけを記述します
- 「目黒」は駅名または人名の可能性があるので2個のエントリが記述されています
- このフォーマットに適合していない場合は辞書エントリとして扱いません

また「<a href="http://Gyazz.com/Gictionary2/駅">駅</a>」というエントリは以下のようになっています。
  
    えき 駅名地名接続 地名接続

この単語のカテゴリは「駅名地名接続」であり、
「目黒」の後に「駅」が接続可能であることを示しています。
これらの辞書を使うことにより、
GyaimやSlimeでは「めぐろえき」や「m g r e k」のようなパタン文字列を「目黒駅」に変換します。

## その他
- 特殊な単語を登録する場合はカテゴリをきちんと表示するべき
- 重要度もカテゴリで識別する
  - e.g. よくある名前 / 珍しい名前, 大都市 / 小都市
  

