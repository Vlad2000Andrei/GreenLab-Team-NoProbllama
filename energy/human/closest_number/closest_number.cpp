#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

int cmp(int x,int y)
{
    return x<y;
}
int main() {
   vector<int> arr,temp;
   int i,n,diff,x;
    
    cin>>n;
    
    for(i=0;i<n;i++)
    {
        cin>>x;
        arr.push_back(x);
    }
    
    sort(arr.begin(),arr.end(),cmp);
    
    diff=arr[1]-arr[0];
    
    for(i=2;i<n;i++)
        if(diff>(arr[i]-arr[i-1]))
        {
            diff=arr[i]-arr[i-1];
            temp.clear();
            temp.push_back(arr[i-1]);
            temp.push_back(arr[i]);
        }
        else  if(diff==(arr[i]-arr[i-1]))
        {
            temp.push_back(arr[i-1]);
            temp.push_back(arr[i]);
        }
            
    for(i=0;i<temp.size();i++)
        cout<<temp[i]<<" ";
    
    
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */   
    return 0;
}