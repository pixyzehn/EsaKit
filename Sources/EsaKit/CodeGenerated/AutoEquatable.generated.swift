// Generated using Sourcery 0.5.8 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable trailing_whitespace cyclomatic_complexity

private func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

private func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Categories AutoEquatable
extension Categories: Equatable {} 
public func == (lhs: Categories, rhs: Categories) -> Bool {
    guard lhs.count == rhs.count else { return false }
    guard lhs.from == rhs.from else { return false }
    guard lhs.to == rhs.to else { return false }
    return true
}
// MARK: - Comment AutoEquatable
extension Comment: Equatable {} 
public func == (lhs: Comment, rhs: Comment) -> Bool {
    guard lhs.id == rhs.id else { return false }
    guard lhs.bodyMd == rhs.bodyMd else { return false }
    guard lhs.bodyHTML == rhs.bodyHTML else { return false }
    guard lhs.createdAt == rhs.createdAt else { return false }
    guard lhs.updatedAt == rhs.updatedAt else { return false }
    guard lhs.url == rhs.url else { return false }
    guard lhs.createdBy == rhs.createdBy else { return false }
    guard lhs.stargazersCount == rhs.stargazersCount else { return false }
    guard lhs.star == rhs.star else { return false }
    return true
}
// MARK: - Comments AutoEquatable
extension Comments: Equatable {} 
public func == (lhs: Comments, rhs: Comments) -> Bool {
    guard lhs.comments == rhs.comments else { return false }
    guard lhs.page == rhs.page else { return false }
    guard compareOptionals(lhs: lhs.prevPage, rhs: rhs.prevPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.nextPage, rhs: rhs.nextPage, compare: ==) else { return false }
    guard lhs.maxPerPage == rhs.maxPerPage else { return false }
    guard lhs.totalCount == rhs.totalCount else { return false }
    return true
}
// MARK: - EsaError AutoEquatable
extension EsaError: Equatable {} 
public func == (lhs: EsaError, rhs: EsaError) -> Bool {
    guard lhs.error == rhs.error else { return false }
    guard lhs.message == rhs.message else { return false }
    return true
}
// MARK: - MemberUser AutoEquatable
extension MemberUser: Equatable {} 
public func == (lhs: MemberUser, rhs: MemberUser) -> Bool {
    guard lhs.name == rhs.name else { return false }
    guard lhs.screenName == rhs.screenName else { return false }
    guard lhs.icon == rhs.icon else { return false }
    guard lhs.email == rhs.email else { return false }
    guard lhs.postsCount == rhs.postsCount else { return false }
    return true
}
// MARK: - Members AutoEquatable
extension Members: Equatable {} 
public func == (lhs: Members, rhs: Members) -> Bool {
    guard lhs.members == rhs.members else { return false }
    guard lhs.page == rhs.page else { return false }
    guard compareOptionals(lhs: lhs.prevPage, rhs: rhs.prevPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.nextPage, rhs: rhs.nextPage, compare: ==) else { return false }
    guard lhs.maxPerPage == rhs.maxPerPage else { return false }
    guard lhs.totalCount == rhs.totalCount else { return false }
    return true
}
// MARK: - MinimumUser AutoEquatable
extension MinimumUser: Equatable {} 
public func == (lhs: MinimumUser, rhs: MinimumUser) -> Bool {
    guard lhs.name == rhs.name else { return false }
    guard lhs.screenName == rhs.screenName else { return false }
    guard lhs.icon == rhs.icon else { return false }
    return true
}
// MARK: - Post AutoEquatable
extension Post: Equatable {} 
public func == (lhs: Post, rhs: Post) -> Bool {
    guard lhs.number == rhs.number else { return false }
    guard lhs.name == rhs.name else { return false }
    guard lhs.fullName == rhs.fullName else { return false }
    guard lhs.wip == rhs.wip else { return false }
    guard lhs.bodyMd == rhs.bodyMd else { return false }
    guard lhs.bodyHTML == rhs.bodyHTML else { return false }
    guard lhs.createdAt == rhs.createdAt else { return false }
    guard lhs.updatedAt == rhs.updatedAt else { return false }
    guard lhs.message == rhs.message else { return false }
    guard lhs.url == rhs.url else { return false }
    guard lhs.tags == rhs.tags else { return false }
    guard compareOptionals(lhs: lhs.category, rhs: rhs.category, compare: ==) else { return false }
    guard lhs.revisionNumber == rhs.revisionNumber else { return false }
    guard lhs.createdBy == rhs.createdBy else { return false }
    guard lhs.updatedBy == rhs.updatedBy else { return false }
    guard lhs.kind == rhs.kind else { return false }
    guard lhs.commentsCount == rhs.commentsCount else { return false }
    guard lhs.tasksCount == rhs.tasksCount else { return false }
    guard lhs.doneTasksCount == rhs.doneTasksCount else { return false }
    guard lhs.stargazersCount == rhs.stargazersCount else { return false }
    guard lhs.watchersCount == rhs.watchersCount else { return false }
    guard lhs.star == rhs.star else { return false }
    guard lhs.watch == rhs.watch else { return false }
    return true
}
// MARK: - Posts AutoEquatable
extension Posts: Equatable {} 
public func == (lhs: Posts, rhs: Posts) -> Bool {
    guard lhs.posts == rhs.posts else { return false }
    guard lhs.page == rhs.page else { return false }
    guard compareOptionals(lhs: lhs.prevPage, rhs: rhs.prevPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.nextPage, rhs: rhs.nextPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.perPage, rhs: rhs.perPage, compare: ==) else { return false }
    guard lhs.maxPerPage == rhs.maxPerPage else { return false }
    guard lhs.totalCount == rhs.totalCount else { return false }
    return true
}
// MARK: - Response AutoEquatable
extension Response: Equatable {} 
public func == (lhs: Response, rhs: Response) -> Bool {
    guard lhs.xRateLimitLimit == rhs.xRateLimitLimit else { return false }
    guard lhs.XRateLimitRemaining == rhs.XRateLimitRemaining else { return false }
    return true
}
// MARK: - Stargazer AutoEquatable
extension Stargazer: Equatable {} 
public func == (lhs: Stargazer, rhs: Stargazer) -> Bool {
    guard lhs.user == rhs.user else { return false }
    guard lhs.createdAt == rhs.createdAt else { return false }
    guard compareOptionals(lhs: lhs.body, rhs: rhs.body, compare: ==) else { return false }
    return true
}
// MARK: - Stargazers AutoEquatable
extension Stargazers: Equatable {} 
public func == (lhs: Stargazers, rhs: Stargazers) -> Bool {
    guard lhs.stargazers == rhs.stargazers else { return false }
    guard lhs.page == rhs.page else { return false }
    guard compareOptionals(lhs: lhs.prevPage, rhs: rhs.prevPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.nextPage, rhs: rhs.nextPage, compare: ==) else { return false }
    guard lhs.maxPerPage == rhs.maxPerPage else { return false }
    guard lhs.totalCount == rhs.totalCount else { return false }
    return true
}
// MARK: - Stats AutoEquatable
extension Stats: Equatable {} 
public func == (lhs: Stats, rhs: Stats) -> Bool {
    guard lhs.members == rhs.members else { return false }
    guard lhs.posts == rhs.posts else { return false }
    guard lhs.postsWip == rhs.postsWip else { return false }
    guard lhs.postsShipped == rhs.postsShipped else { return false }
    guard lhs.comments == rhs.comments else { return false }
    guard lhs.stars == rhs.stars else { return false }
    guard lhs.dailyActiveUsers == rhs.dailyActiveUsers else { return false }
    guard lhs.weeklyActiveUsers == rhs.weeklyActiveUsers else { return false }
    guard lhs.monthlyActiveUsers == rhs.monthlyActiveUsers else { return false }
    return true
}
// MARK: - Team AutoEquatable
extension Team: Equatable {} 
public func == (lhs: Team, rhs: Team) -> Bool {
    guard lhs.name == rhs.name else { return false }
    guard lhs.privacy == rhs.privacy else { return false }
    guard lhs.description == rhs.description else { return false }
    guard lhs.icon == rhs.icon else { return false }
    guard lhs.url == rhs.url else { return false }
    return true
}
// MARK: - Teams AutoEquatable
extension Teams: Equatable {} 
public func == (lhs: Teams, rhs: Teams) -> Bool {
    guard lhs.teams == rhs.teams else { return false }
    guard lhs.page == rhs.page else { return false }
    guard compareOptionals(lhs: lhs.prevPage, rhs: rhs.prevPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.nextPage, rhs: rhs.nextPage, compare: ==) else { return false }
    guard lhs.maxPerPage == rhs.maxPerPage else { return false }
    guard lhs.totalCount == rhs.totalCount else { return false }
    return true
}
// MARK: - User AutoEquatable
extension User: Equatable {} 
public func == (lhs: User, rhs: User) -> Bool {
    guard lhs.id == rhs.id else { return false }
    guard lhs.name == rhs.name else { return false }
    guard lhs.screenName == rhs.screenName else { return false }
    guard lhs.createdAt == rhs.createdAt else { return false }
    guard lhs.updatedAt == rhs.updatedAt else { return false }
    guard lhs.icon == rhs.icon else { return false }
    guard lhs.email == rhs.email else { return false }
    return true
}
// MARK: - Watcher AutoEquatable
extension Watcher: Equatable {} 
public func == (lhs: Watcher, rhs: Watcher) -> Bool {
    guard lhs.user == rhs.user else { return false }
    guard lhs.createdAt == rhs.createdAt else { return false }
    return true
}
// MARK: - Watchers AutoEquatable
extension Watchers: Equatable {} 
public func == (lhs: Watchers, rhs: Watchers) -> Bool {
    guard lhs.watchers == rhs.watchers else { return false }
    guard lhs.page == rhs.page else { return false }
    guard compareOptionals(lhs: lhs.prevPage, rhs: rhs.prevPage, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.nextPage, rhs: rhs.nextPage, compare: ==) else { return false }
    guard lhs.maxPerPage == rhs.maxPerPage else { return false }
    guard lhs.totalCount == rhs.totalCount else { return false }
    return true
}

// MARK: -
