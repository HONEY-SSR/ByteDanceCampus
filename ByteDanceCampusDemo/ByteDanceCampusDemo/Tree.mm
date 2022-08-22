//
//  Tree.m
//  ByteDanceCampusDemo
//
//  Created by 不拿好成绩不改名 on 2022/8/22.
//

#import <Foundation/Foundation.h>
#include "C++.h"

const int N = 1000;

using namespace std;

struct Node
{
    char data;
    Node *lChild, *rChild;
};


void postOrder(Node *root)
{
    if (root == nullptr)
        return;

    postOrder(root->lChild);
    postOrder(root->rChild);
    cout << root->data;
}

int search(int num, char *in, int len)
{

    for (int i = 0; i < len; i++)
        if (in[i] == num)
            return i;
    return -1;
}

Node *msn(char *pre, char *in, int len)
{
    if (len <= 0)
        return NULL;
    Node *root;
    root = new Node;
    int index = search(*pre, in, len);
    root->data = *pre;
    root->lChild = msn(pre + 1, in, index);
    // root->lChild=msn(pre+1,in,index);
    root->rChild = msn(pre + index + 1, in + index + 1, len - index - 1);
    // root->rChild=msn(pre+index+1,in,len-index-1);
    return root;
}

int main()
{
    char *pre, *in;
    pre = new char[N];
    in = new char[N];
    cin >> pre;
    cin >> in;
    Node *root;
    root = msn(pre, in, strlen(in));
    postOrder(root);
    cout << endl;
    return 0;
}

