# ideckia: Hackable and open macro deck

## Zer da?

Mugikorraren bidez ordenagailua (GNU/Linux, Windows, Mac) kontrolatzeko programa bat.

* Ordenagailua kontrolatzeko botoiak sortu (komandoak exekutatu, OBS kontrolatu, laster-teklak, eguraldia erakutsi...)
* Botoi horiek direktorio desberdinetan antolatu (garatzailea, streaming, musika, jokoak...)

Aplikazioak bi zati ditu:

* muina: kontrolatu nahi dugun ordenagailuan exekutatuko den aplikazioa.
* bezeroa: muinari aginduak bidaltzen dizkion aplikazioa. Orri honetan mugikorra erabiliko dugu.

## Nola jarri martxan

Muina:
* Zure sistema eragilearentzako exekutagarriak eta oinarrizko layout bat [hemendik](https://github.com/ideckia/ideckia/releases) deskargatu.
* Deskargatutako exekutagarria martxan jarri. Komunikaziorako erabiliko den portua defektuz 8888 da. Arazorik balego `app.props` fitxategian aldatu daiteke.
* Zure firewall-ean Ideckia baimendu, bezeroak sare lokalean aurki dezan.
* Ordenagailua eta mugikorra sare berean konektatuak daudela egiaztatu.

Bezeroa:
* Mugikorreko aplikazioa [hemendik](https://github.com/ideckia/mobile_client/releases) deskargatu eta instalatu.
* Mugikorreko aplikazioa abiarazi. Automatikoki bilatuko du ordenagailua sareko IP 192.168.1.0-255 tartean eta 8888 portuan.
 * Ez badu ordenagailutik erantzunik jasotzen, IP eta portua eskuz sartzeko pantaila erakutsiko du.
* Zure [layout-a](#layout-fitxategia) eskuz edo [editorea](#editorea) erabiliz edita dezakezu.

### Linux erabiltzaileak

#### Appindicator

Leiho gabeko aplikazio bat denez, sistemako erretiluan ikono bat erakusten du. Ideckia-k ikono hau erakusteko `libayatana-appindicator` liburutegia erabiltzen du. Ikonoa bistan ez badago ere aplikazioa martxan egon daiteke, baino feedback pixko bat izatea komeni da.

Liburutegi hau Ubuntu eta deribatuetan defektuz egon behar luke instalatua.

Ez badago, komando honekin instala dezakezu:

`sudo apt install libayatana-appindicator3-1`

#### Komunikaziorako portua

Baliteke ordenagailuak eta bezeroak komunikatzeko erabiltzen duten portua sistema eragileak irekita ez izatea. Hori irekitzeko komando hau exekutatu:

`sudo ufw allow 8888/tcp comment 'Ideckiak erabiltzeko 8888 portua ireki'` (Ideckiak 8888 portua darabilela suposatuz)

## Kontzeptuak

* Layout: _item_ multzo bat.
* Item: _state_ bat edo gehiago izan ditzakeen elementua. Bezeroan klikagarria da.
* State: Itemaren egoeraren definizioa: text, textColor, bgColor, icon eta _action_ zerrenda bat.
* Action: Bezeroan botoia klikatzen denean ordenagailuan exekutatuko den ekintza (bat baino gehiago izan daiteke _state_ bakoitzean).

## Layout fitxategia

Item guztiak eta beraien ekintzak JSON fitxategi soil batean daude definituak. [Hemen](./layout.json) dago oinarrizko bat.

## Item

Bi item mota daude:

* ChangeDir: Item mota hau klikatzean `toDir` propietatean definitutako direktoriora joaten da. [Hemen](./layout.json#L81-L98) `_main_` izeneko direktoriora joanen litzateke.
* States: Item mota hau klikatzean `list` zerrendako uneko `state`ko ekintzak exekutatuko ditu. Ekintzen zerrenda hutsa edo null izan daiteke. Ekintzak exekutatu ondoren `list` zerrendako hurrengo elementuan jarriko da.
  * [Hemen](./layout.json#L29-L44) hasieran `working` testua erakutsiko du eta hondoa berdea izanen du. Klikatzean testua `not working` izatera eta hondoa gorria izatera pasatuko dira. Berriz klikatzean `working` eta horrela jarraituko du. Ez da ekintzarik exekutatuko.
  * [Hemen](./layout.json#L45-L65) `counter` ekintza exekutatuko da klikatzen den aldi bakoitzean.
  
### RichString

State-etako testuek tamaina, kolore edo estilo (lodia, etzana, azpimarratua) desberdinak izan ditzakete. Formatua `{transformer:aldatzeko testua}` da. Eta _transformer_ izan liteke:

* `b`: `aldatzeko testua` **lodia** izanen da.
* `i`: `aldatzeko testua` _etzana_ izanen da.
* `u`: `aldatzeko testua` azpimarratua izanen da.
* `color.colorName`: `aldatzeko testua`-k `colorName` kolorea izanen du.
* `size.fontSize`: `aldatzeko testua`-k `fontSize` tamaina izanen du.
* `emoji.unicode`: Aukera honek ez du `:` karaktererik, ez baitzaio testu bati aplikatzen. `unicode` balioa duen emojia bistaratuko du, hainbat balio jar daitezke komaz (`,`) banaturik. Adibidez, `emoji.1F919,1F3FC`.

Transformatzaileak kateatu daitezke, adibidez:

```javascript
Testu hau {b:{i:{u:lodia, etzana eta azpimarratua}}} da. Eta testu hau, berriz, {color.red:{size.50:gorriz koloreztatua eta HANDIA}}
```

### Elkarrizketa-koadroak

Ekintzek zerbitzariko elkarrizketa-koadroen sistema atzi dezakete. Elkarrizketa-koadroen sistema honen interfazea [API-an](https://github.com/ideckia/ideckia_api/blob/main/api/dialog/IDialog.hx) dago definiturik. [clialogs](https://github.com/ideckia/clialogs)-n oinarritutako inplementazio bat eskeintzen da ideckia-ren oinarrizko paketean, liburutegi [honen](https://github.com/ideckia/dialogs-clialogs) bidez. Inplementazio hau exekutagarriaren ondoko `dialogs` direktorioan dago, aplikazioak bertatik kargatuko baitu. Nahi adina pertsonalizatu daiteke, baita berri bat sortu ere.

### Audioak

Ekintzek zerbitzariko audio sistema atzi dezakete. Audio sistema honen interfazea [API-an](https://github.com/ideckia/ideckia_api/blob/main/api/media/IMediaPlayer.hx) dago definiturik. ideckia-ren oinarrizko paketean, liburutegi [honen](https://github.com/ideckia/mediaplayer-rust) bidez eskeintzen da. Inplementazio hau exekutagarriaren ondoko `media` direktorioan dago, aplikazioak bertatik kargatuko baitu. Nahi adina pertsonalizatu daiteke, baita berri bat sortu ere.

## Ekintzak

Ekintzen iturburuak `actions` karpetan daude eskuragarri defektuz (`app.props` fitxategian konfiguragarri). Ekintza bakoitza bere direktorioan dago definitua eta `index.js` fitxategi bat du bertan.

`index.js` fitxategi honek [egitura hau](https://github.com/ideckia/ideckia_api#action-structure) izan behar du, ordenagailuko aplikazioak kargatu eta exekutatu ahal izateko.

```
|-- ideckia
|-- app.props
|-- layout.json
|-- actions
|   |-- my_action
|       |-- index.js
|   |-- another_action
|       |-- index.js
|       |-- dependencies.js
|       |-+ node_modules
```
### Defektuzko ekintzak

* [Command](https://github.com/ideckia/action_command): Aplikazio bat edo shell fitxategia exekutatzen du emandako parametroekin
* [Keymouse](https://github.com/ideckia/action_keymouse): **DEPRECATED** Laster-teklak sortu, hitzak idatzi, xagua mugitu... [RobotJs](http://robotjs.io/) erabiliz.
* [Keyboard](https://github.com/ideckia/action_keyboard): Laster-teklak sortu, hitzak idatzi... [NutJs](http://nutjs.dev/) erabiliz.
* [Counter](https://github.com/ideckia/action_counter): Itema zenbatetan klikatu den kontatu. Atzerakontaketa ere posible da.
* [Random color](https://github.com/ideckia/action_random-color): Ausazko kolore bat sortu eta botoiean erakutsi.
* [Stopwatch](https://github.com/ideckia/action_stopwatch): Ekintza hau exekutatzean, botoian bertan erakutsiko den tenporizadore bat hasi edo pausatuko da.
* [OBS-websocket](https://github.com/ideckia/action_obs-websocket): **DEPRECATED** Websocket bidez OBS kontrolatzeko. [obs-websocket-js](https://www.npmjs.com/package/obs-websocket-js) erabiliz.
* [Timezones](https://github.com/ideckia/action_timezones): Konfiguratutako lekuetan den ordua erakutsi.
* [Worklog](https://github.com/ideckia/action_worklog): Zure eguneroko lana JSON fitxategi batean antolatu eta gordetzeko.
* [FTP-Connect](https://github.com/ideckia/action_ftp-connect): Modu sinple eta azkarrean FTP batean konektatu.
* [SSH-Connect](https://github.com/ideckia/action_ssh-connect): Modu sinple eta azkarrean SSH batean konektatu.
* [Open weather](https://github.com/ideckia/action_open-weather): Konfiguratutako herrietako eguraldia erakutsi.
* [Clementine control](https://github.com/ideckia/action_clementine-control): **DEPRECATED** [Clementine](https://www.clementine-player.org/) kontrolatzeko.
* [Mute mic](https://github.com/ideckia/action_mute-mic): Mikrofonoa mututu eta berriro martxan jartzeko.
* [Toot](https://github.com/ideckia/action_toot): Mastodon-en toot bat publikatzeko.
* [Wait](https://github.com/ideckia/action_wait): Hurrengo ekintza exekutatu arte agindutako denbora itxaroten du.
* [Countdown](https://github.com/ideckia/action_countdown): Atzera kontaketa
* [Log-in](https://github.com/ideckia/action_log-in): Erabiltzaile izena eta pasahitza idatzi ondoren 'Sartu' sakatzen du (ekintza honek [Keyboard](https://github.com/ideckia/action_keyboard) erabiltzen du, derrigorrezkoa da).
* [Color-picker](https://github.com/ideckia/action_color-picker): Xagua dagoen pixelaren kolorea erakusten da item-ean.
* [Obs-control](https://github.com/ideckia/action_obs-control): Kontrolatu OBS Studio (aurretik zegoen [obs-websocket action](https://github.com/ideckia/action_obs-websocket) ordezkatzeko)
* [KeePassXC](https://github.com/ideckia/action_keepassxc): Erabiltzaile izen eta pasahitz guztiak hartzen ditu [KeePassXC](https://keepassxc.org/) datu base batetik. DBko sarrera bakoitzarekin bezeroan elementu klikagarri bat sortuko da. Ekintza honek [Log-in](https://github.com/ideckia/action_log-in) erabiltzen du, derrigorrezkoa da.
* [Emoji](https://github.com/ideckia/action_emoji): Ausazko emojiak erakusten dira sakatzen den bakoitzean
* [Memory](https://github.com/ideckia/action_memory): Memoria joko klasikoa zure bezeroan
* [system-info](https://github.com/ideckia/action_system-info/): Sistemaren informazioa bistan izateko ([systeminformation](https://systeminformation.io)-ren eskutik)
* [nuclear-control](https://github.com/ideckia/action_nuclear-control/): Kontrolatu [nuclear musika programa](https://nuclear.js.org/)
* [spotube-control](https://github.com/ideckia/action_spotube-control/): Kontrolatu [spotube musika programa](https://github.com/KRTirtho/spotube)

Ez zaizkizu ekintza hauek gustatzen? Alda itzazu edo [zurea sortu](./tutorial/0_first_action/readme.eu.md) zure beharretara egokitzeko.

### Ekintzen aurredefinitutako propietateak

Ekintza bakoitzaren `index.js` fitxategiaren ondoan `presets.json` fitxategi bat egon daiteke. Ekintza horren aurredefinitutako propietateak gordeko dira bertan. Propietate hauek [editoreak](#editorea) kargatzeko erabiliko dira.

## Ideckia komandoak

### Zure ekintza propioa sortu

Ireki [editorea](http://localhost:8888/editor)
  * Sakatu `create new action` botoia
  * Zein txantilioietan oinarritu nahi duzu aukeratu. Oraingoz Haxe eta JavaScript daude.
  * Ekintzaren izena idatzi.
  * Ekintzaren deskripzio bat idatzi (aukeran).
  * Aukeratu duzun izenarekin direktorio berri bat sortuko da `actions` direktorioan, aukeratu duzun txantilioiaren fitxategiekin.
  * Ez ahantzi zure ekintzak [egitura hau](https://github.com/ideckia/ideckia_api#action-structure) izan behar duela.

### Layout-a gehitu

Exekutatu `ideckia --append-layout layout_berria.json` parametroan emandako layout-a gure uneko layout-ari gehitzeko.

### Direktorioak esportatu

Exekutatu `ideckia --export-dirs _main_,develop,gaming` `_main_`, `develop` eta `gaming` izeneko direktorioak `{proiektuaren erroa}/dirs.export.json` fitxategira esportatzeko.

## Editorea

Zure nabigatzailean helbide honetara jo [http://localhost:8888/editor](http://localhost:8888/editor) (portua zure ordenagailuko aplikazioa martxan dagoena izanen da, defektuz 8888).

### Editorea itzultzen

Ideckia-k ez du erabiltzaile interfaze izugarririk, baina duen hori edozein hizkuntzatara itzul daiteke. [Editorea](http://localhost:8888/editor) irekiz gero, 'Itzul nazazu!' botoi bat ikusiko duzu. Bertan klikatu eta ideckia-k ingeles itzulpen fitxategia utziko du `/path/to/ideckia/loc/your_locale_code_here.txt` bide honetan, nahi den bezala itzultzeko. Lehenengo eta behin, fitxategia berrizendatu beharko da itzuli nahi den hizkuntzaren kodearekin ('es_ES.txt' gaztelerarentzat, 'fr_FR.txt' frantsesarentzat...).

Itzulpena ikusi ahal izateko, kargatu nahi den hizkuntza adierazio behar zaio ideckia-ri. `app.props` fitxategiko `ideckia.locale=your_code` propietatea editatuz egin daiteke hori.

Oharra: Aplikazioaren mugak direla eta, sistemako erretiluko ikonoan dagoen menua itzulia ikusteko, aplikazioa berrabiarazi behar da itzulpena egin eta gero. Gainontzeko testuak editorea birkargatzean agertuko dira.

### Editorea pertsonalizatu

Web editorea bistaratzerakoan, Ideckia-k editorearen fitxategi bakoitza (`index.html`, `style.css` eta `app.js`) proiektuaren erroko `editor` direktorioan bilatzen du. Fitxategia ez bada existitzen, paketatutako aplikaziotik kargatzen da.

Fitxategiak modu honetan kargatuta, proiektuaren erroan `editor/style.css` fitxategi bat sortu eta editorearen itxura bakarrik aldatzeko aukera ematen du. Kasu horretan, `index.html` eta `app.js` fitxategiak aplikaziotik bertatik eta CSS fitxategia sortu berria hartuko da.

Edo editore berri bat sortu dezakezu hiru fitxategiak hutsetik sortuz :-).
