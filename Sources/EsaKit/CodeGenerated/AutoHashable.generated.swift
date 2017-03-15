// Generated using Sourcery 0.5.8 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable trailing_whitespace line_length

private func combineHashes(_ hashes: [Int]) -> Int {
    return hashes.reduce(0, combineHashValues)
}

private func combineHashValues(_ initial: Int, _ other: Int) -> Int {
    #if arch(x86_64) || arch(arm64)
        let magic: UInt = 0x9e3779b97f4a7c15
    #elseif arch(i386) || arch(arm)
        let magic: UInt = 0x9e3779b9
    #endif
    var lhs = UInt(bitPattern: initial)
    let rhs = UInt(bitPattern: other)
    lhs ^= rhs &+ magic &+ (lhs << 6) &+ (lhs >> 2)
    return Int(bitPattern: lhs)
}

private extension Array where Element: Hashable {
    var hashValue: Int {
        var hash: Int = 0
        for i in self {
            hash ^= i.hashValue
        }
        return hash
    }
}

// MARK: - AutoHashable for classes, protocols, structs
// MARK: - Categories AutoHashable
extension Categories: Hashable {
    public var hashValue: Int {
        return combineHashes([count.hashValue, from.hashValue, to.hashValue, 0])
    }
}
// MARK: - Comment AutoHashable
extension Comment: Hashable {
    public var hashValue: Int {
        return combineHashes([id.hashValue, bodyMd.hashValue, bodyHTML.hashValue, createdAt.hashValue, updatedAt.hashValue, url.hashValue, createdBy.hashValue, stargazersCount.hashValue, star.hashValue, 0])
    }
}
// MARK: - Comments AutoHashable
extension Comments: Hashable {
    public var hashValue: Int {
        return combineHashes([comments.hashValue, page.hashValue, prevPage?.hashValue ?? 0, nextPage?.hashValue ?? 0, maxPerPage.hashValue, totalCount.hashValue, 0])
    }
}
// MARK: - EsaError AutoHashable
extension EsaError: Hashable {
    public var hashValue: Int {
        return combineHashes([error.hashValue, message.hashValue, 0])
    }
}
// MARK: - MemberUser AutoHashable
extension MemberUser: Hashable {
    public var hashValue: Int {
        return combineHashes([name.hashValue, screenName.hashValue, icon.hashValue, email.hashValue, postsCount.hashValue, 0])
    }
}
// MARK: - Members AutoHashable
extension Members: Hashable {
    public var hashValue: Int {
        return combineHashes([members.hashValue, page.hashValue, prevPage?.hashValue ?? 0, nextPage?.hashValue ?? 0, maxPerPage.hashValue, totalCount.hashValue, 0])
    }
}
// MARK: - MinimumUser AutoHashable
extension MinimumUser: Hashable {
    public var hashValue: Int {
        return combineHashes([name.hashValue, screenName.hashValue, icon.hashValue, 0])
    }
}
// MARK: - Post AutoHashable
extension Post: Hashable {
    public var hashValue: Int {
        return combineHashes([number.hashValue, name.hashValue, fullName.hashValue, wip.hashValue, bodyMd.hashValue, bodyHTML.hashValue, createdAt.hashValue, updatedAt.hashValue, message.hashValue, url.hashValue, tags.hashValue, category?.hashValue ?? 0, revisionNumber.hashValue, createdBy.hashValue, updatedBy.hashValue, kind.hashValue, commentsCount.hashValue, tasksCount.hashValue, doneTasksCount.hashValue, stargazersCount.hashValue, watchersCount.hashValue, star.hashValue, watch.hashValue, 0])
    }
}
// MARK: - Posts AutoHashable
extension Posts: Hashable {
    public var hashValue: Int {
        return combineHashes([posts.hashValue, page.hashValue, prevPage?.hashValue ?? 0, nextPage?.hashValue ?? 0, perPage?.hashValue ?? 0, maxPerPage.hashValue, totalCount.hashValue, 0])
    }
}
// MARK: - Response AutoHashable
extension Response: Hashable {
    public var hashValue: Int {
        return combineHashes([xRateLimitLimit.hashValue, XRateLimitRemaining.hashValue, 0])
    }
}
// MARK: - Stargazer AutoHashable
extension Stargazer: Hashable {
    public var hashValue: Int {
        return combineHashes([user.hashValue, createdAt.hashValue, body?.hashValue ?? 0, 0])
    }
}
// MARK: - Stargazers AutoHashable
extension Stargazers: Hashable {
    public var hashValue: Int {
        return combineHashes([stargazers.hashValue, page.hashValue, prevPage?.hashValue ?? 0, nextPage?.hashValue ?? 0, maxPerPage.hashValue, totalCount.hashValue, 0])
    }
}
// MARK: - Stats AutoHashable
extension Stats: Hashable {
    public var hashValue: Int {
        return combineHashes([members.hashValue, posts.hashValue, postsWip.hashValue, postsShipped.hashValue, comments.hashValue, stars.hashValue, dailyActiveUsers.hashValue, weeklyActiveUsers.hashValue, monthlyActiveUsers.hashValue, 0])
    }
}
// MARK: - Team AutoHashable
extension Team: Hashable {
    public var hashValue: Int {
        return combineHashes([name.hashValue, privacy.hashValue, description.hashValue, icon.hashValue, url.hashValue, 0])
    }
}
// MARK: - Teams AutoHashable
extension Teams: Hashable {
    public var hashValue: Int {
        return combineHashes([teams.hashValue, page.hashValue, prevPage?.hashValue ?? 0, nextPage?.hashValue ?? 0, maxPerPage.hashValue, totalCount.hashValue, 0])
    }
}
// MARK: - User AutoHashable
extension User: Hashable {
    public var hashValue: Int {
        return combineHashes([id.hashValue, name.hashValue, screenName.hashValue, createdAt.hashValue, updatedAt.hashValue, icon.hashValue, email.hashValue, 0])
    }
}
// MARK: - Watcher AutoHashable
extension Watcher: Hashable {
    public var hashValue: Int {
        return combineHashes([user.hashValue, createdAt.hashValue, 0])
    }
}
// MARK: - Watchers AutoHashable
extension Watchers: Hashable {
    public var hashValue: Int {
        return combineHashes([watchers.hashValue, page.hashValue, prevPage?.hashValue ?? 0, nextPage?.hashValue ?? 0, maxPerPage.hashValue, totalCount.hashValue, 0])
    }
}

// MARK: -
