class CountryMapper {
    
    let countries: [(name: String, code: String)] = NSLocale.isoCountryCodes.map { (code: String) -> (name: String, code: String) in
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let countryName = NSLocale(localeIdentifier: "en_US").displayName(forKey: .identifier, value: id) ?? "Country not found for code: \(code)"
        return (countryName, code)
    }
    
    var localCountryCodes: LocalCountryCode?
    
    init() {
        localCountryCodes = self.loadJson(fileName: "CountryCodes")
    }
    
    func findCountry(by jurisdiction: Jurisdiction) -> (name: String, code: String)? {
        return countries.first { (name, code) -> Bool in
            name.lowercased().removingWhitespaces() == jurisdiction.rawValue.lowercased().removingWhitespaces()
        }
    }
    
    func countryCodeAlpha2(from jurisdiction: Jurisdiction) -> String {
        return findCountry(by: jurisdiction)?.code ?? "Code not found for Jurisdiction: \(jurisdiction)"
    }
    
    func countryCodeAlpha3(from jurisdiction: Jurisdiction) -> String {
        guard let alpha2code = findCountry(by: jurisdiction)?.code else {
            return "Code not found for Jurisdiction: \(jurisdiction)"
        }
        
        return localCountryCodes?.first(where: {
            $0.alpha2 == alpha2code
        })?.alpha3 ?? "Code not found for Jurisdiction: \(jurisdiction)"
    }
    
    func countryCurrencyCode(from jurisdiction: Jurisdiction) -> String {
        guard let alpha2code = findCountry(by: jurisdiction)?.code else {
            return "Code not found for Jurisdiction: \(jurisdiction)"
        }
        
        return localCountryCodes?.first(where: {
            $0.alpha2 == alpha2code
        })?.currencyCode ?? "Code not found for Jurisdiction: \(jurisdiction)"
    }
    
    func countryName(from countryCode: String) -> String {
        return countries.first { (name, code) -> Bool in
            code.lowercased() == countryCode.lowercased()
        }?.name ?? "Country not found for code: \(countryCode)"
    }
    
    private func loadJson(fileName: String) -> LocalCountryCode? {
        let decoder = JSONDecoder()
        guard let url = Bundle.framework.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? decoder.decode(LocalCountryCode.self, from: data)
    }
}
