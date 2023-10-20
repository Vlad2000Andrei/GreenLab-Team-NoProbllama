def main():
    N = int(input())
    ar = sorted(list(map(int, str(input()).split())))
    prs = ''
    mini = pow(10, 7) + 1
    for i in range(1, N):
        diff = abs(ar[i-1] - ar[i])
        if (diff <= mini):
            if (diff < mini):
                prs = ''
            mini = diff
            prs += str(ar[i-1]) + ' ' + str(ar[i]) + ' '
    print (prs)

if __name__ == '__main__':
    main()