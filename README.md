<h1>Gictionary - オープンなテキスト入力用辞書</h1>

Gictionaryはテキスト入力システムに利用するためののオープンな辞書データベースです。
<a href="http://Scrapbox.io/Gictionary">Scrapbox.io/Gictionary</a>にあるデータを
このレポジトリのソフトウェアで
<a href="http://GitHub.com/masui/Gyaim">Gyaim</a>,
<a href="http://GitHub.com/masui/GyaimMotion">GyaimMotion</a>,
<a href="http://GitHub.com/masui/Slime">Slime</a>,
<a href="http://GitHub.com/masui/Chaim">Chaim</a>
などの辞書に変換します。

<ul>
  <li>GyaimはMacRubyで実装したMac用のIMEです (MountainLion以前用)</li>
  <li>GyaimMotionはRubyMotionで実装したMac用のIMEです (Yosemite以降用)</li>
  <li>SlimeはAndroid用のIMEです</li>
</ul>

<h2>辞書の構造</h2>

例えば「<a href="http://Gyazz.com/Gictionary/目黒">目黒</a>」というエントリには以下のようなテキストが入っています。

<pre>
  めぐろ 山手線駅名 駅名地名接続
  めぐろ 名前 名前接続
  [山手線駅名] [苗字1] [目] [黒]
</pre>

<ul>
  <li>読み、単語のカテゴリ、単語に続く可能性があるカテゴリを空白で区切って並べます</li>
  <li>続くカテゴリが無い場合は読みと単語カテゴリだけを記述します</li>
  <li>「目黒」は駅名または人名の可能性があるので2個のエントリが記述されています</li>
  <li>このフォーマットに適合していない場合は辞書エントリとして扱いません</li>
</ul>

<p>
また「<a href="http://Scrapbox.io/Gictionary/駅">駅</a>」というエントリは以下のようになっています。

<pre>
  えき 駅名地名接続 地名接続
</pre>

この単語のカテゴリは「駅名地名接続」であり、
「目黒」の後に「駅」が接続可能であることを示しています。
これらの辞書を使うことにより、
GyaimやSlimeでは「めぐろえき」や「m g r e k」のようなパタン文字列を「目黒駅」に変換します。

<h2>その他</h2>

<ul>
<li>特殊な単語を登録する場合はカテゴリをきちんと表示するべき</li>
<li>重要度もカテゴリで識別する</li>
  e.g. よくある名前 / 珍しい名前, 大都市 / 小都市
</ul>


