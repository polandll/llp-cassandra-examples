import csv

with open('output.txt', 'rb') as source:
  reader = csv.reader(source, delimiter=',', skipinitialspace = True)
  new_rows_list = []
  count = 0
  for row in reader:
    new_row = []
    count = count + 1
    if row[0] == 'BRAND2':
      answer1 = "B2-yes" 
    else:
      answer1 = "B2-no" 
    if row[0] == 'BRAND4':
      answer2 = "B4-yes" 
    else:
      answer2 = "B4-no" 
      
    new_row.append(count)
    new_row.append(answer1)
    new_row.append(answer2)
    new_rows_list.append(new_row)

with open('pyout.csv', 'wb') as finalout:
  writer = csv.writer(finalout, delimiter='|', quotechar='"', quoting = csv.QUOTE_ALL)
  writer.writerows( new_rows_list )
