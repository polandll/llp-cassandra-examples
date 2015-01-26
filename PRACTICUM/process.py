import csv

with open('~/cassandra-example-code-LLP/PRACTICUM/output.txt', 'rb') as source:
  reader = csv.reader(source, delimiter='|')
  new_rows_list = []
  count = 0
  for row in reader:
    new_row = []
    count = count + 1
    if row[0] == 'BRAND2'
     if row[2] == 'TYPE2'
      answer = 'YES!' 
    
    new_row.append(count)
    new_row.append(answer)

with open('~/cassandra-example-code-LLP/PRACTICUM/pyout.csv', 'wb') as finalout:
  writer = csv.writer(finalout, delimiter='|', quotechar='"', quoting = csv.QUOTE_ALL)
  writer.writerows( new_rows_list )
