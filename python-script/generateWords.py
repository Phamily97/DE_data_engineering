import csv

from random_word import RandomWords

rw = RandomWords()

rwList = []

i = 0
while i < 100:
    rwList.append(rw.get_random_word())
    i += 1

with open('random-words.csv','w') as file:
    for l in rwList:
        file.write(l)
        file.write('\n')