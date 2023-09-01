func levenshteinDistance(_ s1: String, _ s2: String) -> Int {
    let empty = [Int](repeating: 0, count: s2.count)
    var last = [Int](0...s2.count)

    for (i, char1) in s1.enumerated() {
        var current = [i + 1] + empty
        for (j, char2) in s2.enumerated() {
            let edit: Int
            if char1 == char2 {
                edit = last[j]
            } else {
                edit = Swift.min(last[j], last[j + 1], current[j]) + 1
            }
            current[j + 1] = edit
        }
        last = current
    }
    return last.last!
}

let closestCountry = countries.min(by: { levenshteinDistance($0, predicate) < levenshteinDistance($1, predicate) })
