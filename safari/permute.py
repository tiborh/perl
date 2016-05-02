def permute(s):
    if len(s) == 0:
        return [[]]

    ret = [s[0:1] + x for x in permute(s[1:])]

    for i in range(1, len(s)):
        if s[i] == s[0]:
            continue
        s[0], s[i] = s[i], s[0]
        ret += [s[0:1] + x for x in permute(s[1:])]

    return ret

s = [0, 1, 2, 3]
for x in permute(s):
    print(x)
