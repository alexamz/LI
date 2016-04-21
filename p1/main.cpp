#include <iostream>
#include <vector>
#include <chrono>

using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

unsigned int numVars;
unsigned int numClauses;
unsigned int indexOfNextLitToPropagate;
unsigned int decisionLevel;
unsigned int decisions, propagations;

vector<vector<int>> clauses;
vector<int> model;
vector<int> modelStack;
vector<int> nAparitions;
vector<pair<vector<int>,vector<int>>> pointers; //first posit, second negat

void insertionSort();

void readClauses( ){
    // Skip comments
    char c = cin.get();
    while (c == 'c') {
        while (c != '\n') c = cin.get();
        c = cin.get();
    }
    // Read "cnf numVars numClauses"
    string aux;
    cin >> aux >> numVars >> numClauses;
    clauses.resize(numClauses);
    
    pointers.resize(numVars + 1);
    nAparitions.resize(numVars + 1);
    nAparitions.resize(numVars);
    
    for (int &i : nAparitions) i = 0;
    
    // Read clauses
    for (unsigned int i = 0; i < numClauses; ++i) {
        int lit;
        while (cin >> lit and lit != 0) {
            clauses[i].push_back(lit);
            
            if (lit > 0) {
                pointers[lit].first.push_back(i);
                ++nAparitions[lit-1];
            } else {
                pointers[-lit].second.push_back(i);
                ++nAparitions[-(lit+1)];
            }
        }
    }
}


int currentValueInModel(int lit){
    if (lit >= 0) return model[lit];
    else {
        if (model[-lit] == UNDEF) return UNDEF;
        else return 1 - model[-lit];
    }
}


void setLiteralToTrue(int lit){
    modelStack.push_back(lit);
    if (lit > 0) model[lit] = TRUE;
    else model[-lit] = FALSE;
}


bool propagateGivesConflict () {
    
    while ( indexOfNextLitToPropagate < modelStack.size() ) {
        
        int actuaLiteral = modelStack[indexOfNextLitToPropagate];
        
        ++indexOfNextLitToPropagate;
        
        int *p = NULL;
        int size = 0;
        
        if (actuaLiteral > 0) {
            size = pointers[actuaLiteral].second.size();
            p = &pointers[actuaLiteral].second[0];
        } else {
            size = pointers[-actuaLiteral].first.size();
            p = &pointers[-actuaLiteral].first[0];
        }
        
        for(int i = 0; i < size; ++i){
            bool someLitTrue = false;
            int numUndefs = 0;
            int lastLitUndef = 0;
            int actualClause = *(p + i);
            for (unsigned int k = 0; not someLitTrue and k < clauses[actualClause].size(); ++k){
                int val = currentValueInModel(clauses[actualClause][k]);
                if (val == TRUE) someLitTrue = true;
                else if (val == UNDEF){
                    ++numUndefs;
                    lastLitUndef = clauses[actualClause][k];
                }
            }
            if (not someLitTrue and numUndefs == 0) {
                ++nAparitions[abs(actuaLiteral) - 1];
                return true; // conflict! all lits false
            }
            else if (not someLitTrue and numUndefs == 1){
                setLiteralToTrue(lastLitUndef);
                ++propagations;
            }
        }
    }
    return false;
}


void backtrack(){
    unsigned int i = modelStack.size() -1;
    int lit = 0;
    
    while (modelStack[i] != 0){ // 0 is the DL mark
        lit = modelStack[i];
        model[abs(lit)] = UNDEF;
        modelStack.pop_back();
        --i;
    }
    
    // at this point, lit is the last decision
    modelStack.pop_back(); // remove the DL mark
    --decisionLevel;
    indexOfNextLitToPropagate = modelStack.size();
    setLiteralToTrue(-lit);  // reverse last decision
}

// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
    int pos  = 0;
    int max = -1;
    for(int i = 0; i < numVars; ++i) {
        if(nAparitions[i] > max and model[i + 1] == -1){
            max = nAparitions[i];
            pos = i + 1;
        }
    }
    return pos;
}

void checkmodel(){
    for (int i = 0; i < numClauses; ++i){
        bool someTrue = false;
        for (int j = 0; not someTrue and j < clauses[i].size(); ++j)
            someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
        if (not someTrue) {
            cout << "Error in model, clause is not satisfied:";
            for (int j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
            cout << endl;
            exit(1);
        }
    }
}

void swap (int &a, int &b) {
    int aux = b;
    b = a;
    a = aux;
}

int main(){
    readClauses(); // reads numVars, numClauses and clauses
    model.resize(numVars+1,UNDEF);
    indexOfNextLitToPropagate = 0;
    decisionLevel = 0;
    //sortVectors();
    
    // Take care of initial unit clauses, if any
    for (unsigned int i = 0; i < numClauses - 1; ++i)
        if (clauses[i].size() == 1) {
            int lit = clauses[i][0];
            int val = currentValueInModel(lit);
            if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
            else if (val == UNDEF) setLiteralToTrue(lit);
        }
    
    chrono::time_point<chrono::system_clock> start, end;
    start = chrono::system_clock::now();
    decisions = 0;
    // DPLL algorithm
    while (true) {
        while ( propagateGivesConflict() ) {
            if ( decisionLevel == 0) {
                end = chrono::system_clock::now();
                chrono::duration<double> elapsed_seconds = end - start;
                cout << "s UNSATISFIABLE" << endl;
                cout << "c " << decisions << " decisions" << endl;
                cout << "c " << elapsed_seconds.count() << " seconds total run time" << endl;
                cout << "c " << (propagations/elapsed_seconds.count()/1e6) << " megaprops/second" << endl;
                return 10;
            }
            backtrack();
        }
        int decisionLit = getNextDecisionLiteral();
        
        if (decisionLit == 0) {
            checkmodel();
            end = chrono::system_clock::now();
            chrono:: duration<double> elapsed_seconds = end - start;
            cout << "s SATISFIABLE" << endl;
            cout << "c " << decisions << " decisions" << endl;
            cout << "c " << elapsed_seconds.count() << " seconds total run time" << endl;
            cout << "c " << (propagations/elapsed_seconds.count()/1e6) << " megaprops/second" << endl;
            return 20;
        }
        // start new decision level:
        modelStack.push_back(0);  // push mark indicating new DL
        ++indexOfNextLitToPropagate;
        ++decisionLevel;
        ++decisions;
        setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
    }
}