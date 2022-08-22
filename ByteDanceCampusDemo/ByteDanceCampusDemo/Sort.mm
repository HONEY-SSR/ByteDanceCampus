//
//  Sort.m
//  ByteDanceCampusDemo
//
//  Created by 不拿好成绩不改名 on 2022/8/22.
//

#import <Foundation/Foundation.h>
#include "C++.h"

using namespace std;

const int maxn=1e6+10;
int n;
int a[maxn];
int b[manx];

//选择排序：每次选出数组中的最小值并存储，直到数组中不存在元素
void sw(int a[],int n){
    for(int i=1;i<n;i++){
        int ith=i;
        for(int j = i+1;j <= n;j++){
            if(a[j]<a[ith]){
                ith=j;
            }
        }
        int t=a[i];
        a[i]=a[ith];
        a[ith]=t;
    }
}

//快速排序：任取数组中某个值，同时从左右两边扫描整个数组，再对左右两边的数进行递归
void quick_sort (int q[],int l,int r)
{
    if( l>=r ) return ;
    int x=q[(l+r+1)/2],i = l-1,j=r+1;
    while(i<j)
    {
        do i++; while(q[i]<x);
        do j--; while(q[j]>x);
        if (i<j)
        swap(q[i],q[j]);
    }
    quick_sort(q,l,i-1);
    quick_sort(q,i,r);
}

//堆排序：最小二叉堆
//----------堆排序------------
//对输入的heap数组在[low, high]范围内向下调整，调整为最小堆，即小的数在最上面
void downHeap(int low, int high){
    //i初始化为欲调整节点，j为其左孩子
    int i = low, j = i * 2;
    //如果还存在孩子节点则一直比较并调整
    while(j <= high){
        //如果右孩子存在且值比左孩子还小，那么就应该将右孩子向上调整
        if(j + 1 <= high && a[j+1] < a[j])
            j = j + 1;
        //当孩子的值比欲调整节点大时，则进行交换，保证小的数在上面
        if(a[j] < a[i]){
            swap(a[j], a[i]);
            //继续向下调整
            i = j;
            j = j * 2;
        }
        //如果欲调整节点的值已经比孩子都小则结束调整
        else
            break;
    }
}
//建堆操作
void createHeap(){
    //建堆从最后一个还具有孩子的节点开始，依次往前遍历到根结点，到最后便建立了最小堆
    for(int i = n / 2; i >= 1; i--){
        downHeap(i, n);
    }
}
//堆排序操作
void heapSort(){
    //首先建立初始最小堆
    createHeap();
    //从后遍历每一个元素，每次将最小元素放入到i位置，这样第一次最小放到n
    //第二次的最小则放入到n-1，第三次则会放入到n-2......
    for(int i = n; i > 1; i--){
        swap(a[i], a[1]);
        downHeap(1, i-1);
    }
}
//--------------------------------

int main()
{
    //输入数组
    cin>>n;
    for(int i = 1; i <= n; i++)cin>>a[i];
    
    //复制当前数组
    memcpy(b, a, sizeof(a));
    
    //选择排序
    sw(a,n);
    cout<<"选择排序结果："<<endl;
    for(int i = 1; i <= n; i++)cout<<a[i]<<" ";
    
    //还原
    memcpy(a, b, sizeof(b));
    
    //快速排序
    quick_sort(a,0,n-1);
    cout<<"快速排序结果："<<endl;
    for(int i = 1; i <= n; i++)cout<<a[i]<<" ";
    
    //还原
    memcpy(a, b, sizeof(b));
    
    //堆排序
    heapSort();
    cout<<"堆排序结果："<<endl;
    for(int i = 1;i<=n;i++)cout<<a[i]<<" ";
    
    return 0;
}
