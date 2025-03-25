def followers(graph, user):
    """Returns a set of the followers of the given user, in the given graph"""
    return set(graph.neighbors(user))


def followers_of_followers(graph, user):
    """Returns a set of followers of followers of the given user, in the given graph.
    The result does not include the given user nor any of that user's followers.
    """
    user_followers = followers(graph, user)
    user_followers_of_followers = set()

    for follower in user_followers:
        user_followers_of_followers.update(followers(graph, follower) - user_followers)

    return user_followers_of_followers - {user}


def common_followers(graph, user1, user2):
    """Returns the set of followers that user1 and user2 have in common."""
    return followers(graph, user1).intersection(followers(graph, user2))


def number_of_common_followers_map(graph, user):
    """Returns a map from each user U to the number of followers U has in common with the given user.
    The map keys are the users who have at least one follower in common with the
    given user, and are neither the given user nor one of the given user's followers.
    Take a graph G for example:
        - A and B have two followers in common
        - A and C have one follower in common
        - A and D have one follower in common
        - A and E have no followers in common
        - A is followers with D
    number_of_common_followers_map(G, "A")  =>   { 'B':2, 'C':1 }
    """
    common_followers_map = {}
    user_followers = followers_of_followers(graph, user)

    for follower in user_followers:
        length = len(common_followers(graph, user, follower))
        if length >= 1:
            common_followers_map[follower] = length

    return common_followers_map


def number_map_to_sorted_list(follower_map):
    """Given a map whose values are numbers, return a list of the keys.
    The keys are sorted by the number they map to, from greatest to least.
    When two keys map to the same number, the keys are sorted by their
    natural sort order, from least to greatest.
    """
    return [v[0] for v in sorted(follower_map.items(), key=lambda kv: (-kv[1], kv[0]))]


def recommend(type, pref, graph, user):
    """Return a list of follower recommendations for the given user.
    The follower recommendation list consists of names of people in the graph
    who are not yet a follower of the given user.
    The order of the list is determined by the number of common followers.
    """
    return number_map_to_sorted_list(number_of_common_followers_map(graph, user))


def influence_map(graph, user):
    """Returns a map from each user U to the follower influence, with respect to the given user.
    The map only contains users who have at least one follower in common with U,
    and are neither U nor one of U's followers.
    See the assignment for the definition of follower influence.
    """
    user_followers_of_followers = followers_of_followers(graph, user)
    follower_influence_map = {}

    for follower in user_followers_of_followers:
        user_common_followers = common_followers(graph, user, follower)
        if len(user_common_followers) >= 1:
            follower_influence_map[follower] = sum(
                [1 / len(followers(graph, val)) for val in user_common_followers]
            )

    return follower_influence_map


def recommend_by_influence(graph, user):
    """Return a list of follower recommendations for the given user.
    The follower recommendation list consists of names of people in the graph
    who are not yet a follower of the given user.
    The order of the list is determined by the influence measurement.
    """
    return number_map_to_sorted_list(influence_map(graph, user))
