#include <iostream>
#include <fstream>
#include <string>

void comparator_4bit_model(int a, int b, bool &gt, bool &lt, bool &eq) {
    gt = (a > b);
    lt = (a < b);
    eq = (a == b);
}

int main() {
    std::ifstream fisier_intrare("../data/intrari_test.txt");
    std::ofstream fisier_iesire("../data/rezultate_asteptate.txt");
    std::ofstream fisier_rezultate("../data/rezultate_usor_de_citit.txt");

    if (!fisier_intrare.is_open() || !fisier_iesire.is_open()) {
        std::cerr << "Eroare la deschiderea fisierelor!" << std::endl;
        return 1;
    }

    std::string text_A, text_B;
    int teste_efectuate = 0;

    while (fisier_intrare >> text_A >> text_B) {
        
        int A = std::stoi(text_A, nullptr, 2);
        int B = std::stoi(text_B, nullptr, 2);

        bool gt, lt, eq;
        comparator_4bit_model(A, B, gt, lt, eq);
        
        fisier_rezultate << text_A << "("<<A<<") " << text_B << "("<<B<<") | GT:" << gt << " LT:" << lt << " EQ:" << eq << std::endl;
        fisier_iesire << gt << " " << lt << " " << eq << std::endl;
        teste_efectuate++;
    }

    std::cout << "Modelul a procesat " << teste_efectuate << " teste in format binar!" << std::endl;
    
    fisier_intrare.close();
    fisier_iesire.close();
    
    return 0;
}