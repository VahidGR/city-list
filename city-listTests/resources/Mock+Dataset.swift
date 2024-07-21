//
//  city_listTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import XCTest
@testable import city_list

final class city_listTests: XCTestCase {}

internal struct Dataset {
    
    internal static let sort_dataset_1: Sample<Array<String>> = .init(
        input: [
        "a",
        "f",
        "d",
        "b",
        "s",
        "ai",
        "pl",
        "r",
        ],
        output: [
            "a",
            "ai",
            "b",
            "d",
            "f",
            "pl",
            "r",
            "s"
        ]
    )
    
    struct Sample<Sequence: RandomAccessCollection> {
        let input: Sequence
        let output: Sequence
    }
    
    internal static let search_dataset_1 = ["ad", "art", "bird", "blood", "cell", "chest", "child", "church", "dad", "death", "depth", "desk", "dirt", "drawer", "fact", "flight", "gate", "gene", "girl", "hall", "hat", "height", "king", "lab", "lake", "law", "length", "loss", "love", "mall", "math", "meat", "mode", "mom", "mood", "news", "pie", "song", "soup", "steak", "thanks", "throat", "tooth", "town", "truth", "two", "wealth", "wife", "year", "youth"]
    
    internal static let search_large_dataset = ["aavehuwp", "aboe", "afxsxxil", "aikaqalkps", "aiy", "akd", "akirfbiwj", "alewgcvfk", "alhdyut", "antx", "apkjb", "apzwf", "aqtybk", "aqzhu", "ascrfpzjcp", "axbvxqlobz", "axnnmxrcvm", "ayl", "azgnyoc", "bajpng", "basos", "batf", "biwn", "bleyh", "bonfeke", "bqeqg", "bqvy", "btwkbbj", "cbkjbehq", "cblwb", "cbnk", "ceijd", "cercbxw", "cgou", "cgsjipi", "chxvdsehcm", "ciaxx", "cojun", "crqwt", "crxy", "cskmnfwk", "csp", "csqlaw", "csqzm", "cstv", "ctqzzs", "cueunk", "cvrjoov", "cvtigl", "cxmtzuemix", "czbnqm", "das", "dguxaetqsd", "dimfjzpgzd", "diopjjf", "dlsgzen", "dlyhgx", "dncokpquw", "dnvdzyfjzk", "drm", "dslbvyd", "dslzh", "dsttkgkyd", "dtcrlsl", "dwr", "dxiafpjqo", "dxkrscdlfd", "dxwgofz", "dxybyiwuuc", "dyekda", "dypafgi", "efrrlq", "ekmxfshu", "enmkyqba", "eqear", "erzzxe", "fclcjh", "fcnulug", "fdguvt", "fhbc", "fjnhn", "fkbkf", "fkta", "flhkfxvjr", "foxiflhyln", "fqbdr", "fqujemfwzr", "fqxvauur", "frsz", "fydq", "fziothpk", "gakw", "gfcy", "gfykkncao", "glncz", "glr", "glxfst", "gogadsl", "goqoboii", "gwaikfupb", "gwyuwfu", "gye", "gyzpahbj", "hcuv", "hcvsy", "hdohuwi", "hfr", "hjny", "hlqs", "hmfluica", "hmq", "hmslmxvc", "hrhyogdmw", "htsfglyjd", "hveapv", "hxe", "hxkhxjzgu", "idaae", "ifu", "igiaib", "ihftf", "ilavpezv", "ilhbjg", "ivb", "ivy", "ixikin", "ixqdnkuv", "iyq", "izs", "izsqta", "javiloq", "jbvch", "jbvizkc", "jeuxs", "jhovyvm", "jhzliff", "jjtf", "jnreya", "jpca", "jqji", "jrcfd", "jrdqp", "jxi", "jyasrl", "jzheo", "kgjplutld", "kihd", "kkcdtu", "kkkiwg", "kkziloord", "kmlijsgliy", "knqwfdrwg", "knudjl", "kouqym", "koyi", "krd", "kvwlny", "kwfwkf", "kxloup", "kyrmixxakr", "kzufhjj", "lbc", "lcbtcme", "lcolok", "ldtt", "ldyv", "lfcavidntz", "lgl", "liisauxoi", "lkzpu", "llplyk", "loltfzpm", "lsctdhra", "ltzl", "luwru", "lwzrpagh", "lxchfebzg", "lyhlirndvw", "mbqsl", "mdhjca", "mdixhv", "menvj", "menyzt", "mhprwlrh", "mhrnzfph", "mjdejjboam", "mnl", "mnuxdw", "mpanntvp", "mvels", "mwgh", "mzdvmbckcf", "mztwc", "nbpqgwkxs", "ncjsgqqwpr", "ncoowkbg", "ndm", "nenyjgplr", "ngaksvp", "npbnkdepbd", "nrfkcs", "nrr", "nva", "nvelx", "nyt", "nzekx", "odufh", "oeyyvybgu", "ogbbbtusyp", "ohtzhvj", "okqqqxtdlp", "olzvgowst", "ombaasbdff", "omimgge", "omxnauhc", "orhdngeu", "ornckjtl", "ostchvwig", "ozmopoz", "pabnizyhh", "pcprgf", "pcwft", "pgn", "phpgtmjfq", "pincw", "popb", "pssyqo", "pvzshpckn", "pxxcrruya", "qaau", "qalsskzupg", "qcnoef", "qeoiu", "qfeoxigq", "qfku", "qitx", "qjjchjc", "qkyypzqkzh", "qlha", "qlppm", "qmxarue", "qrb", "qrxa", "qugwzn", "qwhndexm", "qyc", "qzof", "rag", "rdb", "refbz", "rhvxbaik", "rja", "rmpcqrtfco", "rqdvolrw", "rszxe", "rtuqjcp", "rypfdvb", "sbdjc", "sbl", "sbzbyz", "scbapehwf", "sfibnvenm", "smowamplc", "snicpcdxbn", "stb", "sth", "suipu", "tciqn", "tdeudcv", "tdjr", "tdpgij", "tewozx", "thcp", "tiawn", "tkqnas", "tlacrd", "tpdnhw", "tqeuzw", "tqgil", "tqnegzoq", "tsrtynnp", "tvwwgob", "txnglewvby", "uadpoqebjr", "uagaqiido", "ubuz", "ucism", "udfjziurj", "udnivdzyaa", "uelv", "uffxra", "uflutq", "ugn", "unzcl", "upye", "urhnjpf", "usdzdaa", "uwrurph", "uxfvkfjd", "vaatbx", "vcczwkd", "vcyfdii", "viltjxyruf", "viuwgkaud", "vlhbzoj", "vnajnzbdgh", "vnk", "vpvey", "vqpnhr", "vthwaf", "vvhuu", "vwzucy", "vznifs", "wanvx", "wbe", "wcy", "wdux", "wfl", "wkjhfum", "wmrltoqkce", "wre", "wrn", "wrtq", "wrzz", "wwazcrncz", "wyfqnpv", "wylyawd", "wyxfuvjxu", "xavae", "xddeefsox", "xdifhq", "xexpfydqyu", "xhthcr", "xik", "xitvqezv", "xlzbsrugx", "xmebxbzb", "xna", "xplehat", "xqkcknocd", "xrealfaq", "xuqf", "xyqasebtjy", "xzzol", "ybiqpko", "ybzh", "ycivdij", "ycsnhtww", "yhke", "ymmmchxf", "ymq", "ynmxmefd", "ypnslb", "yqba", "ytfldevifk", "yyhl", "zai", "zcyzx", "zeprtlif", "zidjb", "zksyp", "zsguxhcdgx", "zsomflpyb", "zxrlm", "zzcvglnx"]
}

