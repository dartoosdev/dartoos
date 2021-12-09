import 'dart:typed_data';

import 'radix.dart';

/// Octal text of a list of bytes.
const octBytes = OctOfBytes();

/// Octal text representation of bytes.
///
/// By default, the digits [0–7] are used as the octal symbols. Normally, these
/// characters are suitable for most cases; however, in some special
/// circumstances, it may be desirable to use different symbols. You can change
/// the octal symbols by setting the constructor parameter _codeUnits_ with
/// custom symbols.
class OctOfBytes implements BytesAsText {
  /// Octal text of a list of bytes.
  ///
  /// Each byte is represented by three digits. Examples:
  ///
  /// - a list of three bytes like _[0x01, 0x02, 0x0b]_ will be represented by
  /// the octal digits '001002013', where 001 => 0x01; 002 => 0x02; and 013 =>
  /// 0x0b.
  /// - a list whose content is _[0x00, 0x77, 0x48, 0xaa, 0xff]_ will be
  /// represented by the text '000167110252377', where: 000 => 0x00; 167 =>
  /// 0x77; 110 => 0x48; 252 => 0xaa; and 377 => 0xff.
  ///
  /// The [codeUnits] parameter is a fixed 256-element list that sets the
  /// characters to be used. Each element is an 3-byte wide group of UTF-8 code
  /// units. The order of the elements determines which symbols represent a
  /// byte. For example, if the first element is _0x303030_ (unicode for '000'),
  /// then any byte whose value is 0x00 (zero) will be printed as '000';
  /// likewise, if the second element is _0x303031_ (unicode for '001'), then
  /// bytes whose value is 0x01 (one) will be printed as '001'; finally, if the
  /// last element is _0x333737_ (unicode for '377'), then bytes whose value is
  /// 0xff₁₆ (377₈; 255₁₀; 11111111₂) will be printed as '377'.
  ///
  /// In summary: each byte is used as an index in the octal symbol lookup
  /// table.
  ///
  /// See also:
  /// - [list of unicode characters](https://en.wikipedia.org/wiki/List_of_Unicode_characters)
  const OctOfBytes({List<int> codeUnits = _octSymbols})
      : _codeUnits = codeUnits;

  // The source of characters.
  final List<int> _codeUnits;

  /// Text in octal notation of a list of bytes.
  ///
  /// Each byte is represented by three octal symbols. Normally, these symbols
  /// range from '000'(zero) up to '377'.
  @override
  String call(Uint8List bytes) {
    assert(_codeUnits.length == 256);
    final octCodes = ByteData(bytes.length * 3);
    for (var i = 0; i < bytes.length; ++i) {
      final trio = _codeUnits[bytes[i]];
      final base = i * 3;
      // sets the first octal symbol
      octCodes.setUint8(base, trio >> 16);
      // sets the remaining two octal symbols (the first one gets truncated).
      octCodes.setUint16(base + 1, trio);
    }
    return String.fromCharCodes(octCodes.buffer.asUint8List());
  }

