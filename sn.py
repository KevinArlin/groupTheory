'''A simple calculator for computing products of elements of the symmetric group written in permutation form.'''

def writeout(f):
    orbits = []
    orbitMin = 1
    currentInput = 1
    while f(orbitMin) != None:
        orbit = []
        orbit.append(orbitMin)
        currentInput = f(orbitMin)
        while currentInput != orbitMin:
            orbit.append(currentInput)
            currentInput = f(currentInput)
        orbits.append(orbit)
        itsBeenUsed = 1
        flat = [item for sublist in orbits for item in sublist]
        while itsBeenUsed in flat:
            itsBeenUsed += 1
        orbitMin = itsBeenUsed
    return orbits

def writein(orbits):
    def newf(j):
        for orbit in orbits:
            for i in range(len(orbit)):
                if orbit[i] == j:
                    if i < len(orbit) - 1:
                        return orbit[i+1]
                    else:
                        return orbit[0]
    return newf

def compose(f,g):
    def fofg(j):
      if g(j) != None:
        return f(g(j))
    return fofg

def compose3(f,g,h):
    return compose(f,compose(g,h))

def inverse(f):
    def finv(j):
        i = 1
        while f(i) != None:
            if f(i) == j:
                return i
            i += 1
    return finv

def conjugate(f,g):
    return compose3(f,g,inverse(f))



f = writein([[1,2,3],[4,5],[6],[7]])
g = writein([[1,3,7],[2,6],[4],[5]])

'''checks = [ [[1],[234],[56],[7]],
           [[1],[234],[567]],
           [[1],[23465],[7]],
           [[1],[234675]],
           [[13],[24],[567]],
           [[13],[24],[56],[7]],
           [[13],[2465],[7]],
           [[13],[24675]],
           [[142],[3],[56],[7]],
           [[142],[3],[567]],
           [[14652],[3],[7]],
           [[146752],[3]] ]'''
sigma = writein([[3],[1,7,4,6,5,2]])
print(writeout(conjugate(sigma,f)))

(2\ 5\ 3\ 4)(6\ 11\ 14)(7\ 9\ 12)(8\ 10\ 13)(15\ 27\ 26\ 16\ 28\ 23\ 17\ 29\ 24\ 18\ 30\ 25)(19\ 20\ 21\ 22)
        