struct SearchableText<ComparisonResult>: BiAlgoComparable, Equatable {
    static func < (lhs: SearchableText<ComparisonResult>, rhs: SearchableText<ComparisonResult>) -> Bool {
        lhs.wrapped < rhs.wrapped
    }
    
    typealias Compared = String
    
    let wrapped: Compared
    
    func compare(against reference: String) -> ComparisonResult {
        let linear = filter(using: reference) as? ComparisonResult
        let binary = direction(against: reference) as? ComparisonResult
        guard let comparison = linear ?? binary else {
            fatalError("Comparison is supported only by linear and binary algorithms")
        }
        return comparison
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.wrapped == rhs.wrapped
    }
}

extension SearchableText: BinaryComparable {
    func direction(against reference: Compared) -> BinaryComaparison {
        if wrapped.starts(with: reference) {
            return .match
        }
        if wrapped < reference {
            return .left
        }
        return .right
    }
}

extension SearchableText: FilterComparable {
    func filter(using reference: String) -> Bool {
        wrapped.starts(with: reference)
    }
}

class MockedResource<Search: Explorer>: SearchableResources {
    typealias Element = SearchableText<Search.ComparisonResult>
    var list: Array<Element>
    
    var organizer: Organizer
    var explorer: Search
    
    init(organizer: Organizer, explorer: Search) {
        self.organizer = organizer
        self.explorer = explorer
        self.list = Dataset.search_large_dataset.map({ .init(wrapped: $0) })
    }
    
    func find(_ query: String) -> Array<Element> {
        explorer.search(list) { element in
            element.compare(against: query)
        }
    }
}

class MockResource<Search: Explorer, Element: BiAlgoComparable>: SearchableResources {
    func find(_ query: Element.Compared) -> Array<Element> {
        explorer.search(list) { element in
            element.compare(against: query) as! Search.ComparisonResult
        }
    }
    
    var list: Array<Element>
    
    var organizer: Organizer
    var explorer: Search
    
    init(organizer: Organizer, explorer: Search) {
        self.organizer = organizer
        self.explorer = explorer
        self.list = []
    }
}

typealias FileReaderMockedElement = BiAlgoComparable & Decodable

final class FileReaderMocked<Search: Explorer, Element: FileReaderMockedElement>: MockResource<Search, Element> {
    init(
        file resourceName: String,
        withExtension resourceExtension: String,
        subdirectory subpath: String? = nil,
        localization localizationName: String? = nil,
        into format: [Element].Type,
        bundle: Bundle
    ) throws {
        
        self.resourceName = resourceName
        self.resourceExtension = resourceExtension
        self.subpath = subpath
        self.localizationName = localizationName
        self.bundle = bundle
        
        super.init(organizer: Tools.standardLibrary(), explorer: Tools.standardLibrary() as! Search)
        
        _ = try read(file: resourceName, withExtension: resourceExtension, subdirectory: subpath, localization: localizationName, into: format, bundle: bundle)
    }
    
    
    private let resourceName: String
    private let resourceExtension: String
    private let subpath: String?
    private let localizationName: String?
    private let bundle: Bundle
    
    
}

extension String: CellRepresentable {
    public var id: Self { self }
    var title: String { self }
    var subtitle: String { "" }
}

extension SearchableText: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wrapped = try container.decode(String.self, forKey: CodingKeys.wrapped)
    }
    
    enum CodingKeys: String, CodingKey {
        case wrapped = "wrapped"
    }
}

let alphabet: [String] = [
    "q",
    "w",
    "e",
    "r",
    "t",
    "y",
    "u",
    "i",
    "o",
    "p",
    "a",
    "s",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "z",
    "x",
    "c",
    "v",
    "b",
    "n",
    "m",
]