  /// Unicode of 256 octal values (from '000₈' up to '377₈').
  static const _octSymbols = <int>[
    0x303030, // 0   '000'
    0x303031, // 1   '001'
    0x303032, // 2   '002'
    0x303033, // 3   '003'
    0x303034, // 4   '004'
    0x303035, // 5   '005'
    0x303036, // 6   '006'
    0x303037, // 7   '007'
    0x303130, // 8   '010'
    0x303131, // 9   '011'
    0x303132, // 10  '012'
    0x303133, // 11  '013'
    0x303134, // 12  '014'
    0x303135, // 13  '015'
    0x303136, // 14  '016'
    0x303137, // 15  '017'
    0x303230, // 16  '020'
    0x303231, // 17  '021'
    0x303232, // 18  '022'
    0x303233, // 19  '023'
    0x303234, // 20  '024'
    0x303235, // 21  '025'
    0x303236, // 22  '026'
    0x303237, // 23  '027'
    0x303330, // 24  '030'
    0x303331, // 25  '031'
    0x303332, // 26  '032'
    0x303333, // 27  '033'
    0x303334, // 28  '034'
    0x303335, // 29  '035'
    0x303336, // 30  '036'
    0x303337, // 31  '037'
    0x303430, // 32  '040'
    0x303431, // 33  '041'
    0x303432, // 34  '042'
    0x303433, // 35  '043'
    0x303434, // 36  '044'
    0x303435, // 37  '045'
    0x303436, // 38  '046'
    0x303437, // 39  '047'
    0x303530, // 40  '050'
    0x303531, // 41  '051'
    0x303532, // 42  '052'
    0x303533, // 43  '053'
    0x303534, // 44  '054'
    0x303535, // 45  '055'
    0x303536, // 46  '056'
    0x303537, // 47  '057'
    0x303630, // 48  '060'
    0x303631, // 49  '061'
    0x303632, // 50  '062'
    0x303633, // 51  '063'
    0x303634, // 52  '064'
    0x303635, // 53  '065'
    0x303636, // 54  '066'
    0x303637, // 55  '067'
    0x303730, // 56  '070'
    0x303731, // 57  '071'
    0x303732, // 58  '072'
    0x303733, // 59  '073'
    0x303734, // 60  '074'
    0x303735, // 61  '075'
    0x303736, // 62  '076'
    0x303737, // 63  '077'
    0x313030, // 64  '100'
    0x313031, // 65  '101'
    0x313032, // 66  '102'
    0x313033, // 67  '103'
    0x313034, // 68  '104'
    0x313035, // 69  '105'
    0x313036, // 70  '106'
    0x313037, // 71  '107'
    0x313130, // 72  '110'
    0x313131, // 73  '111'
    0x313132, // 74  '112'
    0x313133, // 75  '113'
    0x313134, // 76  '114'
    0x313135, // 77  '115'
    0x313136, // 78  '116'
    0x313137, // 79  '117'
    0x313230, // 80  '120'
    0x313231, // 81  '121'
    0x313232, // 82  '122'
    0x313233, // 83  '123'
    0x313234, // 84  '124'
    0x313235, // 85  '125'
    0x313236, // 86  '126'
    0x313237, // 87  '127'
    0x313330, // 88  '130'
    0x313331, // 89  '131'
    0x313332, // 90  '132'
    0x313333, // 91  '133'
    0x313334, // 92  '134'
    0x313335, // 93  '135'
    0x313336, // 94  '136'
    0x313337, // 95  '137'
    0x313430, // 96  '140'
    0x313431, // 97  '141'
    0x313432, // 98  '142'
    0x313433, // 99  '143'
    0x313434, // 100 '144'
    0x313435, // 101 '145'
    0x313436, // 102 '146'
    0x313437, // 103 '147'
    0x313530, // 104 '150'
    0x313531, // 105 '151'
    0x313532, // 106 '152'
    0x313533, // 107 '153'
    0x313534, // 108 '154'
    0x313535, // 109 '155'
    0x313536, // 110 '156'
    0x313537, // 111 '157'
    0x313630, // 112 '160'
    0x313631, // 113 '161'
    0x313632, // 114 '162'
    0x313633, // 115 '163'
    0x313634, // 116 '164'
    0x313635, // 117 '165'
    0x313636, // 118 '166'
    0x313637, // 119 '167'
    0x313730, // 120 '170'
    0x313731, // 121 '171'
    0x313732, // 122 '172'
    0x313733, // 123 '173'
    0x313734, // 124 '174'
    0x313735, // 125 '175'
    0x313736, // 126 '176'
    0x313737, // 127 '177'
    0x323030, // 128 '200'
    0x323031, // 129 '201'
    0x323032, // 130 '202'
    0x323033, // 131 '203'
    0x323034, // 132 '204'
    0x323035, // 133 '205'
    0x323036, // 134 '206'
    0x323037, // 135 '207'
    0x323130, // 136 '210'
    0x323131, // 137 '211'
    0x323132, // 138 '212'
    0x323133, // 139 '213'
    0x323134, // 140 '214'
    0x323135, // 141 '215'
    0x323136, // 142 '216'
    0x323137, // 143 '217'
    0x323230, // 144 '220'
    0x323231, // 145 '221'
    0x323232, // 146 '222'
    0x323233, // 147 '223'
    0x323234, // 148 '224'
    0x323235, // 149 '225'
    0x323236, // 150 '226'
    0x323237, // 151 '227'
    0x323330, // 152 '230'
    0x323331, // 153 '231'
    0x323332, // 154 '232'
    0x323333, // 155 '233'
    0x323334, // 156 '234'
    0x323335, // 157 '235'
    0x323336, // 158 '236'
    0x323337, // 159 '237'
    0x323430, // 160 '240'
    0x323431, // 161 '241'
    0x323432, // 162 '242'
    0x323433, // 163 '243'
    0x323434, // 164 '244'
    0x323435, // 165 '245'
    0x323436, // 166 '246'
    0x323437, // 167 '247'
    0x323530, // 168 '250'
    0x323531, // 169 '251'
    0x323532, // 170 '252'
    0x323533, // 171 '253'
    0x323534, // 172 '254'
    0x323535, // 173 '255'
    0x323536, // 174 '256'
    0x323537, // 175 '257'
    0x323630, // 176 '260'
    0x323631, // 177 '261'
    0x323632, // 178 '262'
    0x323633, // 179 '263'
    0x323634, // 180 '264'
    0x323635, // 181 '265'
    0x323636, // 182 '266'
    0x323637, // 183 '267'
    0x323730, // 184 '270'
    0x323731, // 185 '271'
    0x323732, // 186 '272'
    0x323733, // 187 '273'
    0x323734, // 188 '274'
    0x323735, // 189 '275'
    0x323736, // 190 '276'
    0x323737, // 191 '277'
    0x333030, // 192 '300'
    0x333031, // 193 '301'
    0x333032, // 194 '302'
    0x333033, // 195 '303'
    0x333034, // 196 '304'
    0x333035, // 197 '305'
    0x333036, // 198 '306'
    0x333037, // 199 '307'
    0x333130, // 200 '310'
    0x333131, // 201 '311'
    0x333132, // 202 '312'
    0x333133, // 203 '313'
    0x333134, // 204 '314'
    0x333135, // 205 '315'
    0x333136, // 206 '316'
    0x333137, // 207 '317'
    0x333230, // 208 '320'
    0x333231, // 209 '321'
    0x333232, // 210 '322'
    0x333233, // 211 '323'
    0x333234, // 212 '324'
    0x333235, // 213 '325'
    0x333236, // 214 '326'
    0x333237, // 215 '327'
    0x333330, // 216 '330'
    0x333331, // 217 '331'
    0x333332, // 218 '332'
    0x333333, // 219 '333'
    0x333334, // 220 '334'
    0x333335, // 221 '335'
    0x333336, // 222 '336'
    0x333337, // 223 '337'
    0x333430, // 224 '340'
    0x333431, // 225 '341'
    0x333432, // 226 '342'
    0x333433, // 227 '343'
    0x333434, // 228 '344'
    0x333435, // 229 '345'
    0x333436, // 230 '346'
    0x333437, // 231 '347'
    0x333530, // 232 '350'
    0x333531, // 233 '351'
    0x333532, // 234 '352'
    0x333533, // 235 '353'
    0x333534, // 236 '354'
    0x333535, // 237 '355'
    0x333536, // 238 '356'
    0x333537, // 239 '357'
    0x333630, // 240 '360'
    0x333631, // 241 '361'
    0x333632, // 242 '362'
    0x333633, // 243 '363'
    0x333634, // 244 '364'
    0x333635, // 245 '365'
    0x333636, // 246 '366'
    0x333637, // 247 '367'
    0x333730, // 248 '370'
    0x333731, // 249 '371'
    0x333732, // 250 '372'
    0x333733, // 251 '373'
    0x333734, // 252 '374'
    0x333735, // 253 '375'
    0x333736, // 254 '376'
    0x333737, // 255 '377'
  ];
}