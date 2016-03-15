/*
    Compilacion: g++ -std=c++98 -Wall -O3 -g ikjalgorithm.cpp -o $`(PROBLEM).out -pedantic  

    real   0m15.172s
    user    0m14.877s
    sys 0m0.248s
*/
#include <sstream>
#include <string>
#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

struct Result {
    vector< vector<int> > A;
    vector< vector<int> > B;
};

Result read(string filename) {
    vector< vector<int> > A, B;
    Result ab;
    string line;
    ifstream infile;
    infile.open (filename.c_str());

    int i = 0;
    while (getline(infile, line) &amp;&amp; !line.empty()) {
        istringstream iss(line);
        A.resize(A.size() + 1);
        int a, j = 0;
        while (iss >> a) {
            A[i].push_back(a);
            j++;
        }
        i++;
    }

    i = 0;
    while (getline(infile, line)) {
        istringstream iss(line);
        B.resize(B.size() + 1);
        int a;
        int j = 0;
        while (iss >> a) {
            B[i].push_back(a);
            j++;
        }
        i++;
    }

    infile.close();
    ab.A = A;
    ab.B = B;
    return ab;
}

vector< vector<int> > ikjalgorithm(vector< vector<int> > A, 
                                    vector< vector<int> > B) {
    int n = A.size();

    // initialise C with 0s
    vector<int> tmp(n, 0);
    vector< vector<int> > C(n, tmp);

    for (int i = 0; i < n; i++) {
        for (int k = 0; k < n; k++) {
            for (int j = 0; j < n; j++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    return C;
}

void printMatrix(vector< vector<int> > matrix) {
    vector< vector<int> >::iterator it;
    vector<int>::iterator inner;
    for (it=matrix.begin(); it != matrix.end(); it++) {
        for (inner = it->begin(); inner != it->end(); inner++) {
            cout << *inner;
            if(inner+1 != it->end()) {
                cout << "\t";
            }
        }
        cout << endl;
    }
}

int main (int argc, char* argv[]) {
    string filename;
    if (argc < 3) {
        filename = "2000.in";
    } else {
        filename = argv[2];
    }
    Result result = read (filename);
    vector< vector<int> > C = ikjalgorithm(result.A, result.B);
    printMatrix(C);
    return 0;
}