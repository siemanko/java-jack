n = int(raw_input())
arr = [ int(x) for x in raw_input().split(' ')]
viol1 = 0
viol2 = 0
arr.append(arr[0])
for i in range(n):
	if arr[i] > arr[i+1]:
		viol1 += 1
for i in range(n):
	if arr[i] < arr[i+1]:
		viol2 += 1
if viol1 <= 1 or viol2 <= 1:
	print 'TAK'
else:
	print 'NIE'
